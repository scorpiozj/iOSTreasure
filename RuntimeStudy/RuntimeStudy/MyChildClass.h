//
//  MyChildClass.h
//  RuntimeStudy
//
//  Created by Zhu J on 10/17/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "MyClass.h"
#import "InvocationClass.h"
@interface MyChildClass : MyClass
@property (nonatomic, weak) NSDate *today;
@property InvocationClass *vocation;
@end
