//
//  EMSession.m
//  EmarsysMobile
//

@import Foundation;

#import "EMSession.h"
#import "EMTransaction+EmarsysMobileExtensions.h"
#import "NSString+EmarsysMobileExtensions.h"
#import "EMResponseParser.h"
#import "EMLogger.h"
#import "EMError.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMSession ()

- (nullable NSURL *)generateGET:(EMTransaction *)transaction
                          error:(NSError *_Nullable *_Nonnull)error;

@property(readwrite, nullable) NSMutableArray<EMTransaction *> *transactions;

@end

@implementation EMSession

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initInternal {
    self = [super init];
    if (self) {
        _logLevel = EMLogLevelError;
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
    id completionHandler =
        ^(NSData *data, NSURLResponse *response, NSError *error) {
          if (error) {
              errorHandler(error);
              return;
          }
          // Parse response
          NSError *err = nil;
          NSInteger code = ((NSHTTPURLResponse *)response).statusCode;
          if (code != 200) {
              NSString *message = [NSString
                  stringWithFormat:@"Unexpected http status code %li", code];
              ELOG(@"%@", message);
              NSDictionary *d = @{NSLocalizedDescriptionKey : message};
              err = [NSError errorWithDomain:EMErrorDomain
                                        code:EMErrorBadHTTPStatus
                                    userInfo:d];
              errorHandler(error);
              return;
          }
          // Get json content
          NSDictionary<NSString *, id> *json = [NSJSONSerialization
              JSONObjectWithData:data
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
          // Forward results
          [transaction handleResults:parser.results];
        };
    // Send get
    NSURLSession *session = [NSURLSession sharedSession];
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
        if (error)
            *error = [NSError errorWithDomain:EMErrorDomain
                                         code:EMErrorMissingMerchantID
                                     userInfo:d];
        return nil;
    }
    // Serialize query
    NSString *query = [transaction serialize:error];
    if (!query) {
        return nil;
    }
    DLOG(@"%@", query);
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"http";
    components.host = @"recommender.scarabresearch.com";
    components.path = [NSString
        stringWithFormat:@"%@%@%@", @"/merchants/", _merchantID, @"/"];
    components.query = query;
    return [components URL];
}

@end

NS_ASSUME_NONNULL_END
