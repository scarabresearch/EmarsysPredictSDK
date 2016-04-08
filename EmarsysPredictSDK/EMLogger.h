//
//  Logger.h
//  EmarsysPredictSDK
//

#import "EMSession.h"

#define DLOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelDebug) {               \
        NSLog(__VA_ARGS__);                                                    \
    }
#define ILOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelInfo) {                \
        NSLog(__VA_ARGS__);                                                    \
    }
#define WLOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelWarning) {             \
        NSLog(__VA_ARGS__);                                                    \
    }
#define ELOG(...)                                                              \
    if ([EMSession sharedSession].logLevel <= EMLogLevelError) {               \
        NSLog(__VA_ARGS__);                                                    \
    }
