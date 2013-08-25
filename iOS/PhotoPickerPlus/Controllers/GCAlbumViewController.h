//
//  DeviceAlbumViewController.h
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/5/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCAlbumViewController : UITableViewController

@property (nonatomic) BOOL isMultipleSelectionEnabled;
@property (nonatomic) BOOL isItDevice;

@property (strong, nonatomic) NSNumber *accountID;
@property (strong, nonatomic) NSString *serviceName;

@property (strong, nonatomic) NSArray *albums;

@property (readwrite, copy) void (^successBlock)(id selectedItems);
@property (readwrite, copy) void (^cancelBlock)(void);

- (void)something;

@end
