//
//  AppDelegate.h
//  Pre work for iOS development
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIAlertView *alertGlobal;
@property (nonatomic, retain) NSString *accessToken;

+(AppDelegate *)shareApp;
@end

