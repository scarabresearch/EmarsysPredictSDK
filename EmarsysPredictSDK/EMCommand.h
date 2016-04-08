//
//  EMCommand.h
//  EmarsysPredictSDK
//

@import Foundation;

#import "EMErrorParameter.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMCommand : NSObject

- (NSArray<EMErrorParameter *> *)validate;
- (EMErrorParameter *)emptyStringEMErr:(NSString *)command
                                 field:(NSString *)field;

@end

NS_ASSUME_NONNULL_END
