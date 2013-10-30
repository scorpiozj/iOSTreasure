//
//  ZJClassReusableView.m
//  CollectionsSample
//
//  Created by Zhu J on 10/30/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJClassReusableView.h"
#import "ZJCustomLayout.h"
@interface ZJClassReusableView()
@property (nonatomic) NSArray *pointArray;
@end


@implementation ZJClassReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    [super drawRect:rect];
    // Drawing code
    
    CGRect frame = self.frame;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 2);
    NSUInteger count = self.pointArray.count;
    for (NSUInteger num = 0; num < count; num ++)
    {
        CGPoint point = [[self.pointArray objectAtIndex:num] CGPointValue];
        CGFloat xPosition = point.x - frame.origin.x;
        
        
        if (num == 0)
        {
            CGContextMoveToPoint(context, xPosition, 0);
            CGContextAddLineToPoint(context, xPosition, rect.size.height);
        }
        else
        {
            CGContextMoveToPoint(context, xPosition, frame.size.height/2);
            CGContextAddLineToPoint(context, xPosition, rect.size.height);
        }
        
        
    }
    if (count > 1)
    {
        CGPoint first = [[self.pointArray objectAtIndex:0] CGPointValue];
        CGPoint last = [[self.pointArray lastObject] CGPointValue];
        
        CGContextMoveToPoint(context, first.x - frame.origin.x, frame.size.height/2);
        CGContextAddLineToPoint(context, last.x - frame.origin.x + 1, frame.size.height/2);
    }
    
    CGContextStrokePath(context);
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
//    ZJCollectionSuppleLayoutAttributes *suppleAttri = (ZJCollectionSuppleLayoutAttributes *)layoutAttributes;
//    if (!CGSizeEqualToSize(suppleAttri.frame.size, CGSizeZero))
//    {
//        self.hidden = NO;
//    }
    self.pointArray = ((ZJCollectionSuppleLayoutAttributes *)layoutAttributes).pointArray;
}

- (void)prepareForReuse
{
    [super prepareForReuse];

}
@end
