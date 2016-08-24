//
//  PhotoBrowserController.m
//  OCToCollectionView
//
//  Created by 李天空 on 16/6/21.
//  Copyright © 2016年 李天空. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoBrowserFlowLayout.h"
#import "homeModel.h"
#import "LSLHttpTool.h"
#import "PhotoBrowserCell.h"
#import <Photos/Photos.h>
#import "SVProgressHUD.h"
#import "PhotoBrowserAnimator.h"
static NSString * const ID = @"taishuai";
@interface PhotoBrowserController ()<UICollectionViewDataSource,UICollectionViewDelegate,DismissProtocol>

/**  <#名称#> */
@property (nonatomic,strong)UICollectionView * collectionView;

/**  <#名称#> */
@property (nonatomic,weak)UIImageView * photoImageView;

/**  <#名称#> */
@property (nonatomic,strong)PhotoBrowserCell * photoBrowserCell;


@end

@implementation PhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setViewPhotoWidth];
   
    [self.collectionView registerClass:[PhotoBrowserCell class] forCellWithReuseIdentifier:ID];
    
    // 初始化两个按钮
    [self setButtonClick];
    
    // 通过A控制记录下路径，通过这个方法来滚动到想对应的路径
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
  
    
}

// 通过控制View的宽度+15让clollerctionView的宽度也+15也让clollerctionViewFlowLayout的宽度也+15.  同时图片的宽度是通过屏幕的宽度来设置的
- (void)setViewPhotoWidth
{
    CGRect frame = self.view.frame;
    frame.size.width += 15;
    self.view.frame = frame;
}



#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowserCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
//    cell.backgroundColor = (indexPath.item %2==0)? [UIColor yellowColor] : [UIColor blueColor];
    
    cell.PhotoBrowsermodel = self.shops[indexPath.row];
    
    self.photoImageView = cell.iconImageView;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setMonitor];
}

#pragma mark - DismissProtocol
- (UIImageView *)getImageViewDismissIndexPath
{
    // 创建UIImageView对象
    UIImageView * dismissImageView = [[UIImageView alloc] init];
    
    // 获取自定义cell，强转一下
    self.photoBrowserCell = (PhotoBrowserCell *)[self.collectionView visibleCells].firstObject;
    
    // 将cell的赋值给刚创建的对象
    dismissImageView.image = self.photoBrowserCell.iconImageView.image;
    
    dismissImageView.frame = self.photoBrowserCell.iconImageView.frame;
    
    // 此处不要填充模式，不然的话有BUG
//    dismissImageView.contentMode = UIViewContentModeScaleAspectFit;
    dismissImageView.clipsToBounds = YES;
    
    return dismissImageView;
}

- (NSIndexPath *)getIndexPath
{
    self.photoBrowserCell = (PhotoBrowserCell *)[self.collectionView visibleCells].firstObject;

    return [self.collectionView indexPathForCell:self.photoBrowserCell];
}



// 初始化
- (void)setButtonClick
{
    UIButton * closeButton = [[UIButton alloc] init];
    [closeButton setTitle:@"关 闭" forState:UIControlStateNormal];
    closeButton.backgroundColor = [UIColor lightGrayColor];
    CGFloat W = 90;
    CGFloat H = 32;
    CGFloat x = 20;
    CGFloat Y = [UIScreen mainScreen].bounds.size.height - H - x;
    closeButton.frame = CGRectMake(x, Y, W, H);
        [closeButton addTarget:self action:@selector(setMonitor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UIButton * preserveButton = [[UIButton alloc] init];
    [preserveButton setTitle:@"保 存" forState:UIControlStateNormal];
    preserveButton.backgroundColor = [UIColor lightGrayColor];
    CGFloat X = [UIScreen mainScreen].bounds.size.width - x - W;
    preserveButton.frame = CGRectMake(X, Y, W, H);
    [preserveButton addTarget:self action:@selector(setPreserveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:preserveButton];
    
}

#pragma mark - 按钮监听点击事件

- (void)setMonitor{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



/**
 *  获得【自定义图片】
 */
- (PHFetchResult<PHAsset *> *)createdAssets
{
    
    // 在block里面赋值，需要用到__block
    __block NSString * createdAssetId = nil;
    // 把图片添加到相机胶卷中
    NSError * error = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        // placeholderForCreatedAsset：站位符，因为是同步操作，不可能一下子就执行完毕的，因此就给了站位符
        // localIdentifier：类似唯一标识符的意思
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.photoImageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    // 查看是否有图片，没有的话，我们就直接返回
    if (createdAssetId == nil) return nil;
    
    // 有的话，我们就返回图片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetId] options:nil];
}

/**
 *  获得【自定义相册】
 */
- (PHAssetCollection *)createdCollection
{
    
    // 相册生成一个应用程序同名的，需要拿到Info的CFBundleName
    NSString * title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> * collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 遍历出是否有跟程序同名的
    for (PHAssetCollection * collection in collections) {
        
        if ([collection.localizedTitle isEqualToString:title]) return collection;
    }
    
    // 当来到这步的话，那么就是没有跟程序同名的自定义相册，需要我们去创建自定义相册
    __block NSString * createdCollection = nil;
    NSError * error = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollection = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error];
    
    // 判断自定义的相册是否为空
    if (createdCollection == nil) return nil;
    
    // 返回自定义相册
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollection] options:nil].firstObject;
}

- (void)saveImageIntoAlbum
{
    // 拿到图片
    PHFetchResult<PHAsset *> * createdAssets = self.createdAssets;
    // 拿到相册
    PHAssetCollection * createdCollection = self.createdCollection;
    
    // 判断相册或者图片是否为空，为空的话直接返回
    
    if (createdAssets == nil || createdCollection == nil){
        
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    NSError * error = nil;
    
    // 将图片放到自定义的相册里，把新加进来的图片放进数组的第一位(同步操作)
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
        
    } error:&error];
    
    // 判断是否error有值，有值是错误，提示用户错误信息
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else
        // 没有值，提示用户保存成功
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
    
    
}
// 点击保存图片
- (void)setPreserveButtonClick
{

    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // requestAuthorization 用户还没选择授权就弹出框，提示授权，要是授权了，那么就会调block的代码块
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            switch (oldStatus) {
                case PHAuthorizationStatusAuthorized:{
                    [self saveImageIntoAlbum];
                    break;
                }
                case PHAuthorizationStatusRestricted:{
                    NSLog(@"由于系统某些原因被限制了");
                    break;
                }
                case PHAuthorizationStatusDenied:{
                    if (oldStatus == PHAuthorizationStatusDenied) return;
                    NSLog(@"提示用户打开访问相册开关");
                    break;
                }
                default:
                    break;
            }
        });
    }];

}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        PhotoBrowserFlowLayout * photoVrowser = [[PhotoBrowserFlowLayout alloc] init];
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:photoVrowser];
        NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}















@end
