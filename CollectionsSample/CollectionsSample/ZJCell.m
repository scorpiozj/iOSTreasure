//
//  ZJCell.m
//  CollectionsSample
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJCell.h"

@implementation ZJCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end


@implementation ZJClassCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor colorWithRed:.1 green:.2 blue:1.0 alpha:.9];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    self.layer.borderColor = [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 2;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 3;
    
    self.layer.cornerRadius = 4;
    
    self.layer.shouldRasterize = YES;
}
@end