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
<<<<<<< HEAD
=======

>>>>>>> Layout for parent view controller.
    self.albumViewController = [GCAlbumViewController new];
    [self addChildViewController:self.albumViewController];
    [self.albumViewController didMoveToParentViewController:self];
    
<<<<<<< HEAD
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
=======
    self.assetViewController = [[GCAssetsCollectionViewController alloc] initWithCollectionViewLayout:[GCAssetsCollectionViewController setupLayout]];
    
    
    [self addChildViewController:self.assetViewController];
    [self.assetViewController didMoveToParentViewController:self];

    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    NSLog(@"DidLoad:scrollViewFrame:%@",NSStringFromCGRect(self.scrollView.bounds));
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.scrollView];
    
    [self.albumViewController.tableView setFrame:CGRectZero];
    [self.assetViewController.collectionView setFrame:CGRectZero];
    
    [self.scrollView addSubview:self.albumViewController.tableView];
    [self.scrollView addSubview:self.assetViewController.collectionView];
>>>>>>> Layout for parent view controller.

    [self getDataFromAccount];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD
=======
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setScrollViewContentSize];
}

>>>>>>> Layout for parent view controller.
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
<<<<<<< HEAD
    // need to set frames depending on view controllers.
    
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    [self.scrollView setContentSize:CGSizeZero];
    
    if(self.folders != nil)
    {
        
=======
    
    if(self.folders != nil)
    {
               
>>>>>>> Layout for parent view controller.
        [self.albumViewController setServiceName:self.serviceName];
        [self.albumViewController setAccountID:self.accountID];
        [self.albumViewController setAlbums:self.folders];
        [self.albumViewController setIsItDevice:self.isItDevice];
        [self.albumViewController setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        [self.albumViewController setSuccessBlock:self.successBlock];
        [self.albumViewController setCancelBlock:self.cancelBlock];
        
        [self.albumViewController.tableView reloadData];
        
<<<<<<< HEAD
        CGRect tableViewFrame = self.albumViewController.tableView.bounds;
        tableViewFrame.size.height = self.albumViewController.tableView.contentSize.height;
        tableViewFrame.origin.y = self.scrollView.contentSize.height;
        self.albumViewController.tableView.frame = tableViewFrame;
        [self.albumViewController.tableView setScrollEnabled:NO];
        
        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + tableViewFrame.size.height)];
        [self.scrollView addSubview:self.albumViewController.tableView];
    }
    else {
=======
    }
    else {
        [self.albumViewController.tableView removeFromSuperview];
>>>>>>> Layout for parent view controller.
        [self.albumViewController removeFromParentViewController];
        self.albumViewController = nil;
    }
    
    
    if(self.files != nil)
<<<<<<< HEAD
    {
        
=======
    {        
>>>>>>> Layout for parent view controller.
        [self.assetViewController setAssets:self.files];
        [self.assetViewController setSuccessBlock:[self successBlock]];
        [self.assetViewController setCancelBlock:[self cancelBlock]];
        [self.assetViewController setIsItDevice:self.isItDevice];
        [self.assetViewController setIsMultipleSelectionEnabled:self.isMultipleSelectionEnabled];
        
        [self.assetViewController.collectionView reloadData];
        
<<<<<<< HEAD
        CGRect collectionViewFrame = self.assetViewController.collectionView.bounds;
//        collectionViewFrame.size.height = self.assetViewController.collectionView.contentSize.height;
        collectionViewFrame.size.height = self.assetViewController.collectionView.collectionViewLayout.collectionViewContentSize.height;
        collectionViewFrame.origin.y = self.scrollView.contentSize.height;
        self.assetViewController.collectionView.frame = collectionViewFrame;
        [self.assetViewController.collectionView setScrollEnabled:NO];
        
        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + collectionViewFrame.size.height)];
        [self.scrollView addSubview:self.assetViewController.collectionView];
        
=======

>>>>>>> Layout for parent view controller.
        if ([self isMultipleSelectionEnabled]) {
            [self.navigationItem setRightBarButtonItems:[self.assetViewController doneAndCancelButtons]];
        }
        else {
            [self.navigationItem setRightBarButtonItem:[self.assetViewController cancelButton]];
        }
        
    }
    else {
<<<<<<< HEAD
=======
        [self.assetViewController.collectionView removeFromSuperview];
>>>>>>> Layout for parent view controller.
        [self.assetViewController removeFromParentViewController];
        self.assetViewController = nil;
    }
    
<<<<<<< HEAD
=======
    [self setScrollViewContentSize];
    
}

- (void)setScrollViewContentSize
{
    CGFloat scrollViewWidth = self.view.bounds.size.width;
    self.scrollView.frame = self.view.bounds;

    [self.scrollView setContentSize:CGSizeZero];
    
    if (self.albumViewController != nil)
        self.albumViewController.tableView.bounds = self.scrollView.bounds;
    if (self.assetViewController != nil)
        self.assetViewController.collectionView.bounds = self.scrollView.bounds;


    if(self.folders !=nil)
    {
        
        CGRect tableViewFrame = self.albumViewController.tableView.bounds;
        tableViewFrame.size.height = self.albumViewController.tableView.contentSize.height;
        tableViewFrame.size.width = scrollViewWidth;
        tableViewFrame.origin.y = self.scrollView.contentSize.height;
        self.albumViewController.tableView.frame = tableViewFrame;
        [self.albumViewController.tableView setScrollEnabled:NO];

        [self.albumViewController.tableView reloadData];

        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + tableViewFrame.size.height)];

    }
    if (self.files != nil) {
        
        CGRect collectionViewFrame = self.assetViewController.collectionView.bounds;
        collectionViewFrame.size.height = self.assetViewController.collectionView.collectionViewLayout.collectionViewContentSize.height;
        collectionViewFrame.size.width = scrollViewWidth;
        collectionViewFrame.origin.y = self.scrollView.contentSize.height;
        self.assetViewController.collectionView.frame = collectionViewFrame;
        [self.assetViewController.collectionView setScrollEnabled:NO];
                
        [self.scrollView setContentSize:CGSizeMake(scrollViewWidth, self.scrollView.contentSize.height + collectionViewFrame.size.height)];
        
    }
>>>>>>> Layout for parent view controller.
}

@end
