//
//  AppDelegate.h
//  ecommerceMobile
//
//  Created by Khang Nguyen on 6/20/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) UINavigationController* savedNavigationController;
@property (nonatomic,strong) MBProgressHUD* mainHUD;



@end

