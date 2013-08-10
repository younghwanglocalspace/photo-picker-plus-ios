//
//  GCServiceAccountAlbum.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/1/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "GCServiceAccountAlbum.h"
#import "GCAccountAssets.h"
#import "GCClient.h"
#import "GCResponse.h"

@implementation GCServiceAccountAlbum

+ (void)getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:(NSNumber *)accountAlbumID success:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
{
    GCClient *apiClient = [GCClient sharedClient]; // ama ne e taa pateka!! https://accounts.getchute.com/v1/accounts/accountID/objects
    
    NSString *path = [NSString stringWithFormat:@"accounts/%@/objects/%@/media",accountID,accountAlbumID];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:kGCClientGET path:path parameters:nil];
    
    [apiClient request:request factoryClass:[GCAccountAssets class] success:^(GCResponse *response) {
        success(response.response, response.data);
    } failure:failure];
}

@end
