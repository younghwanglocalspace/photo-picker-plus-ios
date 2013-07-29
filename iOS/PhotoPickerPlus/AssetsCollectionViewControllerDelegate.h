//
//  AssetsCollectionViewControllerDelegate.h
//  GCAPIv2TestApp
//
//  Created by ARANEA on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
@class AssetsCollectionViewController;

@protocol AssetsCollectionViewControllerDelegate <NSObject>

@required
- (void)assetCollectionViewController:(AssetsCollectionViewController *)assetCollectionViewController didFinishPickingAsset:(ALAsset *)asset;
- (void)assetCollectionViewController:(AssetsCollectionViewController *)assetCollectionViewController didFinishPickingAssets:(NSArray *)assets;
- (void)assetCollectionViewControllerDidCancel:(AssetsCollectionViewController *)assetCollectionViewController;

@end
