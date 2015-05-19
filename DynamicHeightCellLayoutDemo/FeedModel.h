//
//  FeedModel.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedModel : NSObject

@property (nonatomic,  copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *image;

@end
