//
//  LoginVC.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC () <UITextFieldDelegate>
{
    UITextField *txtActiveField;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnLoginClick:(id)sender
{
    [txtActiveField resignFirstResponder];
    
    if ([[Util myTrim:txtUserName.text] length] == 0)
    {
        [Util alertMessageWithTitle:@"" message:@"Please enter username"];
        return;
    }
    else if ([[Util myTrim:txtPassword.text] length] == 0)
    {
        [Util alertMessageWithTitle:@"" message:@"Please enter password"];
        return;
    }
    else if (![[Util myTrim:txtUserName.text] isEqualToString:loggedusername])
    {
        [Util alertMessageWithTitle:@"" message:@"Please enter valid username"];
        return;
    }
    else if (![[Util myTrim:txtPassword.text] isEqualToString:loggedpassword])
    {
        [Util alertMessageWithTitle:@"" message:@"Please enter valid password"];
        return;
    }
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ImgurIDVC"] animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    txtActiveField = textField;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
@end
