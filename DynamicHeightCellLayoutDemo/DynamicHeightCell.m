//
//  DynamicHeightCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "DynamicHeightCell.h"

@implementation DynamicHeightCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //minus 20 pixel is cell's width, cell's width minus 16 pixel is contentLabel's width
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20 - 16;
}

-(void)filleCellWithFeed:(FeedModel *)feed
{
    self.textlabel.text = feed.title;
    self.imageView.image = feed.image;
    self.contentLabel.text = feed.content;
}


@end
