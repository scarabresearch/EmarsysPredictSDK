#!/bin/bash

#
# Copyright 2016 Scarab Research Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add ssh key
eval "$(ssh-agent -s)"
chmod 600 scripts/id_rsa
ssh-add scripts/id_rsa
ssh -o StrictHostKeyChecking=no git@github.com

# Hardfail on errors
set -e

echo "Cloning target repo..."
git clone --depth=1 ssh://github.com/scarabresearch/EmarsysPredictSDK-dist.git build-repo
cd build-repo

echo "Updating files..."
rm -rf EmarsysPredictSDK.framework
rm -rf LICENSE.txt
rm -rf NOTICE.txt
cp -R ../build/Release-iphoneos/EmarsysPredictSDK.framework ./
lipo ../build/Release-iphoneos/EmarsysPredictSDK.framework/EmarsysPredictSDK ../build/Release-iphonesimulator/EmarsysPredictSDK.framework/EmarsysPredictSDK -create -output EmarsysPredictSDK.framework/EmarsysPredictSDK
cp ../LICENSE.txt ./
cp ../NOTICE.txt ./
git add --all EmarsysPredictSDK.framework
git add LICENSE.txt
git add NOTICE.txt

echo "Configuring git"
git config user.name "Travis CI"
git config user.email "travis-ci@scarabresearch.com"

# Branch for tagged versions
export DIST_BRANCH_NAME="master"
if [ -n "$TRAVIS_TAG" ]; then
	echo "Branching for $TRAVIS_TAG..."
	git checkout -b "dist-$TRAVIS_TAG"
	export DIST_BRANCH_NAME="dist-$TRAVIS_TAG"

	export PODSPEC_FILE="EmarsysPredictSDK.podspec"

	echo "Creating podspec..."
	echo "  Podspec version/git branch: $TRAVIS_TAG"

	echo -n "" > $PODSPEC_FILE
	echo "Pod::Spec.new do |spec|" >> $PODSPEC_FILE
	echo "  spec.name                 = 'EmarsysPredictSDK'" >> $PODSPEC_FILE
	echo "  spec.version              = '$TRAVIS_TAG'" >> $PODSPEC_FILE
	echo "  spec.homepage             = 'http://documentation.emarsys.com/'" >> $PODSPEC_FILE
	echo "  spec.license              = 'Apache License, Version 2.0'" >> $PODSPEC_FILE
	echo "  spec.author               = { 'Scarab Research Ltd.' => 'dev@scarabresearch.com' }" >> $PODSPEC_FILE
	echo "  spec.summary              = 'Emarsys Predict and Web Extend iOS SDK'" >> $PODSPEC_FILE
	echo "  spec.platform             = :ios, '8.4'" >> $PODSPEC_FILE
 	echo "  spec.source               = { :git => 'https://github.com/scarabresearch/EmarsysPredictSDK-dist.git', :tag => '$TRAVIS_TAG' }" >> $PODSPEC_FILE
	echo "  spec.vendored_frameworks  = 'EmarsysPredictSDK.framework'" >> $PODSPEC_FILE
	echo "end" >> $PODSPEC_FILE

	git add "$PODSPEC_FILE"
fi

echo "Commiting..."
git commit -m "Build: $TRAVIS_BUILD_NUMBER" -m "Commit id: $TRAVIS_COMMIT ($TRAVIS_BRANCH)"

echo "Pushing..."
git push origin "$DIST_BRANCH_NAME"

if [ -n "$TRAVIS_TAG" ]; then
	echo "Tagging..."
	git tag "$TRAVIS_TAG"
	git push origin tag "$TRAVIS_TAG"
fi

# Exit if non-tagged
if [ -n "$TRAVIS_TAG" ]; then
	echo "Pushing to CocoaPods..."
	set +e

	echo "  Looking for rvm..."
	which rvm &> /dev/null
	if [ "$?" -ne 0 ]; then
		echo "rvm is not installed!"
		exit 1
	fi

	echo "  Looking for pod..."
	which pod &> /dev/null
	if [ "$?" -ne 0 ]; then
		echo "pod is not installed!"
		exit 1
	fi

	echo "  Sourcing rvm scripts..."
	set -e
	rvm use default 2>&1

	echo "  Pushing to trunk..."
	set +e
	pod trunk push 2>&1
	if [ "$?" -ne 0 ]; then
		echo "pod trunk push failed!"
		exit 1
	fi
fi
