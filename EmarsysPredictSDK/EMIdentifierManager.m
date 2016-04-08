//
//  EMIdentifierManager.m
//  EmarsysPredictSDK
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

- (void)setAdvertisingIdentifier:(NSString *)advertisingIdentifier {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:advertisingIdentifier forKey:@"advertisingID"];
    [defaults synchronize];
}

- (nullable NSString *)advertisingIdentifier {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"advertisingID"];
}

@end

NS_ASSUME_NONNULL_END
