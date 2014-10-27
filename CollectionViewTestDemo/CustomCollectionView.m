//
//  CustomCollectionView.m
//  CollectionViewTestDemo
//
//  Created by sfwan on 14-10-15.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CustomCollectionView.h"
#import "CustomCell.h"
#import "CircleLayout.h"

#define kSpaceWidth     20
//#define kItemWidth      100
//#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

#define CELL_ID         @"cellId"
@interface CustomCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CircleLayoutDelegate>

@end

@implementation CustomCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self _initViews];
    
}

-(void)_initViews
{
    self.dataSource = self;
    self.delegate = self;
    ((CircleLayout*)self.collectionViewLayout).delegate = self;
    UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:CELL_ID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%d", indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ITEM_WIDTH, ITEM_WIDTH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kSpaceWidth;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d", indexPath.item);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.x);
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    NSInteger showCount = ((CircleLayout*)self.collectionViewLayout).showCount;
    
    // virtual originalX 1100
    CGFloat originalX = [self numberOfItemsInSection:0] * (ITEM_WIDTH + kSpaceWidth);
    CGFloat originalY = scrollView.contentOffset.y;
    
    if (contentOffsetX <= 0) {
        self.contentOffset = CGPointMake(originalX, originalY);
    }
    // virtual contentSizeWidth 770
    CGFloat contentSizeWidth = ([self numberOfItemsInSection:0] - showCount) * (ITEM_WIDTH + kSpaceWidth);
    if (contentOffsetX >= scrollView.contentSize.width - kScreenWidth -kSpaceWidth*showCount) {
        self.contentOffset = CGPointMake(contentSizeWidth, originalY);
    }
}

@end
