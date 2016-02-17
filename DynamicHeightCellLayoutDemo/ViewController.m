//
//  ViewController.m
//  DynamicHeightCellLayoutDemo
//
//  Created by August on 15/5/19.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "DynamicHeightCell.h"
#import "DynamicSizeCell.h"

#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, assign) BOOL onlyImage;

@property (nonatomic, strong) NSMutableArray *feeds;
- (IBAction)addFeed:(id)sender;
- (IBAction)changeLayoutDirection:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"DynamicHeightLayoutCell";
    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicHeightCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicHeightCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicSizeCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicSizeCell"];
    
    
    // demo data
    self.feeds = [NSMutableArray array];
    NSArray *titles = @[@"AugustRush",
                        @"Dynamic Cell",
                        @"AutoLayout"];
    NSArray *contents = @[@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urnaet arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. \n\nInteger aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.\n\n\n Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor.\n Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum  ***This Is The End***",
                          @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum",
                          @"I'm August rush , he's a boy in a Moivie"];
    
    NSArray *images = @[[UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"Jiker.png"]];
    //add temple data
    for (int i = 0; i < 20; i++) {
        FeedModel *feed = [[FeedModel alloc] init];
        feed.title = titles[arc4random()%3];
        feed.content = contents[arc4random()%3];
        feed.image = images[arc4random()%4];
        
        [self.feeds addObject:feed];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - flowlayout 

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FeedModel *feed = self.feeds[indexPath.row];
    if (self.onlyImage) {
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicSizeCell"
                                                  indexPath:indexPath
                                              configuration:^(__kindof UICollectionViewCell * cell) {
            [cell filleCellWithFeed:feed];
        }];
                
    }else{
        //get screen width & minus 20 points
        CGFloat width = [[UIScreen mainScreen] bounds].size.width - 20;
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell"
                                                  indexPath:indexPath
                                                 fixedWidth:width configuration:^(id cell) {
            [cell filleCellWithFeed:feed];
        }];
    }
}

#pragma mark - dataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.feeds.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.onlyImage) {
        DynamicSizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicSizeCell" forIndexPath:indexPath];
        FeedModel *feed = self.feeds[indexPath.row];
        [cell filleCellWithFeed:feed];
        return cell;
    }else{
        DynamicHeightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];
        FeedModel *feed = self.feeds[indexPath.row];
        [cell filleCellWithFeed:feed];
        
        return cell;
    
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [collectionView performBatchUpdates:^{
        [self.feeds exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - change cell type

- (IBAction)addFeed:(id)sender {
    FeedModel *feed = [[FeedModel alloc] init];
    feed.title = @"Dynamic Cell";
    feed.content = @"This just use to test text, what are they funcking talking. let us to see your baby.";
    
    NSArray *images = @[[UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"Jiker.png"]];
    feed.image = images[arc4random()%4];
    
    [self.feeds addObject:feed];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.feeds.count - 1 inSection:0];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];
}

- (IBAction)changeLayoutDirection:(id)sender {
    [self.flowLayout invalidateLayout];
    self.onlyImage = !self.onlyImage;
    [self.collectionView reloadData];

}

@end
