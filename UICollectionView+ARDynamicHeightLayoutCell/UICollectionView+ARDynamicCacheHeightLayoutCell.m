//
//  UICollectionView+ARDynamicHeightLayoutCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, ARDynamicSizeCaculateType) {
    ARDynamicSizeCaculateTypeSize = 0,
    ARDynamicSizeCaculateTypeHeight,
    ARDynamicSizeCaculateTypeWidth
};

@implementation UICollectionView (ARDynamicCacheHeightLayoutCell)

+(void)initialize
{
    SEL selectors[] =
    {@selector(registerNib:forCellWithReuseIdentifier:),
    @selector(registerClass:forCellWithReuseIdentifier:),
    @selector(reloadData),
    @selector(reloadSections:),
    @selector(insertSections:),
    @selector(deleteSections:),
    @selector(moveSection:toSection:),
    @selector(reloadItemsAtIndexPaths:),
    @selector(deleteItemsAtIndexPaths:),
    @selector(insertItemsAtIndexPaths:),
    @selector(moveItemAtIndexPath:toIndexPath:)};
    
    for (int i = 0; i < sizeof(selectors)/sizeof(SEL); i++) {
        SEL originalSelector = selectors[i];
        SEL swizzledSelector = NSSelectorFromString([@"ar_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath configuration:(void (^)(id))configuration
{
    return [self ar_sizeForCellWithIdentifier:identifier indexPath:indexPath fixedValue:0 caculateType:ARDynamicSizeCaculateTypeSize configuration:configuration];
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath fixedWidth:(CGFloat)fixedWidth configuration:(void (^)(id))configuration
{
    return [self ar_sizeForCellWithIdentifier:identifier indexPath:indexPath fixedValue:fixedWidth caculateType:ARDynamicSizeCaculateTypeWidth configuration:configuration];
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath fixedHeight:(CGFloat)fixedHeight configuration:(void (^)(id))configuration
{
    return [self ar_sizeForCellWithIdentifier:identifier indexPath:indexPath fixedValue:fixedHeight caculateType:ARDynamicSizeCaculateTypeHeight configuration:configuration];
}

-(CGSize)ar_sizeForCellWithIdentifier:(NSString *)identifier
                            indexPath:(NSIndexPath *)indexPath
                           fixedValue:(CGFloat)fixedValue
                         caculateType:(ARDynamicSizeCaculateType)caculateType
                        configuration:(void (^)(id))configuration
{
    if ([self hasCacheAtIndexPath:indexPath]) {
        return [self sizeCacheAtIndexPath:indexPath];
    }
    
    //has no size chche
    UICollectionViewCell *cell = [self templeCaculateCellWithIdentifier:identifier];
    configuration(cell);
    CGSize size = CGSizeMake(fixedValue, fixedValue);
    if (caculateType != ARDynamicSizeCaculateTypeSize) {
        NSLayoutAttribute attribute = caculateType == ARDynamicSizeCaculateTypeWidth? NSLayoutAttributeWidth:NSLayoutAttributeHeight;
        NSLayoutConstraint *tempConstraint = [NSLayoutConstraint
                                              constraintWithItem:cell.contentView
                                              attribute:attribute
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1
                                              constant:fixedValue];
        [cell.contentView addConstraint:tempConstraint];
        size  = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [cell.contentView removeConstraint:tempConstraint];
    }else{
        size  = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }
    
    NSMutableArray *sectionCache = [self sizeCache][indexPath.section];
    [sectionCache addObject:[NSValue valueWithCGSize:size]];
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

#pragma mark - section changes

-(void)ar_reloadSections:(NSIndexSet *)sections
{
    [self ar_reloadSections:sections];
}

-(void)ar_insertSections:(NSIndexSet *)sections
{
    [self ar_insertSections:sections];
}

-(void)ar_deleteSections:(NSIndexSet *)sections
{
    [self ar_deleteSections:sections];
}

-(void)ar_moveSection:(NSInteger)section toSection:(NSInteger)newSection
{
    [self ar_moveSection:section toSection:newSection];
}

#pragma mark - item changes

-(void)ar_insertItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self ar_insertItemsAtIndexPaths:indexPaths];
}

-(void)ar_deleteItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self ar_deleteItemsAtIndexPaths:indexPaths];
}

-(void)ar_reloadItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self ar_reloadItemsAtIndexPaths:indexPaths];
}

-(void)ar_moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
    [self ar_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
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
    NSMutableDictionary *templeCells = [self templeCells];
    id cell = [templeCells objectForKey:identifier];
    if (cell == nil) {
        NSDictionary *cellNibDict = [self valueForKey:@"_cellNibDict"];
        UINib *cellNIb = cellNibDict[identifier];
        cell = [[cellNIb instantiateWithOwner:nil options:nil] lastObject];
        templeCells[identifier] = cell;
    }
    
    return cell;
}

#pragma mark - cache methods

-(NSMutableArray *)sizeCache
{
    NSMutableArray *cache = objc_getAssociatedObject(self, _cmd);
    if (cache == nil) {
        cache = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN);
    }
    return cache;
}

-(BOOL)hasCacheAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL hasCache = NO;
    if ([self sizeCache].count > indexPath.section) {
        if ([[self sizeCache][indexPath.section] count] > indexPath.row) {
            hasCache = YES;
        }
    }else{
        [[self sizeCache] addObject:@[].mutableCopy];
    }
    
    return hasCache;
}

-(CGSize)sizeCacheAtIndexPath:(NSIndexPath *)indexPath
{
    NSValue *sizeValue = [self sizeCache][indexPath.section][indexPath.row];
    return [sizeValue CGSizeValue];
}

@end
