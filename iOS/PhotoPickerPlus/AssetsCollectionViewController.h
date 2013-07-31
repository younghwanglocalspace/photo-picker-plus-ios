//
//  AssetsCollectionViewController.h
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetsCollectionViewControllerDelegate.h"
#import "PhotoPickerViewController.h"

@interface AssetsCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id<AssetsCollectionViewControllerDelegate>delegate;
@property (nonatomic, strong) ALAssetsGroup *assetGroup;

@end
