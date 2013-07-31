//
//  AssetsCollectionViewController.m
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "AssetsCollectionViewController.h"
#import "PhotoCell.h"

@interface AssetsCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation AssetsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self reloadData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0)];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView DataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assets count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = [self.assets objectAtIndex:indexPath.item];
    
    cell.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    return cell;
}

#pragma mark - CollectionView Delegate Methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Custom Methods

- (void)reloadData
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result !=nil){
            [temp insertObject:result atIndex:0];
        }
        else
        {
            [self setAssets:temp];
            [self.collectionView reloadData];
        }
        
    }];
}

@end
