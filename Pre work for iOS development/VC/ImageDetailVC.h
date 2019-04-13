//
//  ImageDetailVC.h
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageDetailVC : UIViewController
{
    __weak IBOutlet UILabel *lblTitle;
    __weak IBOutlet UIImageView *imgViewImgur;
    __weak IBOutlet UITableView *tblComments;
}
@property (nonatomic, retain) ModelImage *objModelImage;
- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnAddCommentClick:(id)sender;
@end

NS_ASSUME_NONNULL_END
