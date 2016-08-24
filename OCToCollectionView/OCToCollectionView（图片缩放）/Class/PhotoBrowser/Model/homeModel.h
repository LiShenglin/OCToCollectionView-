//
//  homeModel.h
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/20.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeModel : NSObject

/**  大图 */
@property (nonatomic,strong)NSString * m_pic_url;

/**  小图 */
@property (nonatomic,strong)NSString * q_pic_url;

/**  <#名称#> */
@property (nonatomic,strong)NSString * pic_height;


/**  <#名称#> */
@property (nonatomic,strong)NSString * pic_width;

- (instancetype)initWithHomeModel:(NSDictionary *)dict;

@end
