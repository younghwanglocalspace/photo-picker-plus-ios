//
//  DeviceAlbumViewController.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/5/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "GCAlbumViewController.h"
#import "GCAssetsCollectionViewController.h"
#import "GCServiceAccount.h"
#import "GCAccountAlbum.h"

#import <MBProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface GCAlbumViewController ()

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) NSMutableArray *albums;
@property (strong, nonatomic) NSMutableArray *elementCount;
@property (strong, nonatomic) NSMutableArray *thumbnails;

@end

@implementation GCAlbumViewController

@synthesize albums, assetsLibrary,elementCount,thumbnails;

@synthesize successBlock, cancelBlock;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Albums";
    [self setCancelButton];
    
    if(self.isItDevice)
        [self getAlbumsFromDevice];
    else
        [self getAlbumsFromAccount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if([self isItDevice])
    {
        ALAssetsGroup *albumForCell = [albums objectAtIndex:indexPath.row];
        NSString *albumName = [albumForCell valueForProperty:ALAssetsGroupPropertyName];
        NSString *numOfAssets = [elementCount objectAtIndex:indexPath.row];
        
        cell.imageView.image = [UIImage imageWithCGImage:[albumForCell posterImage]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@  (%@)", albumName,numOfAssets];
    }
    else
    {
        GCAccountAlbum *albumForCell = [self.albums objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",albumForCell.name];
    }
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
   
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(100, 100)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    GCAssetsCollectionViewController *acVC = [[GCAssetsCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    [acVC setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
    [acVC setSuccessBlock:self.successBlock];
    [acVC setCancelBlock:self.cancelBlock];
    [acVC setIsItDevice:self.isItDevice];
    if(self.isItDevice)
        [acVC setAssetGroup:[self.albums objectAtIndex:indexPath.item]];
    else
    {
        GCAccountAlbum *accAlbum = [self.albums objectAtIndex:indexPath.item];
        NSLog(@"AlbumID:%@",accAlbum.id);
        
        [acVC setAccountID:self.accountID];
        [acVC setAlbumID:accAlbum.id];
    }
    
    [self.navigationController pushViewController:acVC animated:YES];
}

#pragma mark - Custom Methods

- (void)getAlbumsFromDevice
{
    elementCount = [[NSMutableArray array] init];
    
    if (!assetsLibrary) {
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    if (!albums) {
        albums = [[NSMutableArray alloc] init];
    } else {
        [albums removeAllObjects];
    }

    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock =  ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            //Add the album to the array
            [albums addObject: group];
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [elementCount addObject: [NSNumber numberWithInt:group.numberOfAssets]];
            
            //Add thumbnail to array
            [thumbnails addObject:[UIImage imageWithCGImage:[group posterImage]]];
            
        } else
            [self.tableView reloadData];
    };
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:^(NSError *error) {
        NSLog(@"Failure");
    }];
    
}

- (void)getAlbumsFromAccount
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [GCServiceAccount getAlbumsForAccountWithID:self.accountID withSuccess:^(GCResponseStatus *responseStatus, NSArray *accountAlbums) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
        self.albums = [[NSMutableArray alloc] initWithArray:accountAlbums];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot Fetch Account Albums!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)setCancelButton
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
}

- (void)cancel
{
    if (self.cancelBlock)
        [self cancelBlock]();
}

#pragma mark - Setters

- (void)setAccountID:(NSNumber *)accountID
{
    if(_accountID != accountID)
        _accountID = accountID;
}

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

@end
