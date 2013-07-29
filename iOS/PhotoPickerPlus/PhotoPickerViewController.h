//
//  PhotoPickerViewController.h
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/24/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AssetsCollectionViewControllerDelegate.h"


@class PhotoPickerViewController;

@protocol PhotoPickerViewControllerDelegate <NSObject>

@required
- (void) photoPickerViewController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(id)info;
- (void) photoPickerViewControllerDidCancel:(PhotoPickerViewController *)picker;

@end

@interface PhotoPickerViewController : UITableViewController <AssetsCollectionViewControllerDelegate>

@property (weak , nonatomic) id<PhotoPickerViewControllerDelegate>delegate;


@end
