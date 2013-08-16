//
//  AssetsCollectionViewController.m
//  GCAPIv2TestApp
//
//  Created by Chute Corporation on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "GCAssetsCollectionViewController.h"
#import "PhotoCell.h"
#import "GCAccountAssets.h"
#import "GCServiceAccountAlbum.h"
#import "NSDictionary+ALAsset.h"

#import <MBProgressHUD.h>
#import <AFNetworking.h>

@interface GCAssetsCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) UIBarButtonItem *doneButton;

@end

@implementation GCAssetsCollectionViewController

@synthesize doneButton;
@synthesize successBlock, cancelBlock;

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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Assets";
    if(self.isMultipleSelectionEnabled)
        [self setDoneAndCancelButtons];
    else
        [self setCancelButton];
    
    self.selectedAssets = [@[] mutableCopy];

    if(self.isItDevice)
        [self getLocalAssets];
    else
        [self getAccountAssets];
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"Cell"];
//    [self.collectionView setContentInset:(UIEdgeInsetsMake(5, 5, 5, 5))];
    [self.collectionView setContentMode:UIViewContentModeBottomLeft];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    [self.collectionView setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0)];
    
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

-(PhotoCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(self.isItDevice)
    {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
    }
    else
    {
        GCAccountAssets *asset = [self.assets objectAtIndex:indexPath.row];
       AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[asset thumb]]] success:^(UIImage *image) {
            [cell.imageView setImage:image];
       }];
        [operation start];
    }
    
    if (cell.selected)
        cell.backgroundColor = [UIColor blueColor]; // highlight selection
    else
        cell.backgroundColor = [UIColor whiteColor]; // Default color

    return cell;
}

#pragma mark - CollectionView Delegate Methods

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isItDevice])
    {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        [self.selectedAssets addObject:asset];
    }
    else
    {
        GCAccountAssets *asset = [self.assets objectAtIndex:indexPath.row];
        [self.selectedAssets addObject:asset];
    }
    
    if(self.isMultipleSelectionEnabled)
    {
        [self.collectionView setAllowsMultipleSelection:YES];
        
        PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        
        if([self.selectedAssets count] > 0)
            [self.doneButton setEnabled:YES];
    }
    else
    {
        [self done];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.isMultipleSelectionEnabled)
    {
        PhotoCell *cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        
        if([self isItDevice])
        {
            ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
            [self.selectedAssets removeObject:asset];
        }
        else
        {
            GCAccountAssets *asset = [self.assets objectAtIndex:indexPath.row];
            [self.selectedAssets removeObject:asset];
        }
        
        if([self.selectedAssets count] == 0)
            [self.doneButton setEnabled:NO];
    }
}

#pragma mark - Custom Methods

- (void)getLocalAssets
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

- (void)getAccountAssets
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GCServiceAccountAlbum getMediaForAccountWithID:self.accountID forAccountAlbumWithID:self.albumID success:^(GCResponseStatus *responseStatus, NSArray *accountAssets) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        self.assets = [[NSMutableArray alloc] initWithArray:accountAssets];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot Fetch Account Assets!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)setCancelButton
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setRightBarButtonItem:cancelButton];

    [self.navigationItem setRightBarButtonItem:cancelButton];
}

- (void)setDoneAndCancelButtons
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [doneButton setEnabled:NO];
    
    NSArray *navBarItemsToBeAdd = [NSArray arrayWithObjects:doneButton,cancelButton,nil];

    [self.navigationItem setRightBarButtonItems:navBarItemsToBeAdd];

}

#pragma mark - Instance Methods

- (void)done
{
    if (self.successBlock) {
        if ([self isMultipleSelectionEnabled]) {

            NSMutableArray *info = [NSMutableArray array];
            if(self.isItDevice){
                for (ALAsset *asset in self.selectedAssets) {
                    [info addObject:([NSDictionary infoFromALAsset:asset])];
                }
            }
            else
            {
                for(GCAccountAssets *asset in self.selectedAssets){
                    [info addObject:([NSDictionary infoFromGCAccountAsset:asset])];
                }
            }
            [self successBlock](info);

        }
        else {
            if(self.isItDevice)
                [self successBlock]([NSDictionary infoFromALAsset:[self.selectedAssets objectAtIndex:0]]);
            else
                [self successBlock]([NSDictionary infoFromGCAccountAsset:[self.selectedAssets objectAtIndex:0]]);
        }
    }
}

- (void)cancel
{
    if (self.cancelBlock)
        [self cancelBlock]();
}

#pragma mark - Setters

- (void)setIsMultipleSelectionEnabled:(BOOL)isMultipleSelectionEnabled
{
    if(_isMultipleSelectionEnabled != isMultipleSelectionEnabled)
        _isMultipleSelectionEnabled = isMultipleSelectionEnabled;
}

- (void)setIsItDevice:(BOOL)isItDevice
{
    if(_isItDevice != isItDevice)
        _isItDevice = isItDevice;
}

- (void)setAccountID:(NSNumber *)accountID
{
    if(_accountID != accountID)
        _accountID = accountID;
}

- (void)setAlbumID:(NSNumber *)albumID
{
    if(_albumID != albumID)
        _albumID = albumID;
}

@end
