//
//  PhotoBrowserCell.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserCell.h"
#import "UIImageView+WebCache.h"
#import "homeModel.h"
@interface PhotoBrowserCell ()





@end

@implementation PhotoBrowserCell

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
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat imageW = self.PhotoBrowsermodel.pic_width.doubleValue;
    CGFloat imageH = self.PhotoBrowsermodel.pic_height.doubleValue;
    CGFloat H = W /imageW *imageH;
    CGFloat Y = ([UIScreen mainScreen].bounds.size.height - H) * 0.5;
    self.iconImageView.frame = CGRectMake(0, Y, W, H);
    
}

- (void)setPhotoBrowsermodel:(homeModel *)PhotoBrowsermodel
{
    _PhotoBrowsermodel = PhotoBrowsermodel;
    
    /// BUG：展示大图的时候会闪一下 解决方案：   从沙河中取到小的图片，设置为展位图
    SDImageCache * cache = [[SDWebImageManager sharedManager] imageCache];
    UIImage * image = [cache imageFromMemoryCacheForKey:PhotoBrowsermodel.q_pic_url];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:PhotoBrowsermodel.m_pic_url] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImageView.frame = [self calculateImageViewFrame:image];
    }];
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
