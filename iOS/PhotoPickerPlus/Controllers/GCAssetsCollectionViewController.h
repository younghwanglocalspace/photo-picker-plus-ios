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

- (UIBarButtonItem *)cancelButton;
- (NSArray *)doneAndCancelButtons;

@end
