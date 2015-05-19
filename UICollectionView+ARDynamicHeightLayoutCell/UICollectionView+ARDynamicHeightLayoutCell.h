//
//  UICollectionView+ARDynamicHeightLayoutCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (ARDynamicHeightLayoutCell)

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier configuration:(void(^)(id cell))configuration;

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier fixedWidth:(CGFloat)fixedWidth configuration:(void (^)(id cell))configuration;

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier fixedHeight:(CGFloat)fixedHeight configuration:(void (^)(id cell))configuration;

@end
