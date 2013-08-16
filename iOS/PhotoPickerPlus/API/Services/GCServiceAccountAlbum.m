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

+ (void)getMediaForAccountWithID:(NSNumber *)accountID success:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
{
    [self getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:nil success:^(GCResponseStatus *responseStatus, NSArray *accountAssets) {
        success(responseStatus,accountAssets);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:(NSNumber *)accountAlbumID success:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
{
    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
    
    NSString *path = [NSString stringWithFormat:@"%@/albums/%@/media",accountID,accountAlbumID];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:@"GET" path:path parameters:nil];
    
    [apiClient request:request factoryClass:[GCAccountAssets class] success:^(GCResponse *response) {
        success(response.response, response.data);
    } failure:failure];
}

@end
