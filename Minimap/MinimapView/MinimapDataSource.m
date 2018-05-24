//
//  MinimapDataSource.m
//  Minimap
//
//  Created by Iqbal.ansyori on 24/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinimapDataSource.h"
#import "MinimapView.h"

@implementation MinimapDataSource

- (instancetype)initWithsScrollView:(UIScrollView *)scrollView thumbnailView:(UIView  *)view originViewSize:(CGSize)size {
    
    self = [super init];
    
    if (self) {
        self.scrollView = scrollView;
        self.thumbnailView = view;
        self.originViewSize = size;
        self.borderWidth = 0.0f;
        self.borderColor = [[UIColor alloc] init];
        self.downSizeRatio = 0.0f;
    }
    
    return self;
    
}

- (CGFloat)minimapViewHeight {
    CGFloat height = (self.thumbnailView.frame.size.height)/self.downSizeRatio;
    NSLog(@"minimap view height: %.2f", height);
    return height;
}

- (CGFloat)minimapViewWidth {
    CGFloat width = (self.thumbnailView.frame.size.width)/self.downSizeRatio;
    NSLog(@"minimap view width: %.2f", width);
    return width;
}

- (CGRect)scrollViewVisibleSize {
    CGFloat zoomScale = self.scrollView.zoomScale;
    
    CGFloat scrollViewX = self.scrollView.contentOffset.x;
    CGFloat scrollViewY = self.scrollView.contentOffset.y;
    CGFloat scrollViewHeight = self.scrollView.bounds.size.height;
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;
    
    CGFloat ratio = self.originViewSize.height/self.thumbnailView.bounds.size.height;
    CGRect visibleRect = CGRectMake((scrollViewX/ratio)/zoomScale, (scrollViewY/ratio)/zoomScale, (scrollViewWidth/ratio)/zoomScale, (scrollViewHeight/ratio)/zoomScale);
    return visibleRect;
}

- (CGRect)currentRect:(CGRect)rect {
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    if (x < 0.0) {
        width += x;
        x = 0.0;
    }
    
    if (y < 0.0) {
        height += y;
        y = 0.0;
    }
    
    if (self.minimapViewHeight < height) {
        height = self.minimapViewHeight;
    }
    
    if (y + height > self.minimapViewHeight) {
        height = self.minimapViewHeight - y;
    }
    
    if (self.minimapViewWidth < width) {
        width = self.minimapViewWidth;
    }
    
    if (x + width > self.minimapViewWidth) {
        width = self.minimapViewWidth - x;
    }
    
    return CGRectMake(x, y, width, height);
}

- (void)resizeMinimapView:(MinimapView *)view {
    CGRect rect = [self divideCGRectByDouble:self.downSizeRatio rect:self.scrollViewVisibleSize];
    view.focusedBoxView.frame = [self currentRect:rect];
}

- (CGRect)divideCGRectByDouble:(CGFloat)ratio rect:(CGRect)rect {
    return CGRectMake(rect.origin.x/ratio, rect.origin.y/ratio, rect.size.width/ratio, rect.size.height/ratio);
}

@end
