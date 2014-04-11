//
//  MouseStacheAppDelegate.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "MouseStacheAppDelegate.h"
#import "MiceViewController.h"
#import "AllMice.h"
#import "ShowCageViewController.h"
#import "MiceViewController.h"
#import "CagesViewController.h"

@implementation MouseStacheAppDelegate
{
    AllMice *_mice;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    self.tabBarController = [[UITabBarController alloc] init];
//    
//    ShowCageViewController *cageVC = [[ShowCageViewController alloc] init];
//    
//    MiceViewController *miceVC = [[MiceViewController alloc] init];
//    
//    UINavigationController *miceNav = [[UINavigationController alloc] initWithRootViewController:miceVC];
//    
//    NSArray* controllers = [NSArray arrayWithObjects:cageVC, miceNav, nil, nil, nil];
//    self.tabBarController.viewControllers = controllers;
//    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = self.tabBarController;
//    [self.window makeKeyAndVisible];
//
    
  
    
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    tabController.tabBar.tintColor = [UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0];
    UINavigationController *navMice = tabController.viewControllers[0];
    UINavigationController *navCages = tabController.viewControllers[1];
    
    MiceViewController *miceVC = (MiceViewController *)navMice.topViewController;
    CagesViewController *cagesVC = (CagesViewController *)navCages.topViewController;
    
    navMice.navigationBar.tintColor = [UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0];
    navCages.navigationBar.tintColor = [UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0];
   
    _mice = [[AllMice alloc] init];
    miceVC.mice = _mice;
    cagesVC.mice = _mice;

    sleep(2);
    
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)saveData {
    
    [_mice saveMice];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   [self saveData];
}

@end
