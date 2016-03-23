//
//  EMIdentifierManager.m
//  EmarsysMobile
//

#import "EMIdentifierManager.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EMIdentifierManager

- (nullable instancetype)init {
    NSAssert(NO, @"Unavailable init methods was invoked");
    return nil;
}

- (instancetype)initInternal {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (EMIdentifierManager *)sharedManager {
    static EMIdentifierManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      _shared = [[EMIdentifierManager alloc] initInternal];
    });
    return _shared;
}

- (NSString *)advertisingIdentifier {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      if (![defaults objectForKey:@"advertisingID"]) {
          [defaults setObject:[NSUUID UUID].UUIDString forKey:@"advertisingID"];
          [defaults synchronize];
      }
    });
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"advertisingID"];
}

@end

NS_ASSUME_NONNULL_END
