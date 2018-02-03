//
//  BaseHttpTool.m
//  sgs
//
//  Created by 中玩 on 2017/4/28.
//  Copyright © 2017年 中玩. All rights reserved.
//

#import "BaseHttpTool.h"
#import "AFNetworking.h"
#import "PhotoModel.h"

@implementation BaseHttpTool

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @".jpg";
            
        case 0x89:
            
            return @".png";
            
        case 0x47:
            
            return @".gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @".tiff";
            
    }
    
    return nil;
    
}



+ (NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280) {
        if (width>height) {
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }else{
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }
        //2.高度大于1280
    }else if(height>1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}





+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = nil;
    [session setDownloadTaskDidResumeBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t fileOffset, int64_t expectedTotalBytes) {
    }];
    
    NSLog(@"-----------------HTTP:-----------------/n%@",url);
    [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"%@",responseObject);

        if (success) {
                success(responseObject);
            }
        }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session.requestSerializer setTimeoutInterval:45];
    session.responseSerializer.acceptableContentTypes = nil;
    NSLog(@"-----------------HTTP:-----------------/n%@",url);
    [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"%@",responseObject);

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}

// ** post */
+ (void)POSTS:(NSString * _Nonnull )url params:(NSDictionary * _Nullable )params success:(success _Nullable)success
      failure:(failure _Nullable )failure
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setTimeoutInterval:45];
    session.responseSerializer.acceptableContentTypes = nil;
    
    [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)postFile:(NSString *)urlString parameters:(id)parameters formData:(void (^)(id <AFMultipartFormData> formData))file success:(void (^)(id object))success fail:(void (^)())fail{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
       [session.requestSerializer setTimeoutInterval:10];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [session POST:urlString parameters:parameters constructingBodyWithBlock:file progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        if (fail) {
              fail(error);
        }
    }];
}




+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  上传带图片的内容，允许多张图片上传（URL）POST
 *
 *  @param url                 网络请求地址
 *  @param images              要上传的图片数组（注意数组内容需是图片）
 *  @param parameter           图片数组对应的参数
 *  @param parameters          其他参数字典
 *  @param ratio               图片的压缩比例（0.0~1.0之间）
 *  @param succeedBlock        成功的回调
 *  @param failedBlock         失败的回调
 *  @param uploadProgressBlock 上传进度的回调
 */


+ (void)startMultiPartUploadTaskWithURL:(NSString *)url imagesArray:(NSArray *)images parameterOfimages:(NSString *)parameter parametersDict:(NSDictionary *)parameters compressionRatio:(float)ratio succeedBlock:(void (^)(id _Nonnull, id _Nonnull))succeedBlock failedBlock:(void (^)(id _Nonnull, NSError * _Nonnull))failedBlock uploadProgressBlock:(void (^)(float, long long, long long))uploadProgressBlock
{
    AFHTTPSessionManager *operation = [AFHTTPSessionManager manager];
    operation.responseSerializer = [AFJSONResponseSerializer serializer]; // 申明返回的结果是json类型
    //    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [operation POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
//    [operation POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //根据当前系统时间生成图片名称
//        //        NSDate *date = [NSDate date];
//        //        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        //        [formatter setDateFormat:@"yyyy年MM月dd日"];
//        //        NSString *dateString = [formatter stringFromDate:date];
//
//
//
//
//        [SVProgressHUD showSuccessWithStatus:@"正在上传请稍候"];
//        for(int i = 0; i < images.count; i++)
//        {
//            id obj = [images objectAtIndexWithNullDetection:i];
//            if ([obj isKindOfClass:[NSDictionary class]]) {
//                //取出单张图片二进制数据
//                if([[[images objectAtIndexWithNullDetection:i] allKeys] containsObject:@"face"])
//                {
//                    NSData * imageData = [[images objectAtIndexWithNullDetection:i]objectForKeyWithNullDetection:@"face"];
//
//                    // 上传的参数名，在服务器端保存文件的文件夹名
//                    NSString * Name = [NSString stringWithFormat:@"%@%d", @"face_", i+1];
//                    // 上传filename
//                    NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
//
//                    [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpeg"];
//                }else if ([[[images objectAtIndexWithNullDetection:i] allKeys] containsObject:@"back"]){
//
//                    NSData * imageData = [[images objectAtIndexWithNullDetection:i] objectForKey:@"back"];
//
//                    // 上传的参数名，在服务器端保存文件的文件夹名
//                    NSString * Name = [NSString stringWithFormat:@"%@%d", @"back_", i+1];
//                    // 上传filename
//                    NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
//
//                    [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpeg"];
//                }
//            }else{
//                PhotoModel* model = [images objectAtIndexWithNullDetection:i];
//                NSString * fileName = [NSString stringWithFormat:@"%d.jpg", i+10];
//                if (model.tag == -1) {
//                    return;
//                }
//                if (model.image != nil) {
//                    NSData* data = nil;
//                    CGSize imagesize = model.image.size;
//                    if (UIImagePNGRepresentation(model.image) == nil)
//                    {
//                        data = UIImageJPEGRepresentation(model.image,0.00001);
//                        //保存到Documents
//
//                    }
//                    else
//                    {
//                        data = UIImagePNGRepresentation(model.image);
//                        //                        data = UIImageJPEGRepresentation(model.image,1);
//                        CGFloat test = (NSInteger)[data length]/1000.0;
//                        if (test >= 4*1024) {
//                            CGFloat scale = 1024*4/test;
//                            CGSize size = CGSizeMake(imagesize.width*scale, imagesize.height*scale);
//                            UIImage* tempImage = [BaseHttpTool scaleToSize:model.image size:size];
//                            data = UIImagePNGRepresentation(tempImage);
//                        }else{
//                            UIImage* tempImage = [BaseHttpTool scaleToSize:model.image size:imagesize];
//                            data = UIImagePNGRepresentation(tempImage);
//                        }
//
//                    }
//
//                    [formData appendPartWithFileData:data name:@"imagFiles" fileName:fileName mimeType:@"image/jpeg"];
//                }
//            }
//        }
//        //
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        uploadProgressBlock( uploadProgress.fractionCompleted ,uploadProgress.totalUnitCount,uploadProgress.completedUnitCount );
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        succeedBlock(operation,responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        failedBlock(operation,error);
//
//    }];
    
}

@end
