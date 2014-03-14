//
//  GCAlbumsCollectionViewController.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 3/14/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "GCAlbumsCollectionViewController.h"
#import "GCAssetsCollectionViewController.h"
#import "GCAccountMediaViewController.h"
#import "GCAccountAlbum.h"

#import "MBProgressHUD.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GCPhotoPickerConfiguration.h"
#import "GetChute.h"



@interface GCAlbumsCollectionViewController ()

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) NSMutableArray *tempAlbums;
@property (strong, nonatomic) NSMutableArray *elementCount;

@end

@implementation GCAlbumsCollectionViewController

@synthesize albums, assetsLibrary,elementCount,tempAlbums;

@synthesize successBlock, cancelBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (UICollectionViewFlowLayout *)setupLayout
{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(73.75, 73.75)];
    [aFlowLayout setMinimumInteritemSpacing:0.0f];
    [aFlowLayout setMinimumLineSpacing:5];
    [aFlowLayout setSectionInset:(UIEdgeInsetsMake(5, 5, 5, 5))];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    return aFlowLayout;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Albums";
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];

    if(self.isItDevice) {
        [self getAlbumsFromDevice];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Data Source and Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.albums count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
#error Need to implement custom cell!
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isItDevice)
    {
        GCAssetsCollectionViewController *acVC = [[GCAssetsCollectionViewController alloc] initWithCollectionViewLayout:[GCAssetsCollectionViewController setupLayout]];
        [acVC setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        [acVC setSuccessBlock:self.successBlock];
        [acVC setCancelBlock:self.cancelBlock];
        [acVC setIsItDevice:self.isItDevice];
        [acVC setAssetGroup:[self.albums objectAtIndex:indexPath.item]];
        
        [self.navigationController pushViewController:acVC animated:YES];
    }
    else
    {
        GCAccountAlbum *accAlbum = [self.albums objectAtIndex:indexPath.item];
        GCAccountMediaViewController *amVC = [GCAccountMediaViewController new];
        [amVC setAccountID:self.accountID];
        [amVC setAlbumID:accAlbum.id];
        [amVC setServiceName:self.serviceName];
        [amVC setIsItDevice:self.isItDevice];
        [amVC setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        [amVC setSuccessBlock:self.successBlock];
        [amVC setCancelBlock:self.cancelBlock];
        
        [self.parentViewController.navigationController pushViewController:amVC animated:YES];
    }

}

#pragma mark - Custom Methods

- (void)getAlbumsFromDevice
{
    elementCount = [[NSMutableArray array] init];
    
    if (!assetsLibrary) {
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (!albums) {
        tempAlbums = [[NSMutableArray alloc] init];
    } else {
        [tempAlbums removeAllObjects];
    }
    
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock =  ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            //Add the album to the array
            [tempAlbums addObject: group];
            
            if ([[[GCPhotoPickerConfiguration configuration] mediaTypesAvailable] isEqualToString:@"Photos"])
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            if ([[[GCPhotoPickerConfiguration configuration] mediaTypesAvailable] isEqualToString:@"Videos"])
                [group setAssetsFilter:[ALAssetsFilter allVideos]];
            if ([[[GCPhotoPickerConfiguration configuration] mediaTypesAvailable] isEqualToString:@"All Media"])
                [group setAssetsFilter:[ALAssetsFilter allAssets]];
            [elementCount addObject: [NSNumber numberWithInt:group.numberOfAssets]];
            
        } else
        {
            [self setAlbums:tempAlbums];
            [self.collectionView reloadData];
        }
        
    };
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:^(NSError *error) {
        GCLogError([error localizedDescription]);
    }];
    
}

- (UIBarButtonItem *)setCancelButton
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    return cancelButton;
}

- (void)cancel
{
    if (self.cancelBlock)
        [self cancelBlock]();
}

@end
