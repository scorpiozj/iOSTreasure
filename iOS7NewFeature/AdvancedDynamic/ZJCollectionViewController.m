//
//  ZJCollectionViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/24/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCollectionViewController.h"
#import "ZJCollectionsLayout.h"

@implementation ZJFollowLayout
- (void)prepareLayout
{
    [super prepareLayout];
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return nil;
}
@end

@interface ZJCollectionCell ()
@property (nonatomic)   UIImageView *imgView;
@property (nonatomic)   UILabel *textLabel;
@end

@implementation ZJCollectionCell
- (void)bindData:(id)object
{
    NSIndexPath *indexPath = (NSIndexPath *)object;
    
    CGRect rect = self.bounds;
    CGRect imgRect = CGRectMake(5, 5, rect.size.width - 5*2, rect.size.height - 25);
    _imgView = [[UIImageView alloc] initWithFrame:imgRect];
    
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d.JPG",[indexPath row]%9]];
    self.imgView.image = img;
    [self.contentView addSubview:self.imgView];
    
    
}


@end







@interface ZJCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachment;

@end

@implementation ZJCollectionViewController
- (instancetype)initWithSampleLayout
{
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(80, 80);

    
    DraggableLayout *dragLayout = [[DraggableLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = 20;
//    flowLayout.minimumLineSpacing = 30;
    
    if (self = [super initWithCollectionViewLayout:dragLayout])
    {
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
//        self.collectionView.dataSource = self;
//        self.collectionView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.collectionView registerClass:[ZJCollectionCell class] forCellWithReuseIdentifier:@"cellTest"];
    
    
    _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self.collectionViewLayout];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 12;
    }
    return 5;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellTest";
    
    ZJCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell bindData:indexPath];
//    UICollectionViewLayoutAttributes *attribute = [self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    if (!_attachment)
//    {
//        _attachment = [[UIAttachmentBehavior alloc] initWithItem:attribute attachedToAnchor:CGPointMake(160, 0)];
//        self.attachment.damping = .2;
//        self.attachment.frequency = 2.0;
//        [self.animator addBehavior:self.attachment];
//        
//        UIGravityBehavior *grativity = [[UIGravityBehavior alloc] initWithItems:@[attribute]];
//        [self.animator addBehavior:grativity];
//        
//        
//        UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[attribute] mode:UIPushBehaviorModeContinuous];
//        [push setAngle:-M_PI_2 magnitude:.3];
//        [self.animator addBehavior:push];
//    }
//    
//    [self.animator updateItemUsingCurrentState:attribute];
    

    
    return cell;
}

@end
