//
//  CircleLayout.m
//  CollectionViewTestDemo
//
//  Created by sfwan on 14-10-15.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "CircleLayout.h"
//#define ITEM_WIDTH          100

@implementation CircleLayout

- (CGSize)collectionViewContentSize
{
    CGFloat width = ITEM_WIDTH * [self.collectionView numberOfItemsInSection:0] + self.minimumInteritemSpacing * ([self.collectionView numberOfItemsInSection:0] + 1);
    width *= 3;
    CGFloat height = self.collectionView.frame.size.height;
    
    self.showCount = kScreenWidth / (ITEM_WIDTH + self.minimumInteritemSpacing);
    
    if (kScreenWidth - self.showCount * (ITEM_WIDTH + self.minimumInteritemSpacing) > (ITEM_WIDTH+self.minimumInteritemSpacing)/2.0) {
        self.showCount += 1;
    }
    
    return CGSizeMake(width, height);
}

- (void)prepareLayout
{
    [super prepareLayout];
    
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    NSInteger i = 0;
    NSInteger numofCollection = [self.collectionView numberOfItemsInSection:0 ];
    for (; i < numofCollection; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size = [self itemSizeForIndexPath:indexPath];
    attributes.size = size;
    attributes.center = [self circlePointIndexPath:indexPath];
    
    return attributes;
}


-(CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        CGSize size = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        return size;
    }
    
    return CGSizeZero;
}


-(CGFloat)minimumInteritemSpacingForSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    }
    return 0;
}

-(CGFloat)minimumInteritemSpacing
{
    return [self minimumInteritemSpacingForSection:0];
}


#pragma mark - others

-(CGPoint)circlePointIndexPath:(NSIndexPath *)indexPath
{
    CGPoint center;
    
    NSInteger numofCollection = [self.collectionView numberOfItemsInSection:0 ];
    CGFloat height = self.collectionView.frame.size.height;
    NSInteger item = indexPath.item;
    CGSize size = [self itemSizeForIndexPath:indexPath];
    CGFloat width = size.width + self.minimumInteritemSpacing;
    
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    NSInteger page = (contentOffsetX + kScreenWidth)/((numofCollection)* width);
    NSInteger yushu = (contentOffsetX + kScreenWidth)- page *((numofCollection)* width);
    
    CGFloat xx = item * width + width/2.0;
    
    CGFloat pageWidth = page * numofCollection  * width;
    
    if (item >= numofCollection - self.showCount && yushu < (numofCollection - self.showCount) * width) {
        xx = item * width + width/2.0 + MAX(0, (page -1)) * numofCollection  * width;
    } else {
        xx = (item * width + width/2.0) + pageWidth;
    }
    
    
//    NSLog(@"p=%d-- ys=%d -- xx=%f--wid=%f", page,yushu, xx, pageWidth);
    
    center.x = xx;
    center.y = height/2.0;
    
    return center;
}

@end
