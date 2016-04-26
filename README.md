#Emarsys Predict SDK for iOS

##Overview
This document describes the Emarsys Predict SDK for the iOS platform. It is intended for iOS mobile app developers who want to integrate Emarsys Web Extend or Predict Recommendations into native mobile app. The document describes the main Emarsys Predict SDK interface functions.
##Install
Minimum supported version is ***iOS8***

- You will need a valid product catalog, described here: http://documentation.emarsys.com/resource/b2c-cloud/web-extend/implementing-web-extend/#2
- Add EmarsysPredictSDK to your podfile to enable Emarsys Predict SDK
```
pod ‘EmarsysPredictSDK’
```
and run ‘pod install’

- Implement data collection in the application
- Implement recommendations

##Getting started

The semantics of each EmarsysPredictSDK function is documented in our JavaScript API.
There are two foundamental difference between the Javascript API and the iOS SDK:

- ***Click tracking:*** You should instantiate EMTransaction object with the initWithSelectedItemView method in objective c, or EMTransaction.init(item: EMRecommendationItem?) in swift, if the user selects a recommended item
- ***Rendering recommendations:*** We recommend to use a tableview or a collectionview for displaying the recommendations, and append/make the results from the recommendation to the data source, than reload the data to it.

You may filter down the live events on [console](https://console.scarabresearch.com/#/liveevents) for events only coming from iOS devices for developing/debugging purposes.

The ***Javascript API documentation*** lives here:

- [Data collection (Web Extend) ](http://documentation.emarsys.com/resource/b2c-cloud/web-extend/javascript-api/)
- [Recommendations](http://documentation.emarsys.com/resource/b2c-cloud/predict/implementation/delivering-web-recommendations/)

The interface documentation is [located here](http://cocoadocs.org/docsets/EmarsysPredictSDK/).

###Sample Code

We also created example applications for you to make it easier to implement Emarsys Predict SDK in your ecommerce application, they live [in this repository](https://github.com/scarabresearch/EmarsysMobileSamples).

We <3 open source software, that’s why we open sourced our Emarsys Predict SDK implementation. That way you can be confident that the library what you include contains only the code necessary to deliver awesome recommendations and also manage the data collection. [You find the repositiory here](https://github.com/scarabresearch/EmarsysPredictSDK).

##Copyright

Copyright 2016 Scarab Research Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

