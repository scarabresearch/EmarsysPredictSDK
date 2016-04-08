//
//  EmarsysPredictSDKTest.m
//  EmarsysPredictSDK
//

#import <XCTest/XCTest.h>
#import "EMSession.h"
#import "EMTransaction.h"
#import "EMCartItem.h"
#import "EMRecommendationResult.h"
#import "EMRecommendationRequest.h"

#define TIMEOUT dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC))

@interface EmarsysPredictSDKTest : XCTestCase

@end

@implementation EmarsysPredictSDKTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each
    // test method in the class.
    // These parts of our API should be implemented on ALL website pages
    EMSession *session = [EMSession sharedSession];
    session.logLevel = EMLogLevelDebug;
    // Identifies the merchant account (here the emarsys demo merchant
    // 1A65B5CB868AFF1E).
    // Replace it with your own Merchant ID before run.
    session.merchantID = @"1A74F439823D2CB4";
    session.logLevel = EMLogLevelDebug;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of
    // each
    // test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the
    // correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testERROR_MULTIPLE_CALL {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];

    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"112" price:80 quantity:2];
    NSArray *items = [NSArray arrayWithObjects:item_1, nil];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"172" price:159 quantity:1];
    NSArray *items2 = [NSArray arrayWithObjects:item_2, nil];

    [transaction setCart:items];
    [transaction setCart:items2];

    [transaction setCategory:@"book > literature > sci-fi"];
    [transaction setCategory:@"book > literature > horror"];

    [transaction setKeyword:@"sci-fi"];
    [transaction setKeyword:@"horror"];

    [transaction setPurchase:@"100" ofItems:items];
    [transaction setPurchase:@"101" ofItems:items2];

    [transaction setSearchTerm:@"great sci-fi classics"];
    [transaction setSearchTerm:@"great horror classics"];

    [transaction setView:@"112"];
    [transaction setView:@"172"];

    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    dispatch_semaphore_signal(sema);
                                  }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

- (void)testERROR_MULTIPLE_CALL_separated {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    id errorHandler = ^(NSError *_Nonnull error) {
      NSLog(@"%@", [error localizedDescription]);
      dispatch_semaphore_signal(sema);
    };

    EMTransaction *transaction = [[EMTransaction alloc] init];
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"112" price:80 quantity:2];
    NSArray *items = [NSArray arrayWithObjects:item_1, nil];
    EMCartItem *item_2 =
        [[EMCartItem alloc] initWithItemID:@"172" price:159 quantity:1];
    NSArray *items2 = [NSArray arrayWithObjects:item_2, nil];

    [transaction setCart:items];
    [transaction setCart:items2];
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:errorHandler];

    EMTransaction *transaction2 = [[EMTransaction alloc] init];
    [transaction2 setCategory:@"book > literature > sci-fi"];
    [transaction2 setCategory:@"book > literature > horror"];
    [[EMSession sharedSession] sendTransaction:transaction2
                                  errorHandler:errorHandler];

    EMTransaction *transaction3 = [[EMTransaction alloc] init];
    [transaction3 setKeyword:@"sci-fi"];
    [transaction3 setKeyword:@"horror"];
    [[EMSession sharedSession] sendTransaction:transaction3
                                  errorHandler:errorHandler];

    EMTransaction *transaction4 = [[EMTransaction alloc] init];
    [transaction4 setPurchase:@"100" ofItems:items];
    [transaction4 setPurchase:@"101" ofItems:items2];
    [[EMSession sharedSession] sendTransaction:transaction4
                                  errorHandler:errorHandler];

    EMTransaction *transaction5 = [[EMTransaction alloc] init];
    [transaction5 setSearchTerm:@"great sci-fi classics"];
    [transaction5 setSearchTerm:@"great horror classics"];
    [[EMSession sharedSession] sendTransaction:transaction5
                                  errorHandler:errorHandler];

    EMTransaction *transaction6 = [[EMTransaction alloc] init];
    [transaction6 setView:@"112"];
    [transaction6 setView:@"172"];
    [[EMSession sharedSession] sendTransaction:transaction6
                                  errorHandler:errorHandler];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

- (void)testInvalidMerchantID {
    [EMSession sharedSession].merchantID = @"";
    [[EMSession sharedSession]
        sendTransaction:[[EMTransaction alloc] init]
           errorHandler:^(NSError *_Nonnull error) {
             NSLog(@"%@", [error localizedDescription]);
             XCTAssertEqualObjects([error localizedDescription],
                                   @"The merchantID is required");
           }];

    EMTransaction *transaction = [[EMTransaction alloc] init];
    EMRecommendationRequest *recommend =
        [[EMRecommendationRequest alloc] initWithLogic:@"PERSONAL"];
    recommend.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      XCTFail();
    };
    [transaction recommend:recommend];
    [[EMSession sharedSession]
        sendTransaction:[[EMTransaction alloc] init]
           errorHandler:^(NSError *_Nonnull error) {
             NSLog(@"%@", [error localizedDescription]);
             XCTAssertEqualObjects([error localizedDescription],
                                   @"The merchantID is required");
           }];
}

- (void)testERROR_INVALID_ARG_empty_string {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    id errorHandler = ^(NSError *_Nonnull error) {
      NSLog(@"%@", [error localizedDescription]);
      dispatch_semaphore_signal(sema);
    };

    EMTransaction *transaction = [[EMTransaction alloc] init];
    EMCartItem *item_1 =
        [[EMCartItem alloc] initWithItemID:@"" price:80 quantity:2];
    NSArray *items = [NSArray arrayWithObjects:item_1, nil];

    [transaction setCart:items];
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:errorHandler];

    EMTransaction *transaction2 = [[EMTransaction alloc] init];
    [transaction2 setCategory:@""];
    [[EMSession sharedSession] sendTransaction:transaction2
                                  errorHandler:errorHandler];

    EMTransaction *transaction3 = [[EMTransaction alloc] init];
    [transaction3 setKeyword:@""];
    [[EMSession sharedSession] sendTransaction:transaction3
                                  errorHandler:errorHandler];

    EMTransaction *transaction4 = [[EMTransaction alloc] init];
    [transaction4 setPurchase:@"" ofItems:items];
    [[EMSession sharedSession] sendTransaction:transaction4
                                  errorHandler:errorHandler];

    EMTransaction *transaction5 = [[EMTransaction alloc] init];
    [transaction5 setSearchTerm:@""];
    [[EMSession sharedSession] sendTransaction:transaction5
                                  errorHandler:errorHandler];

    EMTransaction *transaction6 = [[EMTransaction alloc] init];
    [transaction6 setView:@""];
    [[EMSession sharedSession] sendTransaction:transaction6
                                  errorHandler:errorHandler];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

- (void)testTRACKING {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    // no filter, just get recs
    [transaction setView:@"172"];
    EMRecommendationRequest *recommend =
        [[EMRecommendationRequest alloc] initWithLogic:@"RELATED"];
    recommend.limit = 5;
    recommend.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"RELATED");
      if ([result.products count] > 0) {
          // Click the first item, open details page
          EMRecommendationItem *trackedItem = [result.products firstObject];
          // Add view
          EMTransaction *transaction2 =
              [[EMTransaction alloc] initWithItem:trackedItem];
          [transaction2 setView:[trackedItem.data objectForKey:@"item"]];
          // Add recommend
          EMRecommendationRequest *recommend2 =
              [[EMRecommendationRequest alloc] initWithLogic:@"ALSO_BOUGHT"];
          recommend2.completionHandler =
              ^(EMRecommendationResult *_Nonnull result) {
                // Process result
                NSLog(@"%@", result.featureID);
                XCTAssertEqualObjects(result.featureID, @"ALSO_BOUGHT");
                [result.products enumerateObjectsUsingBlock:^(
                                     EMRecommendationItem *_Nonnull obj,
                                     NSUInteger idx, BOOL *_Nonnull stop) {
                  NSLog(@"%@", obj);
                }];
                dispatch_semaphore_signal(sema);
              };
          [transaction2 recommend:recommend2];
          // Send
          [[EMSession sharedSession]
              sendTransaction:transaction2
                 errorHandler:^(NSError *_Nonnull error) {
                   NSLog(@"%@", [error localizedDescription]);
                   dispatch_semaphore_signal(sema);
                 }];
      } else {
          dispatch_semaphore_signal(sema);
      }
    };
    [transaction recommend:recommend];
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                    dispatch_semaphore_signal(sema);
                                  }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

- (void)testNonUniqueLogic {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    for (int i = 1; i < 11; i++) {
        NSString *logic = @"HOME_1";
        EMRecommendationRequest *recommend =
            [[EMRecommendationRequest alloc] initWithLogic:logic];
        recommend.completionHandler =
            ^(EMRecommendationResult *_Nonnull result) {
              XCTFail();
            };
        [transaction recommend:recommend];
    }
    // Firing the EmarsysPredictSDKQueue. Should be the last call on the page,
    // called
    // only once.
    [[EMSession sharedSession]
        sendTransaction:transaction
           errorHandler:^(NSError *_Nonnull error) {
             NSLog(@"%@", [error localizedDescription]);
             XCTAssertEqualObjects(
                 [error localizedDescription],
                 @"The recommend logic must be unique inner transaction");
             dispatch_semaphore_signal(sema);
           }];

    dispatch_semaphore_wait(sema, TIMEOUT);
}

- (void)testCATEGORY {
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:[NSArray array]];
    [transaction setCategory:@"Accessories"];
    EMRecommendationRequest *recommend =
        [[EMRecommendationRequest alloc] initWithLogic:@"CATEGORY"];
    recommend.completionHandler = ^(EMRecommendationResult *_Nonnull result) {
      // Process result
      NSLog(@"%@", result.featureID);
      XCTAssertEqualObjects(result.featureID, @"CATEGORY");
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

- (void)testAdvertisingIdentifier {
    EMTransaction *transaction = [[EMTransaction alloc] init];
    [transaction setCart:[NSArray array]];
    [[EMSession sharedSession] sendTransaction:transaction
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
    NSString *advertisingIdentifier = [EMSession sharedSession].advertisingID;
    XCTAssertNotNil(advertisingIdentifier);
    EMTransaction *transaction2 = [[EMTransaction alloc] init];
    [transaction2 setCart:[NSArray array]];
    [[EMSession sharedSession] sendTransaction:transaction2
                                  errorHandler:^(NSError *_Nonnull error) {
                                    NSLog(@"%@", [error localizedDescription]);
                                  }];
    XCTAssertEqual(advertisingIdentifier,
                   [EMSession sharedSession].advertisingID);
}

@end
