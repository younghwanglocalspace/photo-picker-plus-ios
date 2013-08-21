//
//  GCServiceAccountAlbum.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/1/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "GCServiceAccountAlbum.h"
#import "GCAccountAssets.h"
#import "PhotoPickerClient.h"
#import "GCResponse.h"

@implementation GCServiceAccountAlbum

+(void)getDataForServiceWithName:(NSString *)serviceName forAccountWithID:(NSNumber *)accountID forAlbumWithID:(NSNumber *)albumID success:(void (^)(GCResponseStatus *, NSArray *, NSArray *))success failure:(void (^)(NSError *))failure
{
    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
    NSString *path;
    if(albumID == nil)
        path = [NSString stringWithFormat:@"%@/%@/files",serviceName,accountID];
    else
        path = [NSString stringWithFormat:@"%@/%@/folders/%@/files",serviceName,accountID,albumID];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:@"GET" path:path parameters:nil];
    
    [apiClient request:request success:^(GCResponseStatus *responseStatus, NSArray *folders, NSArray *files) {
        success(responseStatus,folders,files);
    } failure:failure];
}

//+ (void)getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:(NSNumber *)accountAlbumID success:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
//{
//    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
//    
//    NSString *path = [NSString stringWithFormat:@"accounts/%@/albums/%@/media",accountID,accountAlbumID];
//    
//    NSMutableURLRequest *request = [apiClient requestWithMethod:@"GET" path:path parameters:nil];
//    
//    [apiClient request:request factoryClass:[GCAccountAssets class] success:^(GCResponse *response) {
//        success(response.response, response.data);
//    } failure:failure];
//}


@end
