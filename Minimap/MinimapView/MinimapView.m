//
//  MinimapView.m
//  Minimap
//
//  Created by Iqbal.ansyori on 24/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import "MinimapView.h"
#import "MinimapDataSource.h"

@interface MinimapView()

@property (strong, nonatomic, nullable) MinimapDataSource *dataSource;

@end

@implementation MinimapView

- (void)set:(MinimapDataSource *)dataSource {
    self.dataSource = dataSource;
                       
    self.miniView = dataSource.thumbnailView;
    self.miniView.frame = CGRectMake(0, 0, dataSource.minimapViewWidth, dataSource.minimapViewHeight);
    self.miniView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.focusedBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dataSource.minimapViewWidth, dataSource.minimapViewHeight)];
    self.focusedBoxView.layer.borderWidth = dataSource.borderWidth;
    self.focusedBoxView.layer.borderColor = dataSource.borderColor.CGColor;
    
    [self addSubview:self.miniView];
    [self addSubview:self.focusedBoxView];
    
    [self updateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self removeConstraints:self.constraints];
    
    if (self.dataSource) {
        [self.heightAnchor constraintEqualToConstant:self.dataSource.minimapViewHeight].active = YES;
        [self.widthAnchor constraintEqualToConstant:self.dataSource.minimapViewWidth].active = YES;
        
        [self.trailingAnchor constraintEqualToAnchor:self.dataSource.scrollView.trailingAnchor constant:50].active = YES;
        [self.bottomAnchor constraintEqualToAnchor:self.dataSource.scrollView.bottomAnchor constant:50].active = YES;
    }
}

@end
