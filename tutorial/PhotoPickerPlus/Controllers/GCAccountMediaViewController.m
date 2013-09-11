//
//  GCAccountMediaViewController.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/20/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "GCAccountMediaViewController.h"
#import "GCAlbumViewController.h"
#import "GCAssetsCollectionViewController.h"
#import "GCServiceAccount.h"

@interface GCAccountMediaViewController ()

@property (strong, nonatomic) NSArray *folders;
@property (strong, nonatomic) NSArray *files;

@end

@implementation GCAccountMediaViewController

@synthesize albumViewController,assetViewController;
@synthesize accountID,albumID,serviceName,isItDevice,isMultipleSelectionEnabled;
@synthesize successBlock, cancelBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getDataFromAccount];
    
    [self setupViewControllers];
    
//    if(self.folders == nil && self.files == nil)
//        [self firstSetup];
//    else
//        [self setup];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)getDataFromAccount
{
    [GCServiceAccount getDataForServiceWithName:self.serviceName forAccountWithID:self.accountID forAlbumWithID:self.albumID success:^(GCResponseStatus *responseStatus, NSArray *folders, NSArray *files) {
        self.folders = folders;
        self.files = files;
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot Fetch Account Data!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)setupViewControllers
{
    albumViewController = [GCAlbumViewController new];
    
    
    
    assetViewController = [GCAssetsCollectionViewController new];
    
    [assetViewController setAssets:self.files];
}

//- (void)firstSetup
//{
//    albumViewController = [GCAlbumViewController new];
//    [albumViewController setServiceName:self.serviceName];
//    [albumViewController setAccountID:self.accountID];
//    [albumViewController setIsItDevice:self.isItDevice];
//    [albumViewController setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
//    [albumViewController setSuccessBlock:self.successBlock];
//    [albumViewController setCancelBlock:self.cancelBlock];
//    
//    assetViewController = [GCAssetsCollectionViewController new];
//    [assetViewController setServiceName:self.serviceName];
//    [assetViewController setAccountID:self.accountID];
//    [assetViewController setAlbumID:self.albumID];
//    
//}
//
//- (void)setup
//{

}

@end
