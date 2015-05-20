//
//  UICollectionView+ARDynamicHeightLayoutCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UICollectionView+ARDynamicHeightLayoutCell.h"
#import <objc/runtime.h>

#define kScreenWidth    [[UIScreen mainScreen] bounds].size.width

@implementation UICollectionView (ARDynamicHeightLayoutCell)

+(void)initialize
{
    SEL selectors[] = {@selector(registerNib:forCellWithReuseIdentifier:),
                       @selector(registerClass:forCellWithReuseIdentifier:)};
    
    for (int i = 0; i < sizeof(selectors)/sizeof(SEL); i++) {
        SEL originalSelector = selectors[i];
        SEL swizzledSelector = NSSelectorFromString([@"ar_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id))configuration
{
    UICollectionViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    CGSize size  = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size;
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier fixedWidth:(CGFloat)fixedWidth configuration:(void (^)(id))configuration
{
    UICollectionViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    NSLayoutConstraint *tempConstraint = [NSLayoutConstraint
                                          constraintWithItem:cell.contentView
                                          attribute:NSLayoutAttributeWidth
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                          multiplier:1
                                          constant:fixedWidth];
    [cell.contentView addConstraint:tempConstraint];
    CGSize size  = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell.contentView removeConstraint:tempConstraint];
    return size;

}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier fixedHeight:(CGFloat)fixedHeight configuration:(void (^)(id))configuration
{
    UICollectionViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    NSLayoutConstraint *tempConstraint = [NSLayoutConstraint
                                          constraintWithItem:cell.contentView
                                          attribute:NSLayoutAttributeHeight
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                          multiplier:1
                                          constant:fixedHeight];
    [cell.contentView addConstraint:tempConstraint];
    CGSize size  = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell.contentView removeConstraint:tempConstraint];
    return size;
}

#pragma mark - swizzled methods

-(void)ar_registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self ar_registerClass:cellClass forCellWithReuseIdentifier:identifier];
    
    id cell = [[cellClass alloc] initWithFrame:CGRectZero];
    NSMutableDictionary *templeCells = [self templeCells];
    templeCells[identifier] = cell;
}

-(void)ar_registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier
{
    [self ar_registerNib:nib forCellWithReuseIdentifier:identifier];
    id cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
    NSMutableDictionary *templeCells = [self templeCells];
    templeCells[identifier] = cell;
}

#pragma mark - private methods

-(NSMutableDictionary *)templeCells
{
    NSMutableDictionary *templeCells = objc_getAssociatedObject(self, _cmd);
    if (templeCells == nil) {
        templeCells = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templeCells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return templeCells;
}

-(id)templeCaculateCellWithIdentifier:(NSString *)identifier
{
    return [[self templeCells] objectForKey:identifier];
}

@end
