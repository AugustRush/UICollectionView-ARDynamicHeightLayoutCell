//
//  DynamicSizeCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DynamicSizeCell.h"

@implementation DynamicSizeCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)filleCellWithFeed:(FeedModel *)feed
{
    self.imageView.image = feed.image;
}

@end
