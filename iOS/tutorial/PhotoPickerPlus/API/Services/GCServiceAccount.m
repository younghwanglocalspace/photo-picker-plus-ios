//
//  GCServiceAccount.m
//  Chute-SDK
//
//  Created by ARANEA on 7/30/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "GCServiceAccount.h"
#import "GCAccount.h"
#import "GCAccountAlbum.h"
#import "PhotoPickerClient.h"

#import <Chute-SDK/GCResponse.h>
#import <Chute-SDK/GCClient.h>
#import <Chute-SDK/GCResponseStatus.h>


@implementation GCServiceAccount

+ (void)getProfileInfoWithSuccess:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
{
    GCClient *apiClient = [GCClient sharedClient];
    
    NSString *path = [NSString stringWithFormat:@"me/accounts"];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:kGCClientGET path:path parameters:nil];

    [apiClient request:request factoryClass:[GCAccount class] success:^(GCResponse *response) {
        success(response.response, response.data);
    } failure:failure];
}


//+ (void)getDataForServiceWithName:(NSString *)serviceName accountWithID:(NSNumber *)accountID withSuccess:(void (^)(GCResponseStatus *, NSArray *folders, NSArray *files))success failure:(void (^)(NSError *))failure
//{
//    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
//    
//    NSString *path = [NSString stringWithFormat:@"%@/%@/files",serviceName,accountID];
//    
//    NSMutableURLRequest *request = [apiClient requestWithMethod:@"GET" path:path parameters:nil];
//    [apiClient request:request success:^(GCResponseStatus *responseStatus, NSArray *folders, NSArray *files) {
//        success(responseStatus,folders,files);
//    } failure:failure];
//}

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

//+ (void)getAlbumsForAccountWithID:(NSNumber *)accountID withSuccess:(void (^)(GCResponseStatus *, NSArray *))success failure:(void (^)(NSError *))failure
//{
//    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
//    NSString *path = [NSString stringWithFormat:@"accounts/%@/albums",accountID];
//
//    NSMutableURLRequest *request = [apiClient requestWithMethod:@"GET" path:path parameters:nil];
//
//    [apiClient request:request factoryClass:[GCAccountAlbum class] success:^(GCResponse *response) {
//        success(response.response, response.data);
//    } failure:failure];
//}

@end
