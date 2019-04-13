//
//  CellComment.m
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import "CellComment.h"

@implementation CellComment

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(ModelComment *)objModelComment
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[objModelComment.datetime doubleValue]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy hh:mm a"];
    
    [self.lblTime setText:[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]]];
    [self.lblComment setText:objModelComment.comment];
}

@end
