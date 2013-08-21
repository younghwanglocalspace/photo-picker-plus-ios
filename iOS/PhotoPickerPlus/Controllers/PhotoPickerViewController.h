//
//  PhotoPickerViewController.h
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 8/10/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoPickerViewController;

@protocol PhotoPickerViewControllerDelegate <NSObject>

@optional
- (void)photoPickerViewController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)photoPickerViewController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info;
- (void)photoPickerViewControllerDidCancel:(PhotoPickerViewController *)picker;
@end

@interface PhotoPickerViewController : UINavigationController

@property (weak, nonatomic) id<PhotoPickerViewControllerDelegate, UINavigationControllerDelegate>delegate;
//@property (strong, nonatomic) GCOAuth2Client *oauth2Client;
@property (assign, nonatomic) BOOL isMultipleSelectionEnabled;

@end
