//
//  AppDelegate.m
//  ecommerceMobile
//
//  Created by Khang Nguyen on 6/20/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _savedNavigationController = (UINavigationController*)self.window.rootViewController;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UIViewController *centerController = [[UINavigationController alloc] initWithRootViewController:[story instantiateViewControllerWithIdentifier:@"MainViewController"]];

    [self.window setRootViewController:centerController];
    return YES;
}

@end
