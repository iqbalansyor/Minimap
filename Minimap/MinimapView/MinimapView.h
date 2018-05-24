//
//  MinimapView.h
//  Minimap
//
//  Created by Iqbal.ansyori on 24/05/18.
//  Copyright © 2018 Iqbal.ansyori. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MinimapDataSource;

@interface MinimapView : UIView

@property (strong, nonatomic, nullable) UIView *miniView;
@property (strong, nonatomic, nullable) UIView *focusedBoxView;

- (void)set:(MinimapDataSource *)dataSource;

@end
