//
//  NSDictionary+ALAsset.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/6/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "NSDictionary+ALAsset.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GCAccountAssets.h"

@implementation NSDictionary (ALAsset)

+ (NSDictionary *)infoFromALAsset:(ALAsset *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    [mediaInfo setObject:[asset valueForProperty:ALAssetPropertyType] forKey:UIImagePickerControllerMediaType];
    [mediaInfo setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:UIImagePickerControllerOriginalImage];
    [mediaInfo setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:UIImagePickerControllerReferenceURL];

    return mediaInfo;
}

+ (NSDictionary *)infoFromGCAccountAsset:(GCAccountAssets *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    [mediaInfo setObject:@"ALAssetTypePhoto" forKey:UIImagePickerControllerMediaType];
    [mediaInfo setObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[asset large]]]] forKey:UIImagePickerControllerOriginalImage];
    [mediaInfo setObject:[NSURL URLWithString:[asset url]] forKey:UIImagePickerControllerReferenceURL];
    
    return mediaInfo;

}
@end
