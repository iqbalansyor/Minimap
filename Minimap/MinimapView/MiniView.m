//
//  MiniView.m
//  Minimap
//
//  Created by Iqbal.ansyori on 24/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import "MiniView.h"

@implementation MiniView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self loadView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self loadView];
    }
    
    return self;
}

- (void)loadView {
    
    UIView *view = [NSBundle.mainBundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    [self addSubview:view];
}

@end
