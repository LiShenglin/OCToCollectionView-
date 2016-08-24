//
//  PhotoBrowserAnimator.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserAnimator.h"

@interface PhotoBrowserAnimator ()


@property (nonatomic,assign)BOOL isPresented;

/**  结束位置 */
//@property (nonatomic,assign)CGRect endRect;

/**  <#名称#> */
@property (nonatomic,assign)BOOL isZeroRect;

@end

@implementation PhotoBrowserAnimator
#pragma mark - UIViewControllerTransitioningDelegate
/*********************   转场动画代理方法      *************************/
// 告诉弹出动画交给谁去处理
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.isPresented = YES;
    return self;
}

/// 该代理方法用于告诉系统谁来负责控制器如何弹出
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.isPresented = NO;
    return self;
}


#pragma mark - 转场的动画
// 动画执行时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 2.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresented) {
        
        NSIndexPath * indexPath = self.indexPath;
        
       UIView *  presentedView = [transitionContext viewForKey:UITransitionContextToViewKey] ;
        
        
        //////  **设置图片**   **起始位置**    **末尾位置** //////////
        UIImageView * iconImageView = [[UIImageView alloc] init];
        
        // 图片
        if ([self.delegade respondsToSelector:@selector(getImageViewindexPath:)]) {
           iconImageView = [self.delegade getImageViewindexPath:indexPath];
            // 将图片添加到控制器上面
            [[transitionContext containerView] addSubview:iconImageView];
        }


        // 开始位置
        if ([self.delegade respondsToSelector:@selector(getStartRectIndexPath:)]) {
            iconImageView.frame = [self.delegade getStartRectIndexPath:indexPath];
        }
        
        // 这是弹出来的控制器的颜色
        [transitionContext containerView].backgroundColor = [UIColor blackColor];

        //执行动画
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            // 结束位置
            if ([self.delegade respondsToSelector:@selector(getEndRect:)]) {
                iconImageView.frame = [self.delegade getEndRect:indexPath];
            }
        } completion:^(BOOL finished) {
            
            [[transitionContext containerView] addSubview:presentedView];
            [transitionContext containerView].backgroundColor = [UIColor clearColor];
            [iconImageView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
    else
    {
        // 1.获取取消的View
        UIView * dismissView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [dismissView removeFromSuperview];
        
        // 2。1获取执行动画的dismissImageView
        UIImageView * dismissImageView = [[UIImageView alloc] init];
        if ([self.dismissdelagade respondsToSelector:@selector(getImageViewDismissIndexPath)]) {
            dismissImageView = [self.dismissdelagade getImageViewDismissIndexPath];
               [[transitionContext containerView] addSubview:dismissImageView];
        }
     
        
        // 2.2取出indexPath
        NSIndexPath * indexPath = [[NSIndexPath alloc] init];
        
        if ([self.dismissdelagade respondsToSelector:@selector(getIndexPath)]) {
            indexPath = [self.dismissdelagade getIndexPath];
        }
        
        
        CGRect endRect;
        // 2.3获取结束为止
        if ([self.delegade respondsToSelector:@selector(getStartRectIndexPath:)]) {
            endRect = [self.delegade getStartRectIndexPath:indexPath];
//            self.endRect = endRect;
        }
        
        // 转成这句*******************************************
        //  dismissView.alpha = (self.endRect == CGRectZero)? 1.0:0.0;
        
        // CGRectZero打印出来是   nil   
//        BOOL isTrue = CGRectEqualToRect(endRect, CGRectZero);
//        dismissView.alpha =1.0;
        
        
        // 3.执行动画的
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            if (endRect.size.width == 0 || endRect.size.height == 0) {

//                [dismissImageView removeFromSuperview];
                
                // 设置alpha值
                    dismissImageView.alpha = 0.0;
                
            }else
            {
                dismissImageView.frame = endRect;
                
            }
            
        } completion:^(BOOL finished) {
            [dismissView removeFromSuperview];

            [transitionContext completeTransition:YES];
            
        }];
    }
}
@end
