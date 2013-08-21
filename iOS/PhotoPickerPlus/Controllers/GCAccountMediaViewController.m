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

#import <MBProgressHUD/MBProgressHUD.h>

@interface GCAccountMediaViewController ()

@property (strong, nonatomic) NSArray *folders;
@property (strong, nonatomic) NSArray *files;

@end

@implementation GCAccountMediaViewController

@synthesize scrollView;
@synthesize albumViewController,assetViewController;
@synthesize accountID, albumID, serviceName, isItDevice, isMultipleSelectionEnabled;
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
    self.albumViewController = [GCAlbumViewController new];
    [self addChildViewController:self.albumViewController];
    [self.albumViewController didMoveToParentViewController:self];
    
#warning MOVE THIS AS GCAlbumViewController FACTORY METHOD
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(73.75, 73.75)];
    [aFlowLayout setMinimumInteritemSpacing:0.0f];
    [aFlowLayout setMinimumLineSpacing:5];
    [aFlowLayout setSectionInset:(UIEdgeInsetsMake(5, 5, 5, 5))];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.assetViewController = [[GCAssetsCollectionViewController alloc] initWithCollectionViewLayout:aFlowLayout];
    [self addChildViewController:self.assetViewController];
    [self.assetViewController didMoveToParentViewController:self];
    
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    [self.scrollView setBackgroundColor:[UIColor purpleColor]];

    [self getDataFromAccount];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)getDataFromAccount
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [GCServiceAccount getDataForServiceWithName:self.serviceName forAccountWithID:self.accountID forAlbumWithID:self.albumID success:^(GCResponseStatus *responseStatus, NSArray *folders, NSArray *files) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
        
        self.folders = folders;
        self.files = files;
        
        [self setupViewControllers];

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:NO];
        [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Cannot Fetch Account Data!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)setupViewControllers
{
    // need to set frames depending on view controllers.
    
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    [self.scrollView setContentSize:CGSizeZero];
    
    if(self.folders != nil)
    {
        
        [self.albumViewController setServiceName:self.serviceName];
        [self.albumViewController setAccountID:self.accountID];
        [self.albumViewController setAlbums:self.folders];
        [self.albumViewController setIsItDevice:self.isItDevice];
        [self.albumViewController setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        [self.albumViewController setSuccessBlock:self.successBlock];
        [self.albumViewController setCancelBlock:self.cancelBlock];
        
        [self.albumViewController.tableView reloadData];
        
        CGRect tableViewFrame = self.albumViewController.tableView.bounds;
        tableViewFrame.size.height = self.albumViewController.tableView.contentSize.height;
        tableViewFrame.origin.y = self.scrollView.contentSize.height;
        self.albumViewController.tableView.frame = tableViewFrame;
        [self.albumViewController.tableView setScrollEnabled:NO];
        
        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + tableViewFrame.size.height)];
        [self.scrollView addSubview:self.albumViewController.tableView];
    }
    else {
        [self.albumViewController removeFromParentViewController];
        self.albumViewController = nil;
    }
    
    
    if(self.files != nil)
    {
        
        [self.assetViewController setAssets:self.files];
        [self.assetViewController setSuccessBlock:[self successBlock]];
        [self.assetViewController setCancelBlock:[self cancelBlock]];
        [self.assetViewController setIsItDevice:self.isItDevice];
        [self.assetViewController setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        
        [self.assetViewController.collectionView reloadData];
        
        CGRect collectionViewFrame = self.assetViewController.collectionView.bounds;
//        collectionViewFrame.size.height = self.assetViewController.collectionView.contentSize.height;
        collectionViewFrame.size.height = self.assetViewController.collectionView.collectionViewLayout.collectionViewContentSize.height;
        collectionViewFrame.origin.y = self.scrollView.contentSize.height;
        self.assetViewController.collectionView.frame = collectionViewFrame;
        [self.assetViewController.collectionView setScrollEnabled:NO];
        
        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + collectionViewFrame.size.height)];
        [self.scrollView addSubview:self.assetViewController.collectionView];
        
        if ([self isMultipleSelectionEnabled]) {
            [self.navigationItem setRightBarButtonItems:[self.assetViewController doneAndCancelButtons]];
        }
        else {
            [self.navigationItem setRightBarButtonItem:[self.assetViewController cancelButton]];
        }
        
    }
    else {
        [self.assetViewController removeFromParentViewController];
        self.assetViewController = nil;
    }
    
}

@end
