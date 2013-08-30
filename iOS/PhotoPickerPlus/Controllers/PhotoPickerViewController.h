//
//  PhotoPickerViewController.h
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 8/10/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoPickerViewController;

/**
 The `PhotoPickerViewControllerDelegate` defines the methods that are used when picking an asset. They actually return selected assets or cancel.
*/
@protocol PhotoPickerViewControllerDelegate <NSObject>

@optional
/**
 Called when the user had finished picking and had selected one asset.
 */
- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
/**
 Called when the user had finished picking and had selected multiple assets, which are returned in an array.
 */
- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info;
/**
 Called when the user canceled the picking.
 */
- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker;
@end

@interface PhotoPickerViewController : UINavigationController

@property (weak, nonatomic) id<PhotoPickerViewControllerDelegate, UINavigationControllerDelegate>delegate;
//@property (strong, nonatomic) GCOAuth2Client *oauth2Client;
@property (assign, nonatomic) BOOL isMultipleSelectionEnabled;

@end
