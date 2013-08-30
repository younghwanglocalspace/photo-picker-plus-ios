//
//  AssetsCollectionViewController.h
//  GCAPIv2TestApp
//
//  Created by Chute Corporation on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GCPhotoPickerViewController.h"


@interface GCAssetsCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) ALAssetsGroup *assetGroup;

@property (nonatomic, strong) NSArray *assets;

@property (strong, nonatomic) NSString *serviceName;
@property (strong, nonatomic) NSNumber *accountID;
@property (strong, nonatomic) NSNumber *albumID;

@property (nonatomic) BOOL isMultipleSelectionEnabled;
@property (nonatomic) BOOL isItDevice;

@property (readwrite, copy) void (^successBlock)(id selectedItems);
@property (readwrite, copy) void (^cancelBlock)(void);

///----------------------------------
/// @name Setting NavigationBar items
///----------------------------------

/**
 Sets cancel button in the right corner of NavigationBar.
 
 @return UIBarButtonItem
*/
- (UIBarButtonItem *)cancelButton;

/**
 Sets cancel and done buttons in right corner of NavigationBar.
 
 @return NSArray of UIBarButtonItem objects.
 */
- (NSArray *)doneAndCancelButtons;

///------------------------------------
/// @name Setting CollectionView layout
///------------------------------------

/**
 Instance method for setting collectionView layout when initializing new CollectionViewController.
 
 @return UICollectionViewFlowLayout that is used for initializing new CollectionViewController.
 */
+ (UICollectionViewFlowLayout *)setupLayout;
@end
