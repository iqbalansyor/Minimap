//
//  MinimapDataSource.h
//  Minimap
//
//  Created by Iqbal.ansyori on 24/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MinimapView;

@interface MinimapDataSource : NSObject

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *thumbnailView;
@property (assign, nonatomic) CGSize originViewSize;
@property (assign, nonatomic) CGFloat borderWidth;
@property (strong, nonatomic) UIColor *borderColor;
@property (assign, nonatomic) CGFloat downSizeRatio;

@property (nonatomic, readonly) CGFloat minimapViewHeight;
@property (nonatomic, readonly) CGFloat minimapViewWidth;
@property (nonatomic, readonly) CGRect scrollViewVisibleSize;

- (instancetype)initWithsScrollView:(UIScrollView *)scrollView thumbnailView:(UIView  *)view originViewSize:(CGSize)size;
- (void)resizeMinimapView:(MinimapView *)view;
- (CGRect)currentRect:(CGRect)rect;

@end
