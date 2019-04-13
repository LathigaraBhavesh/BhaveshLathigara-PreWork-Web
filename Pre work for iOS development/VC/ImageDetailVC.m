//
//  ImageDetailVC.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "ImageDetailVC.h"
#import "CellComment.h"
#import "ModelComment.h"


@interface ImageDetailVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ImageDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [lblTitle setText:self.objModelImage.title];
    [imgViewImgur sd_setImageWithURL:[NSURL URLWithString:self.objModelImage.link] placeholderImage:[UIImage imageNamed:@"placeholderimgur"] options:SDWebImageRetryFailed];
    
    
    NSDictionary *dictParameters = @{};
    //8ABRUYt
    [BLWebServiceWrappper callAPIWithParameters:dictParameters withURL:[NSString stringWithFormat:@"image/%@/comments",self.objModelImage.imageId] Image:nil AndImageKey:@"" ShowProgressInView:self.view isNeedToDisplayProgress:YES isPostCall:NO isStringResponse:NO isNeedToSetBaseURL:YES success:^(id dict)
     {
         self.objModelImage.comments = [[NSMutableArray alloc] init];
         if ([[dict objectForKey:@"success"] integerValue] == 1)
         {
             for (NSDictionary *dictTemp in [dict objectForKey:@"data"])
             {
                 ModelComment *objModelComment = [[ModelComment alloc] init];
                 [objModelComment setDictionary:dictTemp];
                 [self.objModelImage.comments addObject:objModelComment];
             }
         }
         [self->tblComments reloadData];
         
     } failure:^(NSString *error)
     {
         [Util alertMessageWithTitle:@"" message:error];
     }];
    
    
}
- (IBAction)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnAddCommentClick:(id)sender
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Add Comment"
                               message:@""
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Submit = [UIAlertAction actionWithTitle:@"SUBMIT" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *action)
                             {
                                 UITextField *txtComm = alert.textFields[0];
                                 
                                 if ([Util isEmpty:[Util myTrim:txtComm.text]])
                                 {
                                     [Util alertMessageWithTitle:@"" message:@"Please enter comment"];
                                     [txtComm becomeFirstResponder];
                                     [self presentViewController:alert animated:YES completion:nil];
                                 }
                                 else
                                 {
                                     [self callApiWithComment:[Util myTrim:txtComm.text]];
                                 }
                             }];
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction  *action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:Cancel];
    [alert addAction:Submit];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *NewMessage) {
        NewMessage.placeholder = @"Enter comment here";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)callApiWithComment:(NSString *)strComment
{
    NSDictionary *dictParameters = @{@"image_id":self.objModelImage.imageId,@"comment":strComment};
    
    [BLWebServiceWrappper callAPIWithParameters:dictParameters withURL:@"comment" Image:nil AndImageKey:@"" ShowProgressInView:self.view isNeedToDisplayProgress:YES isPostCall:YES isStringResponse:NO isNeedToSetBaseURL:YES success:^(id dict)
    {
        if ([[dict objectForKey:@"success"] integerValue] == 1)
        {
            [Util alertMessageWithTitle:@"" message:@"Comment posted successfully"];
        }
        
    } failure:^(NSString *error)
    {
        
    }];
}
#pragma mark -
#pragma mark TableView Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objModelImage.comments.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellComment";
    CellComment *cell;
    
    if (cell == nil)
    {
        cell = (CellComment *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    ModelComment *objModelComment = [self.objModelImage.comments objectAtIndex:indexPath.row];
    [cell setData:objModelComment];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
