//
//  ZJCollectionsViewController.m
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCollectionsViewController.h"
#import "ZJCell.h"
#import "ZJSupplementaryView.h"

@interface ZJCollectionsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ZJCollectionsViewController

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
	// Do any additional setup after loading the view.
//    self.collectionView.contentInset = UIEdgeInsetsMake(1, 10, 20, 10);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJCell" forIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"%d.JPG",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imgName];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZJSupplementaryView *supplementaryView = nil;
    NSString *text = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CLHeader" forIndexPath:indexPath];
        text = [NSString stringWithFormat:@"Header %d",indexPath.section];
        supplementaryView.backgroundColor = [UIColor darkGrayColor];
    }
    else
    {
        supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"CLFooter" forIndexPath:indexPath];;
        text = [NSString stringWithFormat:@"Footer %d",indexPath.section];
        supplementaryView.backgroundColor = [UIColor lightGrayColor];
    }

    supplementaryView.label.text = text;
    return supplementaryView;
}
@end
