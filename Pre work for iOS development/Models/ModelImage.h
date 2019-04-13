//
//  ModelImage.h
//  Bhavesh Lathigara -PreWork –Web
//
//  Created by Bhavesh Lathigara on 13/04/19.
//  Copyright © 2019 Bhavesh Lathigara. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ModelImage : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *datetime;
@property (nonatomic, retain) NSString *imageId;
@property (nonatomic, retain) NSMutableArray *comments;
@end

NS_ASSUME_NONNULL_END
