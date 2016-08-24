//
//  LSLCell.m
//  03-掌握-复杂JSON解析-数据展示
//
//  Created by apple on 16/4/8.
//  Copyright © 2016年 LSL. All rights reserved.
//

#import "LSLCell.h"

@implementation LSLCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,80,60);
    float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        self.textLabel.frame = CGRectMake(90,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(90,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
    }
}

@end
