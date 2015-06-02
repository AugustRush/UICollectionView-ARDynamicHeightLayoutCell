# UICollectionView+ARDynamicHeightLayoutCell

* An simple category for caculating autolayout UICollectionViewCell size.

## Demo gif 

<img src="https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell/blob/master/gif1.gif" width="320">

## Usage

if your cell use autolayout , all you need just to do like this:

#### Fixed width

```
#import "UICollectionView+ARDynamicHeightLayoutCell.h"

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell" fixedWidth:300 configuration:^(id cell) {

       //configuration your cell
        FeedModel *feed = self.feeds[indexPath.row];
        [cell filleCellWithFeed:feed];

    }];
}
```
#### Fixed height

```
#import "UICollectionView+ARDynamicHeightLayoutCell.h"

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell" fixedHeight:400 configuration:^(id cell) {
    	//configuration your cell
           FeedModel *feed = self.feeds[indexPath.row];
           [cell filleCellWithFeed:feed];
	}
}
```

#### Dynamic size

```
#import "UICollectionView+ARDynamicHeightLayoutCell.h"

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell" configuration:^(id cell) {
    	//configuration your cell
           FeedModel *feed = self.feeds[indexPath.row];
           [cell filleCellWithFeed:feed];
	}
}
```

## Install

pod 'UICollectionView-ARDynamicHeightLayoutCell', :git => 'https://github.com/AugustRush/UICollectionView-ARDynamicHeightLayoutCell.git'


## Release Versions

* v0.5 

    support to caculate size for UICollectionView Cell

* v0.6

    fixed Height caculated bug and support Dynamic size cell

* v0.7 

    add Support for StoryBoard

## ToDo

* add PreCache if needed

* add more exmples

