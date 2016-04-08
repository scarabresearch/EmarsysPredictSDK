//
//  EMErrorParameter.h
//  EmarsysPredictSDK
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface EMErrorParameter : NSObject

- (instancetype)initWithType:(NSString *)type
                     command:(NSString *)command
                     message:(NSString *)message;

@property(readonly) NSString *type;
@property(readonly) NSString *command;
@property(readonly) NSString *message;

@end

NS_ASSUME_NONNULL_END
