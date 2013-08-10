//
//  PhotoPickerViewController.h
//  GCAPIv2TestApp
//
//  Created by Chute Corporation on 7/24/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPickerViewController.h"

@class GCOAuth2Client;

@interface GCPhotoPickerViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id<PhotoPickerViewControllerDelegate, UINavigationControllerDelegate>delegate;

@property (strong, nonatomic) GCOAuth2Client *oauth2Client;

@property (assign, nonatomic) BOOL isMultipleSelectionEnabled;

@end
