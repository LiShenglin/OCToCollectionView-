//
//  HomeFlowLayout.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "HomeFlowLayout.h"

@implementation HomeFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    // 初始化
    
    CGFloat margin = 10;
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    self.collectionView.contentInset = UIEdgeInsetsMake(margin + 64 , margin, margin, margin);
    
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 4 * margin) / 3;
    
    self.itemSize = CGSizeMake(itemWH, itemWH);
    
}

@end
