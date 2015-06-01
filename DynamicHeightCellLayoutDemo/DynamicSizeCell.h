//
//  DynamicSizeCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedModel.h"

@interface DynamicSizeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

-(void)filleCellWithFeed:(FeedModel *)feed;

@end
