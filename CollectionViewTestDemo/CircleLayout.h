//
//  CircleLayout.h
//  CollectionViewTestDemo
//
//  Created by sfwan on 14-10-15.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define ITEM_WIDTH          80
@protocol CircleLayoutDelegate <UICollectionViewDelegateFlowLayout>

@end

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) id<CircleLayoutDelegate>delegate;

@property (nonatomic, assign) NSInteger showCount;

@end
