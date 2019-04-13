//
//  ImgurIDVC.h
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImgurIDVC : UIViewController
{
    __weak IBOutlet UITextField *txtImgurID;
}
- (IBAction)btnGetImageDetailClick:(id)sender;
@end

NS_ASSUME_NONNULL_END
