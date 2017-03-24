//
//  CommonUtils.h
//  OrderProcessing
//
//  Created by Khang Nguyen on 8/3/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class AppDelegate;

@interface CommonUtils : NSObject

+ (CommonUtils *)sharedUtils;

- (AppDelegate *)getAppDelegate;


+(BOOL)checkEmptyString:(NSString*)str;
+(id)stringValueWithDict:(NSDictionary*)dict forKey:(NSString*)key;
+(NSInteger)integerValueWithDict:(NSDictionary*)dict forKey:(NSString*)key;
+(BOOL)boolValueWithDict:(NSDictionary*)dict forKey:(NSString*)key;
+(id)navigationBarBackGroundColor;
+(id) colorWithRGB:(float)r g:(float)g b:(float)b;
+(id)colorFromHexCode:(NSString *)hexString;
+(NSString*) getTimeCurrent;
+(void) setShadow : (UIView*) view ;
+(UIAlertController*) alert : (NSString*) title : (NSString*) message;
+(UIAlertController*) alertMessage : (NSString*) title : (NSString*) message;
+(void)showMessage : (NSString*) message view:(UIView*)view;
+ (void)showLongDelayMessage : (NSString*) message view:(UIView*)view ;
+(NSString *)imageToNSString:(UIImage *)image;
+(MBProgressHUD*)createProgressViewInView:(UIView*)view;
+(void)showConfirmAlertViewWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelBtn delegate:(id)delegate;


+(CGFloat) getWidthScreen;
+(CGFloat) getHeightScreen;

+(NSString*) getTimeCurrentJSON;

/*
 * Function relative IMG
 *
 */


+ (void)saveImageToLocal : (UIImage*) imageCamera : (NSString*) nameImage;
+ (UIImage*)getImageFromLocal : (NSString*) nameImage;
+ (void)removeImage:(NSString *)nameImage;
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/*
 * Function relative NUMBER
 *
 */
+(NSString*) formatNumber : (NSInteger) number;
@end
