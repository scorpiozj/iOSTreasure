//
//  ZJCustomCollectionViewController.m
//  CollectionsSample
//
//  Created by Zhu J on 10/29/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCustomCollectionViewController.h"
#import "ZJCustomLayout.h"
#import "ZJCell.h"
#import "ZJClassReusableView.h"




@interface ZJCustomCollectionViewController ()<ZJCustomLayoutProtocol,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) ZJCustomLayout *customLayout;
@end

@implementation ZJCustomCollectionViewController

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
    
//    _customLayout = [[ZJCustomLayout alloc] init];
//    self.collectionView.collectionViewLayout = self.customLayout;
//    self.customLayout.customDataSource = self;
    
    ZJCustomLayout *layout = (ZJCustomLayout *)self.collectionView.collectionViewLayout;
    layout.customDataSource = self;
    
    
    self.collectionView.backgroundColor = [UIColor redColor];
    
    [self.collectionView registerClass:[ZJClassReusableView class]
            forSupplementaryViewOfKind:ZJSupplementKindDiagram
                   withReuseIdentifier:@"ZJClassDiagram"];

}

//- (void)awakeFromNib
//{
//    [self.collectionView registerClass:[ZJClassReusableView class]
//            forSupplementaryViewOfKind:ZJSupplementKindDiagram
//                   withReuseIdentifier:@"ZJClassDiagram"];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ZJCustomLayout
- (NSInteger)numRowsForClassAndChildrenAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return [self collectionView:self.collectionView numberOfItemsInSection:indexPath.section];
    
    switch (indexPath.section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
    
    return 0;
}
- (NSArray *)childrenAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    switch (section)
    {
        case 0:
        {
            NSInteger capacuty = 3;
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:capacuty];
            for (int i = 0; i < capacuty; i ++)
            {
                [mArray addObject:[NSIndexPath indexPathForRow:i inSection:section + 1]];
            }
            return mArray;
            break;
        }
        case 1:
        {
            if (1 == indexPath.row)
            {
                return @[[NSIndexPath indexPathForRow:0 inSection:section + 1],[NSIndexPath indexPathForRow:1 inSection:section + 1]];
            }
            else if (2 == indexPath.row)
            {
                return @[[NSIndexPath indexPathForRow:2 inSection:section + 1]];
            }
//            else if (3 == indexPath.row)
//            {
//                return @[[NSIndexPath indexPathForRow:3 inSection:section + 1]];
//            }
//            else if (6 == indexPath.row)
//            {
//                return @[[NSIndexPath indexPathForRow:1 inSection:2],[NSIndexPath indexPathForRow:2 inSection:2]];
//            }

            break;
        }
//        case 2:
//        {
//            if (0 == indexPath.row)
//            {
//                return @[[NSIndexPath indexPathForRow:0 inSection:section + 1],[NSIndexPath indexPathForRow:1 inSection:section + 1]];
//            }
//            break;
//        }
        default:
            
            break;
    }
    return nil;
}


#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    switch (section)
    {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
        default:
            break;
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZJClassCell *classCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZJClassCell" forIndexPath:indexPath];
    classCell.textLabel.text = [NSString stringWithFormat:@"sec: %d,row: %d\n%@",indexPath.section, indexPath.row,NSStringFromCGRect(classCell.frame)];
    
    return classCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    
    ZJClassReusableView *classLine = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZJClassDiagram" forIndexPath:indexPath];

    return classLine;
    
}
@end
