//
//  GCServiceAccount.m
//  Chute-SDK
//
//  Created by ARANEA on 7/30/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "GCServiceAccount.h"
#import "GCClient.h"
#import "GCResponseStatus.h"
#import "GCAccount.h"
#import "GCResponse.h"
#import "GCAccountAlbum.h"

@implementation GCServiceAccount

+ (void)createAccountWithSuccess:(void (^)(GCResponseStatus *, GCAccount *))success failure:(void (^)(NSError *))failure
{
    GCClient *apiClient = [GCClient sharedClient];
    
    NSString *path = [NSString stringWithFormat:@"me/accounts"];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:kGCClientGET path:path parameters:nil];

    [apiClient request:request factoryClass:[GCAccount class] success:^(GCResponse *response) {
        success(response.response, response.data);
    } failure:failure];
}

+ (void)getAlbumsForAccountWithID:(NSNumber *)accountID withSuccess:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
{
    GCClient *apiClient = [GCClient sharedClient]; // ama ne e taa pateka!! https://accounts.getchute.com/v1/accounts/accountID/objects
    
    NSString *path = [NSString stringWithFormat:@"accounts/%@/objects",accountID];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:kGCClientGET path:path parameters:nil];
    
    [apiClient request:request factoryClass:[GCAccountAlbum class] success:^(GCResponse *response) {
        success(response.response, response.data);
    } failure:failure];
}

@end
