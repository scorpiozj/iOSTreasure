//
//  ZJASCIIDynamicItem.h
//  AdvancedDynamic
//
//  Created by Zhu J on 10/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJASCIIDynamicItem : NSObject<UIDynamicItem>
//@property (nonatomic, readonly) CGRect bounds;
//@property (nonatomic, readwrite) CGPoint center;
//@property (nonatomic, readwrite) CGAffineTransform transform;
- (instancetype)initWithTarget:(id<UIDynamicItem>)target;
@end
