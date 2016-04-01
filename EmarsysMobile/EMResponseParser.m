//
//  EMResponseParser.m
//  EmarsysMobile
//

@import Foundation;

#import "EMResponseParser.h"
#import "EMRecommendationItem+EmarsysMobileExtensions.h"
#import "EMLogger.h"
#import "EMRecommendationResult+EmarsysMobileExtensions.h"
#import "EMError.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *, id> Map;

static NSError *newMissingFieldError(NSString *field) {
    NSString *msg =
        [NSString stringWithFormat:@"Missing '%@' parameter", field];
    DLOG(@"%@", msg)
    return [NSError errorWithDomain:EMErrorDomain
                               code:EMErrorMissingJSONParameter
                           userInfo:@{NSLocalizedDescriptionKey : msg}];
}

@implementation EMResponseParser

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

// Designated initializer.
- (nullable instancetype)initWithJSON:(NSDictionary *)json
                                error:(NSError *_Nullable *_Nullable)error {
    self = [super init];
    if (self) {

        DLOG(@"Parse json");
        DLOG(@"%@", json);

        // Get cohort
        NSString *cohort = json[@"cohort"];
        if (!cohort) {
            if (error) {
                *error = newMissingFieldError(@"cohort");
            }
            return nil;
        }
        _cohort = cohort;
        DLOG(@"Found cohort %@", _cohort);

        // Get visitor
        NSString *visitor = json[@"visitor"];
        if (!visitor) {
            if (error) {
                *error = newMissingFieldError(@"visitor");
            }
            return nil;
        }
        _visitor = visitor;
        DLOG(@"Found visitor %@", _visitor);

        // Get session
        NSString *session = json[@"session"];
        if (!session) {
            if (error) {
                *error = newMissingFieldError(@"session");
            }
            return nil;
        }
        _session = session;
        DLOG(@"Found session %@", _session);

        // Parse features
        Map *features = json[@"features"];
        DLOG(@"Found %i elements in the features",
             (int)[[features allKeys] count]);

        _results = [[NSMutableArray<EMRecommendationResult *> alloc] init];

        // Get schema
        NSArray<NSString *> *schema = json[@"schema"];
        DLOG(@"Found %i elements in the schema", (int)[schema count]);

        // Found schema, read products
        Map *products = json[@"products"];
        DLOG(@"Found %i elements in the products",
             (int)[[products allKeys] count]);

        // Iterate on the all features
        [features
            enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
              // Create next result
              EMRecommendationResult *result = [[EMRecommendationResult alloc]
                  initWithFields:_cohort
                       featureID:key
                           topic:obj[@"topicLabel"]];
              // Map items
              NSArray<Map *> *itemIndexes = obj[@"items"];
              // Iterate on the all indexes
              for (Map *itemIndex in itemIndexes) {
                  id itemIndexValue = [itemIndex objectForKey:@"id"];
                  // Get values for the index
                  NSArray<NSString *> *itemValues =
                      [products objectForKey:itemIndexValue];
                  EMRecommendationItem *item =
                      [[EMRecommendationItem alloc] initWithResult:result];
                  // Iterate on the all keys
                  [schema enumerateObjectsUsingBlock:^(
                              id object, NSUInteger idx, BOOL *stop) {
                    [item addField:object value:itemValues[idx]];
                  }];
                  [result addProduct:item];
              }

              DLOG(@"Created %i result in the feature %@",
                   (int)[result.products count], result.featureID);

              [_results addObject:result];
            }];

        DLOG(@"Created %i features", (int)[_results count]);
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
