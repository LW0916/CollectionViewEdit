//
//  ViewController.m
//  CollectionViewEditTest
//
//  Created by lwmini on 2018/9/10.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "ViewController.h"
#import "LWCollectionViewCell.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *mainCollectionLayout;
@property(nonatomic,strong)NSMutableArray *myDataSource;
@end

@implementation ViewController
- (NSMutableArray *)myDataSource{
    if (_myDataSource == nil) {
        _myDataSource = [[NSMutableArray alloc]init];
    }
    return _myDataSource;
}

- (UICollectionView *)mainCollectionView{
    if (_mainCollectionView == nil) {
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.mainCollectionLayout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.bounces = NO;
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        [_mainCollectionView registerClass:[LWCollectionViewCell class]
                forCellWithReuseIdentifier:@"SUBVIEW"];
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
         [_mainCollectionView addGestureRecognizer:longPressGesture];
    }
    return _mainCollectionView;
}
- (UICollectionViewFlowLayout *)mainCollectionLayout{
    if (_mainCollectionLayout == nil) {
        _mainCollectionLayout = [[UICollectionViewFlowLayout alloc]init];
        _mainCollectionLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        _mainCollectionLayout.minimumLineSpacing = 20;
        _mainCollectionLayout.minimumInteritemSpacing = 20;
        _mainCollectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return _mainCollectionLayout;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i =0;i<40; i++) {
        [self.myDataSource addObject:[NSString stringWithFormat:@"卡片%d",i]];
    }
    [self.view addSubview:self.mainCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    LWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SUBVIEW" forIndexPath:indexPath];
    cell.contentLabel.text = self.myDataSource[indexPath.row];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {

    [self.myDataSource exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath{
    /* 可以指定位置禁止交换 */
    if (proposedIndexPath.item < 3) {
        return originalIndexPath;
    } else {
        return proposedIndexPath;
    }
}
#pragma mark - UICollectionViewDelegate

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_mainCollectionView];
    NSIndexPath *indexPath = [self.mainCollectionView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            [_mainCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [_mainCollectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            [_mainCollectionView endInteractiveMovement];
            break;
        default:
            //取消移动
            [_mainCollectionView endInteractiveMovement];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
