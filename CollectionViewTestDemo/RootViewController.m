//
//  RootViewController.m
//  CollectionViewTestDemo
//
//  Created by sfwan on 14-10-15.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

#import "RootViewController.h"
#import "CustomCollectionView.h"

@interface RootViewController ()
@property (weak, nonatomic) IBOutlet CustomCollectionView *collectionView;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
