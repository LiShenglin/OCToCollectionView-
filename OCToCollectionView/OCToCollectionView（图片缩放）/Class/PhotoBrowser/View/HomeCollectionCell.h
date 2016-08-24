//
//  HomeCollectionCell.h
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import <UIKit/UIKit.h>

@class homeModel;
@interface HomeCollectionCell : UICollectionViewCell

/**  <#名称#> */
@property (nonatomic,strong)UIImageView * iconImageView;

/**  <#名称#> */
@property (nonatomic,strong)homeModel * model;


@end
