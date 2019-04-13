#import "Util.h"
#import "Reachability.h"

@implementation Util

+ (BOOL)isInternetAvailable
{   
    Reachability* reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    if (![reachability isReachable]) {
        [Util alertMessageWithTitle:@"No Internet" message:@"Internet Connection is not available"];
        return NO;
    }
    return YES;
}
+ (BOOL)isInternetCame
{
    Reachability* reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    if (![reachability isReachable]) {
        return NO;
    }
    return YES;
}
+(BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *mobileNumberPattern = @"[789][0-9]{9}";
    NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
    return [mobileNumberPred evaluateWithObject:phoneNumber];
    
//    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    
//    return [phoneTest evaluateWithObject:phoneNumber];
}
+ (NSString *) getFilePath:(NSString *) fileName
{
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docsDir stringByAppendingPathComponent:fileName];
}
+(NSString *)myTrim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+(BOOL)isEmpty:(NSString *)s
{
    if ([s isEqual:[NSNull null]]) return YES;
    s = [self myTrim:[NSString stringWithFormat:@"%@",s]];
    if([s isEqualToString:@"(null)"]) s = @"";
    return ([s isEqualToString:@""])?YES:NO;
}

+ (void)alertMessageWithTitle:(NSString *)title message:(NSString *)message
{
    [[APPDELEGATE alertGlobal] dismissWithClickedButtonIndex:-1 animated:YES];
    
    [AppDelegate shareApp].alertGlobal = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    dispatch_async(dispatch_get_main_queue(),^{
        [[APPDELEGATE alertGlobal] show];
    });
}
@end
