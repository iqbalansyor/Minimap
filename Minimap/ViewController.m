//
//  ViewController.m
//  Minimap
//
//  Created by Iqbal.ansyori on 23/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import "ViewController.h"
#import "MinimapView.h"
#import "MinimapDataSource.h"
#import "MiniView.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet MinimapView *minimapView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) MinimapDataSource *minimapDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self minimap];
    
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.scrollView.delegate = self;
    
    CGRect rect = CGRectMake(self.bigView.frame.origin.x, self.bigView.frame.origin.y, self.imageView.image.size.width, self.imageView.image.size.height);
    self.bigView.frame = rect;
    
    [self recenterView];
    [self setZoomParameterForSize:self.scrollView.bounds.size];
}

- (void)minimap {
    UIView *miniView = [[MiniView alloc] initWithFrame:CGRectMake(0, 0, self.minimapView.frame.size.width * 2, self.minimapView.frame.size.height * 2)];
    
    MinimapDataSource *minimapDataSource = [[MinimapDataSource alloc] initWithsScrollView:self.scrollView thumbnailView:miniView originViewSize:CGSizeMake(5214, 7300)];
    minimapDataSource.borderWidth = 2.0;
    minimapDataSource.borderColor = [UIColor yellowColor];
    minimapDataSource.downSizeRatio = 2.0;
    
    self.minimapDataSource = minimapDataSource;
    [self.minimapView set:minimapDataSource];
}

- (void)recenterView {
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGSize imageSize = self.imageView.frame.size;
    CGFloat horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0;
    CGFloat verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2  : 0;
    
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace);
}

- (void)setZoomParameterForSize:(CGSize)scrollViewSize {
    CGSize imageSize = self.imageView.bounds.size;
    CGFloat widthScale = scrollViewSize.width / imageSize.width;
    CGFloat heightScale = scrollViewSize.height / imageSize.height;
    CGFloat minScale = MIN(widthScale, heightScale);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.zoomScale = minScale;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.minimapDataSource resizeMinimapView:self.minimapView];
}

@end
