//
//  AppDelegate.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] init];
    
    HomeController * home = [[HomeController alloc] init];
    
    UINavigationController * nc = [[UINavigationController alloc] initWithRootViewController:home];
    
    
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 一个图片放大之后的frame
- (CGRect)calculateImageViewFrame:(UIImage *)image
{
    CGFloat imageViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imageViewH = imageViewW / image.size.width * image.size.height;
    CGFloat imageViewX = 0;
    CGFloat imageViewY = ([UIScreen mainScreen].bounds.size.height - imageViewH) * 0.5;
    
    return CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
}


@end
