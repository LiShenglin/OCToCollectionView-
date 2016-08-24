//
//  PhotoBrowserAnimator.h
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// 动画放大的动画协议
@protocol PresentedProtocol <NSObject>

// 方法的图片
- (UIImageView *)getImageViewindexPath:(NSIndexPath *)indexPath;

// 图片最开始的位置
- (CGRect)getStartRectIndexPath: (NSIndexPath *)starIndexPath;

// 图片缩放最后的位置
- (CGRect)getEndRect: (NSIndexPath *)endIndexPath;

@end


/// 动画缩小的协议
@protocol DismissProtocol <NSObject>

- (UIImageView *)getImageViewDismissIndexPath;
- (NSIndexPath *)getIndexPath;

@end

@interface PhotoBrowserAnimator : NSObject<PresentedProtocol,DismissProtocol,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

/**  图片放大的代理属性 */
@property (nonatomic,weak)id<PresentedProtocol> delegade;

/**  图片缩小的代理属性 */
@property (nonatomic,weak)id<DismissProtocol> dismissdelagade;


/**  <#名称#> */
@property (nonatomic,strong)NSIndexPath * indexPath;


@end
