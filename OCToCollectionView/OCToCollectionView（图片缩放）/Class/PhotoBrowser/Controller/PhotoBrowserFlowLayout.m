//
//  PhotoBrowserFlowLayout.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserFlowLayout.h"
#import "PhotoBrowserController.h"
@interface PhotoBrowserFlowLayout ()

/**  <#名称#> */
@property (nonatomic,strong)PhotoBrowserController * photoCollectionView;


@end

@implementation PhotoBrowserFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    CGFloat itemW = self.collectionView.bounds.size.width;
    CGFloat itemH = self.collectionView.bounds.size.height;
    self.itemSize = CGSizeMake(itemW, itemH);
    NSLog(@"flow==%f",itemW);
}















@end
