//
//  ENEditEnterInfoViewController.m
//  EnterPriseIn
//
//  Created by iOSDev on 2018/6/29.
//  Copyright © 2018年 com.shun. All rights reserved.
//

#import "ENEditEnterInfoViewController.h"
#import "ZYQAssetPickerController.h"
#import <Masonry.h>

@interface ENEditEnterInfoViewController ()<UIScrollViewDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property(nonatomic,strong) UIView *pictureView;

@property(nonatomic,strong) UIButton *addImageBtn;

@property(strong,nonatomic) ZYQAssetPickerController *picker;

@property(strong,nonatomic) UIButton *submitBtn;

@property(nonatomic,retain) NSMutableArray *imageArr;

@property(nonatomic,retain) NSMutableArray *photoArr;

@end

@implementation ENEditEnterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)picAction:(UIButton*)sender{
    
    [self.view endEditing:YES];
    if (self.imageArr.count > 8) {
        [GlobalFunction makeToast:@"最多上传9张图片" duration:1.0 HeightScale:0.5];
    }else{
        UIActionSheet *sheet;
        //判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍摄新照片" otherButtonTitles:@"从相册选取",@"取消", nil];
        }else{
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"取消", nil];
        }
        sheet.tag = 255;
        [sheet showInView:self.view];
    }
}

- (void)submitEnterpriseInfo{
    
    
}

- (void)deleteAction:(UIButton*)btn{
    
    [self.imageArr removeObjectAtIndex:btn.tag - 2000];
    
    for (UIView *view in self.pictureView.subviews) {
        [view removeFromSuperview];
    }
    NSLog(@"imageArr.count:%ld",self.imageArr.count);
//    [self resetPictureView];
    
}

#pragma mark - image picker delegte
//拍照
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageArr addObject:image];
//    [self resetPictureView];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}
//相册
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    NSMutableArray *choosedImages = [NSMutableArray new];
    for (int i = 0; i<assets.count; i++) {
        ALAsset *asset = [assets objectAtIndex:i];
        
        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [choosedImages addObject:image];
        if (choosedImages.count == assets.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageArr addObjectsFromArray:[choosedImages copy]];
//                [self resetPictureView];
            });
        }
    }
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, KDeviceWidth, KDeviceHeight-49-64)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.backgroundColor = [UIColor whiteColor];
        _mainScrollView.scrollEnabled = YES;
    }
    return _mainScrollView;
}


- (UIView *)pictureView{
    if (!_pictureView) {
        _pictureView = [UIView new];
        _pictureView.backgroundColor = [UIColor whiteColor];
    }
    return _pictureView;
}

- (UIButton *)addImageBtn{
    if (!_addImageBtn) {
        _addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addImageBtn.frame = CGRectMake(15,5, 90, 90);
        [_addImageBtn setImage:[UIImage imageNamed:@"upimg_icon_add"] forState:UIControlStateNormal];
        [_addImageBtn addTarget:self action:@selector(picAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageBtn;
}

- (UIButton*)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.layer.cornerRadius = 4.0f;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0xf54343];
        [_submitBtn addTarget:self action:@selector(submitEnterpriseInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
