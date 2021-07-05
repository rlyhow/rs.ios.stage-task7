//
//  AppDelegate.m
//  Demo
//
//  Created by Viktar Semianchuk on 3/17/20.
//  Copyright © 2020 Viktar Semianchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *rootViewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    [window setRootViewController:rootViewController];
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
