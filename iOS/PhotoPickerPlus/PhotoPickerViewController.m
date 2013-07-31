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
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setScrollEnabled:NO];
          }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCancelButton];
    [self.tableView registerClass:[PhotoPickerCell class] forCellReuseIdentifier:@"GroupCell"];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Local";
    else
        return @"Services";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 3;
    else
        return [ADD_SERVICES_ARRAY_NAMES count];
}

- (PhotoPickerCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";

//    PhotoPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PhotoPickerCell *cell = [[PhotoPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    if (cell == nil)
//        cell = [[PhotoPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    if(indexPath.section == 0){
        if(indexPath.row == 0)
        {
            cell.titleLabel.text = @"Take Photo";
            [cell.imageView setImage:[UIImage imageNamed:@"camera.png"]];
        }
        else if (indexPath.row == 1)
        {
            cell.titleLabel.text = @"Choose Photo";
            [cell.imageView setImage:[UIImage imageNamed:@"defaultThumb.png"]];
        }
        else if (indexPath.row == 2)
        {
            cell.titleLabel.text = @"Latest Photo";
            [cell.imageView setImage:[UIImage imageNamed:@"defaultThumb.png"]];
        }
    }
    else if(indexPath.section == 1)
    {
        NSString *imageName = [[NSString stringWithFormat:@"%@.png",[ADD_SERVICES_ARRAY_NAMES objectAtIndex:indexPath.row]] lowercaseString];
        UIImage *temp = [UIImage imageNamed:imageName];
        [cell.imageView setImage:temp];
        [cell.titleLabel setText:[ADD_SERVICES_ARRAY_NAMES objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if(indexPath.row == 0)
        {

            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:picker animated:YES completion:nil];
        }
        else if (indexPath.row == 1)
        {
           [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [self presentViewController:picker animated:YES completion:nil];
            
        }
        else if (indexPath.row == 2)
        {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            // Enumerate all the photos and videos group by using ALAssetsGroupAll.
            [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                // Within the group enumeration block, filter to enumerate just photos.
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                
                // Chooses the photo at the last index
                [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:([group numberOfAssets] - 1)] options:0 usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
                    
                    // The end of the enumeration is signaled by asset == nil.
                    if (alAsset) {
                        ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                        UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
                        NSLog(@"%@",[latestPhoto description]);
                        // Do something interesting with the AV asset.
                    }
                }];
            } failureBlock: ^(NSError *error) {
                // Typically you should handle an error more gracefully than this.
                NSLog(@"No groups");
            }];
        }
    }
    else if(indexPath.section == 1)
    {
        NSString *type = [ADD_SERVICES_ARRAY_LINKS objectAtIndex:indexPath.row];

        // Implement check if it's logged in. If yes show TableViewControllerWithAlbums, if not show WebView
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

#pragma mark - UIImagePicker Delegate Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];

    if(self.delegate && [self.delegate respondsToSelector:@selector(photoPickerViewControllerDidCancel:)])
        [self.delegate photoPickerViewControllerDidCancel:self];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.delegate && [self.delegate respondsToSelector:@selector(photoPickerViewController:didFinishPickingMediaWithInfo:)])
            [self.delegate photoPickerViewController:self didFinishPickingMediaWithInfo:info];
    }];
    
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
