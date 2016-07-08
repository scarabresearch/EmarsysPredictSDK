/*
 * Copyright 2016 Scarab Research Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "EMSession.h"
#import "EMTransaction.h"
#import "EMCartItem.h"
#import "EMRecommendationResult.h"
#import "EMRecommendationRequest.h"

#define TIMEOUT dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC))

@interface JSAPISamples : XCTestCase

@end

@implementation JSAPISamples

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each
    // test method in the class.

    // These parts of our API should be implemented on ALL website pages
    EMSession *session = [EMSession sharedSession];
    // Identifies the merchant account (here the emarsys demo merchant
    // 1A65B5CB868AFF1E).
    // Replace it with your own Merchant ID before run.
    session.merchantID = @"1A74F439823D2CB4";
    session.logLevel = EMLogLevelDebug;
    [EMSession sharedSession].secure = YES;
}

// http://jsfiddle.net/0xrprjrz/1/
- (void)test1 {
    // Identifying the visitor. This email is matched with contact DB.
    // As you can see in LIVE EVENTS, the email is hashed by our API
    [EMSession sharedSession].customerEmail = @"visitor@test-mail.com";

    // Passing on visitor's cart contents to feed cart abandonment campaigns
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"item_1" price:19.9 quantity:1];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"item_2" price:29.7 quantity:3];
    NSArray *items = [NSArray arrayWithObjects:item_1, item_2, nil];
    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:items];

    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
}

// http://jsfiddle.net/px15qkk4/
- (void)test2 {
    // The usual commands to identify visitors and report cart contents.
    [EMSession sharedSession].customerEmail = @"visitor@test-mail.com";
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"item_1" price:19.9 quantity:1];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"item_2" price:29.7 quantity:3];
    NSArray *items = [NSArray arrayWithObjects:item_1, item_2, nil];
    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:items];

    // Passing on item ID to report product view. Item ID should match the
    // value listed in the Product Catalog
    [transaction setView:@"item_3"];

    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
}

// http://jsfiddle.net/dwoympfa/
- (void)test3 {
    // The usual commands to identify visitors and report cart contents.
    [EMSession sharedSession].customerEmail = @"visitor@test-mail.com";
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"item_1" price:19.9 quantity:1];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"item_2" price:29.7 quantity:3];
    NSArray *items = [NSArray arrayWithObjects:item_1, item_2, nil];
    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:items];

    // Passing on the category path being visited.
    // Must match the 'category' values listed in the Product Catalog
    [transaction setCategory:@"Bikes > Road Bikes"];

    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
}

// http://jsfiddle.net/m3720jea/
- (void)test4 {
    // The usual commands to identify visitors and report cart contents.
    // Please note the empty cart values - remember to empty the cart on
    // purchase.
    [EMSession sharedSession].customerEmail = @"visitor@test-mail.com";
    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:[NSArray array]];

    // Passing on order details. The price values passed on here serve as the
    // basis of our revenue and revenue contribution reports.
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"item_1" price:19.9 quantity:1];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"item_2" price:29.7 quantity:3];
    NSArray *items = [NSArray arrayWithObjects:item_1, item_2, nil];
    [transaction setPurchase:@"231213" ofItems:items];

    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
}

// http://jsfiddle.net/scarabresearch/3Z3UQ/?utm_source=website&utm_medium=embed&utm_campaign=3Z3UQ
- (void)testPERSONAL {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    EMRecommendationRequest *recommend =
        [[EMRecommendationRequest alloc] initWithLogic:@"PERSONAL"];
    recommend.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      // Process result
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"PERSONAL");
      [result.products
          enumerateObjectsUsingBlock:^(EMRecommendationItem *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            NSLog(@"%@", obj);
          }];
      dispatch_semaphore_signal(sema);
    };
    [transaction recommend:recommend];

    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    dispatch_semaphore_signal(sema);
                                  }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

// http://jsfiddle.net/scarabresearch/82tk48fe/?utm_source=website&utm_medium=embed&utm_campaign=82tk48fe
- (void)testTOPICAL {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:[NSArray array]];
    for (int i = 1; i < 11; i++) {
        NSString *logic = [NSString stringWithFormat:@"%@%i", @"HOME_", i];
        EMRecommendationRequest *recommend =
            [[EMRecommendationRequest alloc] initWithLogic:logic];
        recommend.limit = 8;
        recommend.completionHandler =
            ^(EMRecommendationResult *_Nonnull result) {
              // Process result
              NSLog(@"%@", result.featureID);
              XCTAssertEqualObjects([result.featureID substringToIndex:5],
                                    @"HOME_");
              [result.products enumerateObjectsUsingBlock:^(
                                   EMRecommendationItem *_Nonnull obj,
                                   NSUInteger idx, BOOL *_Nonnull stop) {
                NSLog(@"%@", obj);
              }];
              // dispatch_semaphore_signal(sema);
            };
        [transaction recommend:recommend];
    }
    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    dispatch_semaphore_signal(sema);
                                  }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

// http://jsfiddle.net/scarabresearch/7PZCv/?utm_source=website&utm_medium=embed&utm_campaign=7PZCv
- (void)testEXCLUDEINCLUDE {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    // no filter, just get recs
    [transaction setView:@"172"];
    EMRecommendationRequest *recommend =
        [[EMRecommendationRequest alloc] initWithLogic:@"RELATED"];
    recommend.limit = 5;
    recommend.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      // Process result
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"RELATED");
      [result.products
          enumerateObjectsUsingBlock:^(EMRecommendationItem *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            NSLog(@"%@", obj);
          }];
      // dispatch_semaphore_signal(sema);
    };
    [transaction recommend:recommend];
    EMSession *session = [EMSession sharedSession];
    [session sendTransaction:transaction
                errorHandler:^(NSError *_Nonnull error) {
                  NSLog(@"%@", [error localizedDescription]);
                  dispatch_semaphore_signal(sema);
                }];

    // do not recommend items '204' and '185'
    EMTransaction *transaction2 = [[EMTransaction alloc] init];
    EMRecommendationRequest *recommend2 =
        [[EMRecommendationRequest alloc] initWithLogic:@"RELATED_2"];
    [recommend2 excludeItemsWhere:@"item"
                             isIn:[NSArray<NSString *>
                                      arrayWithObjects:@"204", @"185", nil]];
    recommend2.limit = 3;
    recommend2.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      // Process result
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"RELATED_2");
      [result.products
          enumerateObjectsUsingBlock:^(EMRecommendationItem *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            NSLog(@"%@", obj);
          }];
      // dispatch_semaphore_signal(sema);
    };
    [transaction2 recommend:recommend2];
    [transaction2 setView:@"172"];
    [session sendTransaction:transaction2
                errorHandler:^(NSError *_Nonnull error) {
                  NSLog(@"%@", [error localizedDescription]);
                  dispatch_semaphore_signal(sema);
                }];

    // only recommend a certain category
    EMTransaction *transaction3 = [[EMTransaction alloc] init];
    EMRecommendationRequest *recommend3 =
        [[EMRecommendationRequest alloc] initWithLogic:@"RELATED_3"];
    [recommend3 includeItemsWhere:@"category" has:@"Root Catalog>Handbags"];
    recommend3.limit = 3;
    recommend3.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      // Process result
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"RELATED_3");
      [result.products
          enumerateObjectsUsingBlock:^(EMRecommendationItem *_Nonnull obj,
                                       NSUInteger idx, BOOL *_Nonnull stop) {
            NSLog(@"%@", obj);
          }];
      // dispatch_semaphore_signal(sema);
    };
    [transaction3 recommend:recommend3];
    [transaction3 setView:@"172"];
    [session sendTransaction:transaction3
                errorHandler:^(NSError *_Nonnull error) {
                  NSLog(@"%@", [error localizedDescription]);
                  dispatch_semaphore_signal(sema);
                }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

@end
