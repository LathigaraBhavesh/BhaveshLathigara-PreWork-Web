//
//  ImgurIDVC.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "ImgurIDVC.h"
#import "ModelImage.h"
#import "ImageDetailVC.h"

@interface ImgurIDVC () <UITextFieldDelegate>
{
    UITextField *txtActiveField;
}
@end

@implementation ImgurIDVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary *dictParameters = @{@"client_id":@"707702989a2b0c4",@"refresh_token":@"80d1cb38e9d07c80e118bdc6cbd480947df9249e",@"client_secret":@"b28e9174296dad55edd27ef15be714b086adf058",@"grant_type":@"refresh_token"};
    [AppDelegate shareApp].accessToken = @"";
    [BLWebServiceWrappper callAPIWithParameters:dictParameters withURL:@"https://api.imgur.com/oauth2/token" Image:nil AndImageKey:@"" ShowProgressInView:self.view isNeedToDisplayProgress:YES isPostCall:YES isStringResponse:NO isNeedToSetBaseURL:NO success:^(id dict)
     {
         [AppDelegate shareApp].accessToken = [dict objectForKey:@"access_token"];
         
     } failure:^(NSString *error)
     {
         [Util alertMessageWithTitle:@"" message:error];
     }];
}
- (IBAction)btnGetImageDetailClick:(id)sender
{
    if ([[Util myTrim:txtImgurID.text] length] == 0)
    {
        [Util alertMessageWithTitle:@"" message:@"Pleaes enter Imgur ID"];
        return;
    }
    
    [txtActiveField resignFirstResponder];
    NSDictionary *dictParameters = @{};
    //8ABRUYt
    [BLWebServiceWrappper callAPIWithParameters:dictParameters withURL:[NSString stringWithFormat:@"image/%@",[Util myTrim:txtImgurID.text]] Image:nil AndImageKey:@"" ShowProgressInView:self.view isNeedToDisplayProgress:YES isPostCall:NO isStringResponse:NO isNeedToSetBaseURL:YES success:^(id dict)
     {
         if ([[dict objectForKey:@"success"] integerValue] == 1)
         {
             ModelImage *objModelImage = [[ModelImage alloc] init];
             [objModelImage setDictionary:[dict objectForKey:@"data"]];
             objModelImage.imageId = [Util myTrim:self->txtImgurID.text];
             ImageDetailVC *objImageDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageDetailVC"];
             objImageDetailVC.objModelImage = objModelImage;
             [self.navigationController pushViewController:objImageDetailVC animated:YES];
         }
         
     } failure:^(NSString *error)
     {
         [Util alertMessageWithTitle:@"" message:error];
     }];
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
