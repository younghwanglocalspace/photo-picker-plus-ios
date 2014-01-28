//
//  NSDictionary+GCAccountAsset.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/30/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "NSDictionary+GCAccountAsset.h"
#import "GCAccountAssets.h"
#import "GCAsset.h"
#import "GCPhotoPickerConfiguration.h"
#import "GetChute.h"

#import <MobileCoreServices/MobileCoreServices.h>

@implementation NSDictionary (GCAccountAsset)

+ (NSDictionary *)dictionaryFromGCAccountAssets:(GCAccountAssets *)asset
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:asset.id forKey:@"id"];
    [dictionary setValue:asset.caption forKey:@"caption"];
    [dictionary setValue:asset.thumbnail forKey:@"thumbnail"];
    if (asset.video_url !=nil)
        [dictionary setValue:asset.video_url forKey:@"image_url"];
    else
        [dictionary setValue:asset.image_url forKey:@"image_url"];

    [dictionary setValue:asset.dimensions forKey:@"dimensions"];
    
    return dictionary;
}

+ (NSDictionary *)infoFromGCAccountAsset:(GCAccountAssets *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    
    UIImage *image = [self loadImageWithURL:[NSURL URLWithString:[asset image_url]]];
    
    if(asset.video_url !=nil) {
        [mediaInfo setObject:(NSString *)kUTTypeVideo forKey:UIImagePickerControllerMediaType];
        [mediaInfo setObject:[NSURL URLWithString:[asset video_url]] forKey:UIImagePickerControllerReferenceURL];
    }
    else {
        [mediaInfo setObject:(NSString *)kUTTypeImage forKey:UIImagePickerControllerMediaType];
        [mediaInfo setObject:[NSURL URLWithString:[asset image_url]] forKey:UIImagePickerControllerReferenceURL];
    }
    
    if(image)
        [mediaInfo setObject:image forKey:UIImagePickerControllerOriginalImage];
    
    return mediaInfo;
    
}

+ (NSDictionary *)infoFromGCAsset:(GCAsset *)asset
{
    NSMutableDictionary *mediaInfo = [NSMutableDictionary dictionary];
    UIImage *image = [self loadImageWithURL:[NSURL URLWithString:[asset thumbnail]]];
    
    [mediaInfo setObject:(NSString *)kUTTypeImage forKey:UIImagePickerControllerMediaType];
    [mediaInfo setObject:[NSURL URLWithString:[asset url]] forKey:UIImagePickerControllerReferenceURL];
    if (image) {
        [mediaInfo setObject:image forKey:UIImagePickerControllerOriginalImage];
    }
    
    return mediaInfo;
}

+ (UIImage *)loadImageWithURL:(NSURL *)url
{
    if ([[GCPhotoPickerConfiguration configuration] loadImagesFromWeb] == NO){
        return nil;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:20.0];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (data && !error) {
        return [UIImage imageWithData:data];
    }
    else {
        GCLogWarning(@"Error loading image from web. %@", [error localizedDescription]);
        return nil;
    }
}

@end
