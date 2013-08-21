//
//  NSDictionary+ALAsset.h
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/6/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset,GCAccountAssets;

@interface NSDictionary (ALAsset)

+ (NSDictionary *)infoFromALAsset:(ALAsset *)asset;
+ (NSDictionary *)infoFromGCAccountAsset:(GCAccountAssets *)asset;


@end
