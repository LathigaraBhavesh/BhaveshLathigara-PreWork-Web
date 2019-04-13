//
//  CellComment.h
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelComment.h"

NS_ASSUME_NONNULL_BEGIN

@interface CellComment : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
- (void)setData:(ModelComment *)objModelComment;
@end

NS_ASSUME_NONNULL_END
