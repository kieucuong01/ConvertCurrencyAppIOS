//
//  CommonUtils.m
//  OrderProcessing
//
//  Created by Khang Nguyen on 8/3/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import "CommonUtils.h"
/**
 *  Create color from hex value. Ex: UIColorFromRGB(0x663333)
 */
#define colorWithRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**
 *  Crreate uicolor from r,g,b,a values
 */
#define colorWithRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define colorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation CommonUtils

+ (CommonUtils *)sharedUtils {
    static dispatch_once_t predicate;
    static CommonUtils *instance = nil;
    dispatch_once(&predicate, ^{instance = [[self alloc] init];});
    return instance;
}

- (AppDelegate*)getAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+(BOOL)checkEmptyString:(NSString*)str{
    if (str==nil || [[CommonUtils stringByStrimming:str] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+(NSString *)stringByStrimming:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}



+(id)stringValueWithDict:(NSDictionary*)dict forKey:(NSString*)key{
    if (dict[key]!=nil && ![dict[key] isKindOfClass:[NSNull class]]) {
        return dict[key];
    }
    
    return nil;
}
+(NSInteger)integerValueWithDict:(NSDictionary*)dict forKey:(NSString*)key{
    if (dict[key]!=nil && ![dict[key] isKindOfClass:[NSNull class]]) {
        return [dict[key] integerValue];
    }
    
    return -1;
}
+(BOOL)boolValueWithDict:(NSDictionary*)dict forKey:(NSString*)key{
    if (dict[key]!=nil && ![dict[key] isKindOfClass:[NSNull class]]) {
        return [dict[key] boolValue];
    }
    
    return NO;
}

+(UIColor*)navigationBarBackGroundColor{
    return colorWithRGB(0, 175, 233);
}

+(UIColor*) colorWithRGB:(float)r g:(float)g b:(float)b{
    return colorWithRGB(r, g, b);
}

+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+(NSString*) getTimeCurrent{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-YYYY"];
    
    return [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:[NSDate date]]];

}

+(NSString*) getTimeCurrentJSON{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-YYYYHHmmss"];
    
    NSString* dateJSON = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:[NSDate date]]];
//    NSString* x = [dateJSON stringByAppendingString:@"041432"];
//    return x;
    return dateJSON;
}

+(void) setShadow : (UIView*) view{
    //[view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setShadowOffset:CGSizeMake(5, 5)];
    [view.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [view.layer setShadowOpacity:0.5];
}

+(UIAlertController*) alert : (NSString*) title : (NSString*) message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: title
                                 message: message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:okButton];
    
    return alert;
}

+(UIAlertController*) alertMessage : (NSString*) title : (NSString*) message{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: title
                                 message: message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    return alert;
}

+ (void)showMessage : (NSString*) message view:(UIView*)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);

    [hud hideAnimated:YES afterDelay:1.f];
}

+ (void)showLongDelayMessage : (NSString*) message view:(UIView*)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:4.f];
}

+(NSString *)imageToNSString:(UIImage *)image
{
    return [UIImageJPEGRepresentation(image,0.2) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    //return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

}

+(MBProgressHUD*)createProgressViewInView:(UIView*)view
{
    return [self createProgressViewInView:view duration:300.0];
}

+(MBProgressHUD*)createProgressViewInView:(UIView*)view duration:(NSInteger)duration;
{
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    //    if ([[gdrUtils sharedUtils] getAppDelegate].mainHUD!=nil) {
    //        [[[gdrUtils sharedUtils] getAppDelegate].mainHUD setHidden:YES];
    //    }
    
    if (view==nil) {
        view = [[CommonUtils sharedUtils] getAppDelegate].window.rootViewController.view;
    }
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(tempTaskInTime:) onTarget:self withObject:[NSNumber numberWithFloat:duration] animated:YES];
    
    
    [[CommonUtils sharedUtils] getAppDelegate].mainHUD = HUD;
    
    return HUD;
}

+(void)tempTaskInTime:(NSNumber*)time{
    sleep([time floatValue]);
}

+(void)showConfirmAlertViewWithTitle:(NSString*)title message:(NSString*)message cancelButton:(NSString*)cancelBtn delegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelBtn otherButtonTitles: nil];
    [alert show];
}

+(CGFloat) getWidthScreen{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    return Rect.size.width;
}
+(CGFloat) getHeightScreen{
    CGRect Rect=[[UIScreen mainScreen] bounds];
    return Rect.size.height;
}

/*
 * Function relative IMG
 *
 */

+ (void)saveImageToLocal : (UIImage*) imageCamera : (NSString*) nameImage{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:nameImage];
    UIImage *image = imageCamera ; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:NO];
}

+ (UIImage*)getImageFromLocal : (NSString*) nameImage {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:nameImage];
    UIImage *img = [UIImage imageWithContentsOfFile:getImagePath];
    return img;
}

+ (void)removeImage:(NSString *)nameImage
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:nameImage];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
//    if (success) {
//        UIAlertView *removedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [removedSuccessFullyAlert show];
//    }
//    else
//    {
//        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
//    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
 * Function relative NUMBER
 *
 */
+(NSString*) formatNumber : (NSInteger) numInt{
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // this line is important!
    [formatter setGroupingSize:3];
    [formatter setSecondaryGroupingSize:3];
    [formatter setGroupingSeparator:@","];
    NSString *formatted = [formatter stringFromNumber:[NSNumber numberWithInteger:numInt]];
    
    return formatted;
}

@end
