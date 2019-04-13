#import <Foundation/Foundation.h>

@interface Util : NSObject

#define loggedusername @"bhavesh"
#define loggedpassword @"123456"

+ (BOOL)isInternetAvailable;
+ (BOOL)isInternetCame;
+ (NSString *)myTrim:(NSString *)string;
+ (BOOL)isEmpty:(NSString *)s;
+ (void)alertMessageWithTitle:(NSString *)title message:(NSString *)message;
@end
