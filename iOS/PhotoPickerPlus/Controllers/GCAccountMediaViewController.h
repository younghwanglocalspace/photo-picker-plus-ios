//
//  GCAccountMediaViewController.h
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/20/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCAlbumViewController, GCAssetsCollectionViewController;

@interface GCAccountMediaViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) GCAlbumViewController             *albumViewController;
@property (strong, nonatomic) GCAssetsCollectionViewController  *assetViewController;

@property (assign, nonatomic) BOOL                              isMultipleSelectionEnabled;
@property (assign, nonatomic) BOOL                              isItDevice;

@property (strong, nonatomic) NSNumber                          *accountID;
@property (strong, nonatomic) NSNumber                          *albumID;
@property (strong, nonatomic) NSString                          *serviceName;

@property (readwrite, copy) void (^successBlock)(id selectedItems);
@property (readwrite, copy) void (^cancelBlock)(void);

@end
