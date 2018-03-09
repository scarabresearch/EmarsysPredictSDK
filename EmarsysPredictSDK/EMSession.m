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

@import Foundation;

#import "EMSession+EmarsysPredictSDKExtensions.h"
#import "EMTransaction+EmarsysPredictSDKExtensions.h"
#import "NSString+EmarsysPredictSDKExtensions.h"
#import "EMResponseParser.h"
#import "EMIdentifierManager.h"
#import "EMLogger.h"
#import "EMError.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMSession ()

- (nullable NSURL *)generateGET:(EMTransaction *)transaction
                          error:(NSError *_Nullable *_Nonnull)error;

- (BOOL)handleCookies:(NSError *_Nullable *_Nonnull)error;

@property(readwrite, nullable) NSMutableArray<EMTransaction *> *transactions;
@property(readwrite) NSString *visitor;
@property(readwrite) NSString *session;

@end

@implementation EMSession

- (instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initInternal {
    self = [super init];
    if (self) {
        _logLevel = EMLogLevelError;
        _secure = YES;
    }
    return self;
}

+ (EMSession *)sharedSession {
    static EMSession *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _shared = [[EMSession alloc] initInternal];
    });
    return _shared;
}

- (void)sendTransaction:(EMTransaction *)transaction
           errorHandler:(void (^)(NSError *error))errorHandler {

    // Create get url
    NSError *error = nil;
    NSURL *url = [self generateGET:transaction error:&error];
    if (!url) {
        errorHandler(error);
        return;
    }
    DLOG(@"%@", url);

    // Completion handler for the request
    id completionHandler = ^(NSData *data, NSURLResponse *response,
                             NSError *error) {
      if (error) {
          errorHandler(error);
          return;
      }
      // Parse response
      NSError *err = nil;
      NSInteger code = ((NSHTTPURLResponse *)response).statusCode;
      if (code != 200) {
          NSString *message = [NSString
              stringWithFormat:@"Unexpected http status code %ld", (long)code];
          ELOG(@"%@", message);
          NSDictionary *d = @{NSLocalizedDescriptionKey : message};
          err = [NSError errorWithDomain:EMErrorDomain
                                    code:EMErrorBadHTTPStatus
                                userInfo:d];
          errorHandler(error);
          return;
      }
      // Find cdv
      if (![self handleCookies:&err]) {
          ELOG(@"Cookie cdv is ")
          errorHandler(err);
          return;
      };
      // Get json content
      NSDictionary<NSString *, id> *json =
          [NSJSONSerialization JSONObjectWithData:data
                                          options:NSJSONReadingAllowFragments
                                            error:&err];
      if (err) {
          errorHandler(err);
          return;
      }
      // Parse json
      EMResponseParser *parser =
          [[EMResponseParser alloc] initWithJSON:json error:&err];
      if (err) {
          errorHandler(err);
          return;
      }
      // Store session and visitor
      _session = parser.session;
      _visitor = parser.visitor;
      // Forward results
      [transaction handleResults:parser.results];
    };
    // Send get
    NSURLSessionConfiguration *conf =
        [NSURLSessionConfiguration defaultSessionConfiguration];
    [conf setHTTPAdditionalHeaders:@{
        @"User-Agent" : [NSString stringWithFormat:@"EmarsysPredictSDK|osversion:%@|platform:ios", [UIDevice currentDevice].systemVersion]
    }];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
    NSURLSessionDataTask *dataTask =
        [session dataTaskWithURL:url completionHandler:completionHandler];
    [dataTask resume];
}

- (nullable NSURL *)generateGET:(EMTransaction *)transaction
                          error:(NSError *_Nullable *_Nonnull)error {
    // Validate merchantID
    if (!_merchantID || [_merchantID length] == 0) {
        // The merchantID is required
        NSString *message =
            [NSString stringWithFormat:@"The merchantID is required"];
        ELOG(@"%@", message);
        NSDictionary *d = @{NSLocalizedDescriptionKey : message};
        if (error) {
            *error = [NSError errorWithDomain:EMErrorDomain
                                         code:EMErrorMissingMerchantID
                                     userInfo:d];
        }
        return nil;
    }
    // Serialize query
    NSString *query = [transaction serialize:error];
    if (!query) {
        return nil;
    }
    DLOG(@"%@", query);
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = _secure ? @"https" : @"http";
    components.host = @"recommender.scarabresearch.com";
    components.path = [NSString
        stringWithFormat:@"%@%@%@", @"/merchants/", _merchantID, @"/"];
    components.percentEncodedQuery = query;
    return [components URL];
}

- (nullable NSString *)advertisingID {
    return [[EMIdentifierManager sharedManager] advertisingIdentifier];
}

- (BOOL)handleCookies:(NSError *_Nullable *_Nonnull)error {
    DLOG(@"Find cookie, cdv");
    for (NSHTTPCookie *cookie in
         [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        NSString *name = [cookie name];
        NSString *value = [cookie value];
        if ([@"cdv" isEqualToString:name] && value) {
            DLOG(@"Found cookie, %@=%@", name, value);
            [[EMIdentifierManager sharedManager]
                setAdvertisingIdentifier:value];
            return YES;
        }
    }
    if (error) {
        NSString *msg = [NSString stringWithFormat:@"Missing 'cdv' cookie"];
        DLOG(@"%@", msg)
        *error = [NSError errorWithDomain:EMErrorDomain
                                     code:EMErrorMissingCDVCookie
                                 userInfo:@{NSLocalizedDescriptionKey : msg}];
    }
    return NO;
}

@end

NS_ASSUME_NONNULL_END
