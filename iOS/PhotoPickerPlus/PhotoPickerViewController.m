//
//  PhotoPickerViewController.m
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/24/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "PhotoPickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoPickerCell.h"
#import "AssetsCollectionViewController.h"

@interface PhotoPickerViewController ()

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) NSMutableArray *assetsGroups;
@end

@implementation PhotoPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        /* Check sources */
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.assetsLibrary = assetsLibrary;
        
        self.assetsGroups = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCancelButton];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.assetsLibrary = assetsLibrary;
    
    self.assetsGroups = [NSMutableArray array];
    
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
                if (assetsGroup.numberOfAssets > 0) {
                    [self.assetsGroups addObject:assetsGroup];
                    [self.tableView reloadData];
                }
    };
    
    void (^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    

    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
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
    return [self.assetsGroups count];
}

- (PhotoPickerCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";
    PhotoPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[PhotoPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageWithCGImage:assetsGroup.posterImage];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",[assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    cell.countLabel.text = [NSString stringWithFormat:@"(%d)", assetsGroup.numberOfAssets];
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showPhotos"])
    {
        AssetsCollectionViewController *acVC;
        acVC=segue.destinationViewController;
        
        NSIndexPath *indexPath = [[self.tableView indexPathsForSelectedRows] objectAtIndex:0];
        
        ALAssetsGroup *assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    
        [acVC setAssetGroup:assetsGroup];
        acVC.title = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma mark - Custom Methods

- (void)setCancelButton
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    [self.navigationItem setRightBarButtonItem:cancelButton];
}

#pragma mark - Instance Methods

- (NSDictionary *)mediaInfoFromAsset:(ALAsset *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    [mediaInfo setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
    [mediaInfo setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerOriginalImage"];
    [mediaInfo setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
    
    return mediaInfo;
}

- (void)cancel
{
    if([self.delegate respondsToSelector:@selector(photoPickerViewControllerDidCancel:)])
    {
        [self.delegate photoPickerViewControllerDidCancel:self];
    }
}

//#pragma mark - AssetsCollectionViewControllerDelegate 
//
//-(void)assetCollectionViewController:(AssetsCollectionViewController *)assetCollectionViewController didFinishPickingAsset:(id)asset
//{
//    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
//        [self.delegate photoPickerViewController:self didFinishPickingMediaWithInfo:[self mediaInfoFromAsset:asset]];
//    }
//
//}
//
//-(void)assetCollectionViewController:(AssetsCollectionViewController *)assetCollectionViewController didFinishPickingAssets:(id)assets
//{
//    if ([self.delegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
//        NSMutableArray *info = [NSMutableArray array];
//        
//        for (ALAsset *asset in assets) {
//            [info addObject:[self mediaInfoFromAsset:asset]];
//        }
//        
//        [self.delegate photoPickerViewController:self didFinishPickingMediaWithInfo:info];
//    }
//}
//
//-(void)assetCollectionViewControllerDidCancel:(AssetsCollectionViewController *)assetCollectionViewController
//{
//    if([self.delegate respondsToSelector:@selector(photoPickerViewControllerDidCancel:)])
//    {
//        [self.delegate photoPickerViewControllerDidCancel:self];
//    }
//}
//
//



@end
