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

#import "EMTransaction+EmarsysPredictSDKExtensions.h"
#import "NSArray+EmarsysPredictSDKExtensions.h"
#import "NSString+EmarsysPredictSDKExtensions.h"
#import "EMRecommendationRequest+EmarsysPredictSDKExtensions.h"
#import "EMLogger.h"
#import "EMAvailabilityZoneCommand.h"
#import "EMSession+EmarsysPredictSDKExtensions.h"
#import "EMQueryParams.h"
#import "EMCartCommand.h"
#import "EMPurchaseCommand.h"
#import "EMErrorParameter.h"
#import "EMViewCommand.h"
#import "EMCategoryCommand.h"
#import "EMKeywordCommand.h"
#import "EMSearchTermCommand.h"
#import "EMRecommendCommand.h"
#import "EMError.h"
#import "EMIdentifierManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMTransaction ()

@property(readwrite, nullable) EMRecommendationItem *trackedItem;
@property(readwrite) NSMutableArray<EMErrorParameter *> *errors;

@property(readwrite) NSMutableArray<EMCartCommand *> *carts;
@property(readwrite)
    NSMutableArray<EMAvailabilityZoneCommand *> *availabilityZones;
@property(readwrite) NSMutableArray<EMCategoryCommand *> *categories;
@property(readwrite) NSMutableArray<EMKeywordCommand *> *keywords;
@property(readwrite) NSMutableArray<EMPurchaseCommand *> *purchases;
@property(readwrite) NSMutableArray<EMSearchTermCommand *> *searchTerms;
@property(readwrite) NSMutableArray<EMViewCommand *> *views;
@property(readwrite) NSMutableArray<EMRecommendCommand *> *recommends;
@property(readwrite)
    NSMutableDictionary<NSString *, void (^)(EMRecommendationResult *)>
        *handlers;

- (void)validateCommandArray:(NSArray<EMCommand *> *)container
                     command:(NSString *)command;
- (BOOL)validateCommands:(NSError *_Nullable *_Nonnull)error;

@end

@implementation EMTransaction

+ (instancetype)transactionWithItem:(nullable EMRecommendationItem *)item {
    return [[EMTransaction alloc] initWithSelectedItemView:item];
}

- (instancetype)initWithSelectedItemView:(nullable EMRecommendationItem *)item {
    self = [self init];
    if (self) {
        _trackedItem = item;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _errors = [[NSMutableArray<EMErrorParameter *> alloc] init];

        _availabilityZones =
            [[NSMutableArray<EMAvailabilityZoneCommand *> alloc] init];
        _carts = [[NSMutableArray<EMCartCommand *> alloc] init];
        _categories = [[NSMutableArray<EMCategoryCommand *> alloc] init];
        _keywords = [[NSMutableArray<EMKeywordCommand *> alloc] init];
        _purchases = [[NSMutableArray<EMPurchaseCommand *> alloc] init];
        _searchTerms = [[NSMutableArray<EMSearchTermCommand *> alloc] init];
        _views = [[NSMutableArray<EMViewCommand *> alloc] init];
        _recommends = [[NSMutableArray<EMRecommendCommand *> alloc] init];
        _handlers = [
            [NSMutableDictionary<NSString *, void (^)(EMRecommendationResult *)>
                alloc] init];
    }
    return self;
}

- (void)setAvailabilityZone:(NSString *)availabilityZone {
    EMAvailabilityZoneCommand *c =
        [[EMAvailabilityZoneCommand alloc] initWithValue:availabilityZone];
    [_availabilityZones addObject:c];
}

- (void)setCart:(NSArray<EMCartItem *> *)items {
    EMCartCommand *c = [[EMCartCommand alloc] initWithItems:items];
    [_carts addObject:c];
}

- (void)setCategory:(NSString *)category {
    EMCategoryCommand *c = [[EMCategoryCommand alloc] initWithValue:category];
    [_categories addObject:c];
}

- (void)setKeyword:(NSString *)keyword {
    EMKeywordCommand *c = [[EMKeywordCommand alloc] initWithValue:keyword];
    [_keywords addObject:c];
}

- (void)setPurchase:(NSString *)orderID ofItems:(NSArray<EMCartItem *> *)items {
    EMPurchaseCommand *c =
        [[EMPurchaseCommand alloc] initWithOrderID:orderID items:items];
    [_purchases addObject:c];
}

- (void)setSearchTerm:(NSString *)searchTerm {
    EMSearchTermCommand *c =
        [[EMSearchTermCommand alloc] initWithValue:searchTerm];
    [_searchTerms addObject:c];
}

- (void)setView:(NSString *)itemID {
    EMViewCommand *c =
        [[EMViewCommand alloc] initWithItemID:itemID trackedItem:_trackedItem];
    [_views addObject:c];
}

- (void)recommend:(EMRecommendationRequest *)request {
    EMRecommendCommand *c =
        [[EMRecommendCommand alloc] initWithEMRecommendationRequest:request];
    [_recommends addObject:c];
    NSString *key = request.logic;
    [_handlers setObject:request.completionHandler forKey:key];
}

- (void)validateCommandArray:(NSArray<EMCommand *> *)container
                     command:(NSString *)command {
    // Validate multiple calls
    if ([container count] > 1) {
        NSString *message = [NSString
            stringWithFormat:@"Multiple calls of %@ command", command];
        DLOG(@"%@", message);
        EMErrorParameter *error =
            [[EMErrorParameter alloc] initWithType:@"MULTIPLE_CALL"
                                           command:command
                                           message:message];
        [_errors addObject:error];
    }
    // Validate all commands in the array
    [container
        enumerateObjectsUsingBlock:^(EMCommand *_Nonnull obj, NSUInteger idx,
                                     BOOL *_Nonnull stop) {
          [_errors addObjectsFromArray:[obj validate]];
        }];
}

- (BOOL)validateCommands:(NSError *_Nullable *_Nonnull)error {
    // This commands must be unique
    [self validateCommandArray:_availabilityZones command:@"availabilityZone"];
    [self validateCommandArray:_keywords command:@"keyword"];
    [self validateCommandArray:_carts command:@"cart"];
    [self validateCommandArray:_categories command:@"category"];
    [self validateCommandArray:_purchases command:@"purchase"];
    [self validateCommandArray:_searchTerms command:@"searchTerm"];
    [self validateCommandArray:_views command:@"view"];
    // Validate recommends array
    if ([_recommends count] != [_handlers count]) {
        // The logic is not uniqe
        NSString *message = [NSString
            stringWithFormat:
                @"The recommend logic must be unique inner transaction"];
        ELOG(@"%@", message);
        NSDictionary *d = @{NSLocalizedDescriptionKey : message};
        if (error) {
            *error =
                [NSError errorWithDomain:EMErrorDomain
                                    code:EMErrorNonUniqueRecommendationLogic
                                userInfo:d];
        }
        return NO;
    }
    [_recommends
        enumerateObjectsUsingBlock:^(EMRecommendCommand *_Nonnull obj,
                                     NSUInteger idx, BOOL *_Nonnull stop) {
          [_errors addObjectsFromArray:[obj validate]];
        }];
    return YES;
}

- (nullable NSString *)serialize:(NSError *_Nullable *_Nonnull)error {
    EMQueryParams *params = [[EMQueryParams alloc] init];
    // Handle customerID
    EMSession *session = [EMSession sharedSession];
    NSString *customerID = [session customerID];
    if (customerID) {
        if (customerID.length == 0) {
            NSString *message =
                @"Invalid argument in customer command: customer "
                @"should not be an empty string";
            DLOG(@"%@", message);
            [_errors
                addObject:[[EMErrorParameter alloc] initWithType:@"INVALID_ARG"
                                                         command:@"customer"
                                                         message:message]];
        }
        [params add:@"ci" stringValue:customerID];
    }

    // Handle customerEmail
    NSString *customerEmail = [session customerEmail];
    if (customerEmail) {
        if (customerEmail.length == 0) {
            NSString *message =
                @"Invalid argument in email command: email should "
                @"not be an empty string";
            DLOG(@"%@", message);
            [_errors
                addObject:[[EMErrorParameter alloc] initWithType:@"INVALID_ARG"
                                                         command:@"email"
                                                         message:message]];
        }
        
        NSString *sha1 = [[[[[customerEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] sha1] lowercaseString] substringWithRange:NSMakeRange(0, 16)] stringByAppendingString:@"1"];
        
        [params add:@"eh" stringValue:sha1];
    }

    // Validate commands
    if (![self validateCommands:error]) {
        return nil;
    }

    // Handle keywords
    if ([_keywords count] > 0) {
        EMKeywordCommand *c = [_keywords lastObject];
        [params add:@"k" stringValue:[c description]];
    }

    // Handle availabilityZones
    if ([_availabilityZones count] > 0) {
        EMAvailabilityZoneCommand *c = [_availabilityZones lastObject];
        [params add:@"az" stringValue:[c description]];
    }

    // Handle carts
    if ([_carts count] > 0) {
        [params add:@"cv" intValue:1];
        EMCartCommand *c = [_carts lastObject];
        [params add:@"ca" stringValue:[c description]];
    }

    // Handle categories
    if ([_categories count] > 0) {
        EMCategoryCommand *c = [_categories lastObject];
        [params add:@"vc" stringValue:[c description]];
    }

    // Handle purchases
    if ([_purchases count] > 0) {
        EMPurchaseCommand *c = [_purchases lastObject];
        [params add:@"co" stringValue:[c description]];
        [params add:@"oi" stringValue:c.orderID];
    }

    // Handle recommends
    NSMutableArray<NSString *> *features =
        [[NSMutableArray<NSString *> alloc] init];
    NSMutableArray<NSString *> *baselines =
        [[NSMutableArray<NSString *> alloc] init];
    NSMutableArray<EMFilter *> *filters =
        [[NSMutableArray<EMFilter *> alloc] init];
    [_recommends
        enumerateObjectsUsingBlock:^(EMRecommendCommand *_Nonnull obj,
                                     NSUInteger idx, BOOL *_Nonnull stop) {
          // Accumulate features
          [features addObject:[obj.recommendationRequest description]];
          // Accumulate baselines
          if (obj.recommendationRequest.baseline) {
              NSString *pi = [NSString
                  stringWithFormat:@"%@%@", obj.recommendationRequest.logic,
                                   [obj.recommendationRequest.baseline
                                       serializeWithSeparator:@"|"]];
              [baselines addObject:pi];
          }
          // Accumulate filters
          [filters addObjectsFromArray:obj.recommendationRequest.filters];
        }];
    if ([features count] > 0) {
        // Append features
        [params add:@"f" stringValue:[features serializeWithSeparator:@"|"]];
    }
    if ([baselines count] > 0) {
        // Append baselines
        [baselines
            enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx,
                                         BOOL *_Nonnull stop) {
              [params add:@"pi" stringValue:obj];
            }];
    }
    if ([filters count] > 0) {
        // Append filters
        [params add:@"ex"
            stringValue:[NSString
                            stringWithFormat:@"[%@]",
                                             [filters
                                                 serializeWithSeparator:@","]]];
    }

    // Handle searchTerms
    if ([_searchTerms count] > 0) {
        EMSearchTermCommand *c = [_searchTerms lastObject];
        [params add:@"q" stringValue:[c description]];
    }

    // Handle views
    if ([_views count] > 0) {
        EMViewCommand *c = [_views lastObject];
        [params add:@"v" stringValue:[c description]];
    }

    // MAGIC
    [params add:@"cp" intValue:1];

    // Handle advertiserID
    NSString *advertisingIdentifier =
        [[EMIdentifierManager sharedManager] advertisingIdentifier];
    if (advertisingIdentifier) {
        [params add:@"vi" stringValue:advertisingIdentifier];
    }

    // Handle session
    NSString *sessionID = [session session];
    if (sessionID) {
        [params add:@"s" stringValue:sessionID];
    }

    // Append errors
    if ([_errors count] > 0) {
        [params add:@"error"
            stringValue:[NSString
                            stringWithFormat:@"[%@]",
                                             [_errors
                                                 serializeWithSeparator:@","]]];
    }

    return [params description];
}

- (void)handleResults:(NSArray<EMRecommendationResult *> *)results {
    [results enumerateObjectsUsingBlock:^(EMRecommendationResult *_Nonnull obj,
                                          NSUInteger idx, BOOL *_Nonnull stop) {
      NSString *key = obj.featureID;
      if (key) {
          void (^handler)(EMRecommendationResult *) = _handlers[key];
          if (handler) {
              DLOG(@"Found handler for result %@", key);
              handler(obj);
          } else {
              ELOG(@"Completion handler is missing for the feature %@, drop "
                   @"result",
                   key);
          }
      } else {
          DLOG(@"Transaction sent without recommend drop this result");
      }
    }];
}

@end

NS_ASSUME_NONNULL_END
