//
//  EMStringCommand.h
//  EmarsysMobile
//

#import "EMCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface EMStringCommand : EMCommand

- (instancetype)initWithValue:(NSString *)value;

@property(readwrite) NSString *value;

@end

NS_ASSUME_NONNULL_END
