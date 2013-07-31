//
//  PhotoPickerViewController.h
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/24/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AssetsCollectionViewControllerDelegate.h"

#define ADD_SERVICES_ARRAY_NAMES [NSArray arrayWithObjects:@"Facebook", @"Instagram", @"Flickr", @"Picasa", nil]
#define ADD_SERVICES_ARRAY_LINKS [NSArray arrayWithObjects:@"facebook", @"instagram", @"flickr", @"google", nil]


@class PhotoPickerViewController;

@protocol PhotoPickerViewControllerDelegate <NSObject>

@required
- (void) photoPickerViewController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(id)info;
- (void) photoPickerViewControllerDidCancel:(PhotoPickerViewController *)picker;

@end

@interface PhotoPickerViewController : UITableViewController <UIImagePickerControllerDelegate>

@property (nonatomic, weak) id<PhotoPickerViewControllerDelegate>delegate;



@end
