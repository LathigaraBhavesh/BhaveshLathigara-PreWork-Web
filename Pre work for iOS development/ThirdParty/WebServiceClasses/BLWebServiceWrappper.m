//
//  BLWebServiceWrappper.m
//
//  Created by Bhavesh Lathigara on 7/15/15.
//  Copyright (c) 2015 Bhavesh Lathigara. All rights reserved.
//

#import "BLWebServiceWrappper.h"

@implementation BLWebServiceWrappper

+(void)callAPIWithParameters:(NSDictionary *)dict withURL:(NSString *)strurl Image:(UIImage *)image AndImageKey:(NSString *)imageKey ShowProgressInView:(UIView *)view isNeedToDisplayProgress:(BOOL)isProgress isPostCall:(BOOL)isPost isStringResponse:(BOOL)isString isNeedToSetBaseURL:(BOOL)isBaseURL success:(void(^)(id dict))successBlock failure:(void (^)(NSString *error))failureBlock
{
    if ([Util isInternetAvailable])
    {
        NSMutableString *outputList = [[NSMutableString alloc] init];
        
        for (int i=0; i<[[dict allKeys] count]; i++)
        {
            [outputList appendString:[NSString stringWithFormat:@"%@",[[dict allKeys] objectAtIndex:i]]];
            [outputList appendString:@"="];
            [outputList appendString:[NSString stringWithFormat:@"%@",[[dict allValues] objectAtIndex:i]]];
            if (i != [[dict allKeys] count]-1)
            {
                [outputList appendString:@"&"];
            }
        }
        NSString *strBaseURL = BASEURL;
        
        NSString *strParams = [NSString stringWithFormat:@"%@%@?%@",strBaseURL,strurl,outputList];
        outputList = nil;
        NSLog(@"outputList: %@", strParams);
        strParams = nil;
        NSString *url = @"";
        if (isBaseURL)
        {
            url = [NSString stringWithFormat:@"%@%@",strBaseURL,strurl];
        }
        else
        {
            url = [NSString stringWithFormat:@"%@",strurl];
        }
        
        
        if(isProgress)
        {
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        }
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        if (isString)
        {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
        else
        {
            manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        }
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Client-ID 707702989a2b0c4"] forHTTPHeaderField:@"Authorization"];
        if (![[AppDelegate shareApp].accessToken isEqualToString:@""])
        {
            [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",[AppDelegate shareApp].accessToken] forHTTPHeaderField:@"Authorization"];
        }
        if (image)
        {
            [manager.requestSerializer setTimeoutInterval:300];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
            [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
             {
                 //name:@"image" is API key
                 [formData appendPartWithFileData:imageData name:imageKey fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                 
             } success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 [MBProgressHUD hideAllHUDsForView:view animated:YES];
                 NSLog(@"JSON: %@\n", responseObject);
                 successBlock(responseObject);
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 [MBProgressHUD hideAllHUDsForView:view animated:YES];
                 [Util alertMessageWithTitle:@"" message:NoInternet];
                 NSLog(@"Response String----->%@",operation.responseString);
                 NSLog(@"Error----->%@",error);
                 failureBlock([error localizedDescription]);
             }];

        }
        else
        {
            [manager.requestSerializer setTimeoutInterval:30];
            if (isPost)
            {
                [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     //                 NSLog(@"JSON: %@\n", responseObject);
                     [MBProgressHUD hideAllHUDsForView:view animated:YES];
                     if (isString)
                     {
                         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                         successBlock(string);
                     }
                     else
                     {
                         successBlock(responseObject);
                     }
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     [MBProgressHUD hideAllHUDsForView:view animated:YES];
                     [Util alertMessageWithTitle:@"" message:NoInternet];
//                     NSLog(@"Response String----->%@",operation.responseString);
//                     NSLog(@"Error----->%@",error);
                     failureBlock([error localizedDescription]);
                 }];
            }
            else
            {
                [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject)
                 {
                     //                 NSLog(@"JSON: %@\n", responseObject);
                     [MBProgressHUD hideAllHUDsForView:view animated:YES];
                     if (isString)
                     {
                         NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                         successBlock(string);
                     }
                     else
                     {
                         successBlock(responseObject);
                     }
                     
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                 {
                     [MBProgressHUD hideAllHUDsForView:view animated:YES];
                     [Util alertMessageWithTitle:@"" message:NoInternet];
                     NSLog(@"Response String----->%@",operation.responseString);
                     NSLog(@"Error String----->%@",error.localizedDescription);
                     
                     failureBlock([error localizedDescription]);
                 }];
            }
        }
        manager = nil;
    }
    else
    {
        failureBlock(@"");
    }
}
@end
