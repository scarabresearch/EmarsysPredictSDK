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

# Hardfail on errors
set -e

if [ -n "$TRAVIS_TAG" ]; then
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
    echo "  spec.platform             = :ios, '8.0'" >> $PODSPEC_FILE
    echo "  spec.source               = { :git => 'https://github.com/scarabresearch/EmarsysPredictSDK.git', :tag => '$TRAVIS_TAG' }" >> $PODSPEC_FILE
    echo "  spec.source_files         = 'EmarsysPredictSDK/**/*.{h,m}'" >> $PODSPEC_FILE
    echo "  spec.public_header_files  = ['EmarsysPredictSDK/EmarsysPredictSDK.h', 'EmarsysPredictSDK/EMSession.h', 'EmarsysPredictSDK/EMError.h', 'EmarsysPredictSDK/EMTransaction.h', 'EmarsysPredictSDK/EMCartItem.h', 'EmarsysPredictSDK/EMRecommendationItem.h', 'EmarsysPredictSDK/EMRecommendationResult.h', 'EmarsysPredictSDK/EMRecommendationRequest.h']" >> $PODSPEC_FILE
    echo "end" >> $PODSPEC_FILE

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
