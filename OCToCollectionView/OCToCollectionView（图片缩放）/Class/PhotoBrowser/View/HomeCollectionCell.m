//
//  HomeCollectionCell.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "HomeCollectionCell.h"
#import "homeModel.h"
#import "UIImageView+WebCache.h"

@interface HomeCollectionCell ()

@end

@implementation HomeCollectionCell

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];

    }
    return _iconImageView;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - 4 * 10) / 3;
    
    self.iconImageView.frame = CGRectMake(0, 0, itemWH,itemWH);
    
}

- (void)setModel:(homeModel *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.q_pic_url] placeholderImage:[UIImage imageNamed:@"empty_picture"]];
}

@end
