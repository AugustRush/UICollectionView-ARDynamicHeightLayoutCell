# UICollectionView+ARDynamicHeightLayoutCell

* An simple category for caculating autolayout UICollectionViewCell size.

## Demo gif 

<img src="https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell/blob/master/gif1.gif" width="320">

## Usage

if your cell use autolayout , all you need just to do like this:

```
#import "UICollectionView+ARDynamicHeightLayoutCell.h"

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell" fixedWidth:300 configuration:^(id cell) {
        FeedModel *feed = self.feeds[indexPath.row];
        [cell filleCellWithFeed:feed];

    }];
}
```
if you using UITableView ,you should use 'https://github.com/forkingdog/UITableView-FDTemplateLayoutCell'.

## Install

pod 'UICollectionView-ARDynamicHeightLayoutCell', :git => 'https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell.git'