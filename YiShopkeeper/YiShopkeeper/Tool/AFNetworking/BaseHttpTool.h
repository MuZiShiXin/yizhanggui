//
//  BaseHttpTool.h
//  sgs
//
//  Created by 中玩 on 2017/4/28.
//  Copyright © 2017年 中玩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"

typedef void (^success )( id _Nullable responseObj);

typedef void (^failure)( NSError * _Nullable error);

@interface BaseHttpTool : NSObject

+ (NSString *_Nonnull)typeForImageData:(NSData *_Nullable)data ;
+ (NSData *_Nullable)zipNSDataWithImage:(UIImage *_Nullable)sourceImage;


// ** get */
+ (void)GET:( NSString *  _Nonnull )url params:(NSDictionary * _Nullable )params success:(success _Nullable)success
    failure:(failure _Nullable)failure;

// ** post */
+ (void)POST:(NSString * _Nonnull )url params:(NSDictionary * _Nullable )params success:(success _Nullable)success
     failure:(failure _Nullable )failure;

// ** postzhifubao */
+ (void)POSTS:(NSString * _Nonnull )url params:(NSDictionary * _Nullable )params success:(success _Nullable)success
     failure:(failure _Nullable )failure;



+ (void)postFile:(NSString * _Nonnull )urlString parameters:(id _Nullable )parameters formData:(void ( ^ _Nullable )(id <AFMultipartFormData> _Nullable formData))formData success:(void (^ _Nullable )(id _Nullable object))success fail:(void (^ _Nullable )(void))fail;


+ (void)startMultiPartUploadTaskWithURL:(NSString * _Nullable )url
                            imagesArray:(NSArray * _Nullable )images
                      parameterOfimages:(NSString * _Nullable )parameter
                         parametersDict:(NSDictionary * _Nullable )parameters
                       compressionRatio:(float)ratio
                           succeedBlock:(nullable void (^)(id _Nonnull, id _Nonnull))succeedBlock
                            failedBlock:(nullable void (^)(id _Nonnull, NSError * _Nonnull))failedBlock
                    uploadProgressBlock:(nullable void (^)(float, long long, long long))uploadProgressBlock;


@end
