//
//  PhotoBrowserCell.h
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import <UIKit/UIKit.h>
@class homeModel;
@interface PhotoBrowserCell : UICollectionViewCell

/**  <#名称#> */
@property (nonatomic,strong)homeModel * PhotoBrowsermodel;

/**  <#名称#> */
@property (nonatomic,strong)UIImageView * iconImageView;

@end
