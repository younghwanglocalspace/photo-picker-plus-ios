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
#import "GCAccountAssets.h"
#import "GCOptions.h"
#import "PhotoPickerClient.h"

#import <Chute-SDK/NSString+QueryString.h>
#import <Chute-SDK/GCResponse.h>
#import <Chute-SDK/GCClient.h>
#import <Chute-SDK/GCResponseStatus.h>

static NSString * const kGCAuth = @"Authorization";
static NSString * const kClientGET = @"GET";

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

+ (void)getDataForServiceWithName:(NSString *)serviceName forAccountWithID:(NSNumber *)accountID forAlbumWithID:(NSNumber *)albumID success:(void (^)(GCResponseStatus *, NSArray *, NSArray *))success failure:(void (^)(NSError *))failure
{
    PhotoPickerClient *apiClient = [PhotoPickerClient sharedClient];
    NSString *path;
    if(albumID == nil)
        path = [NSString stringWithFormat:@"%@/%@/files",serviceName,accountID];
    else
    {
        NSString *albumIDString = [[NSString stringWithFormat:@"%@",albumID] stringByEscapingForURL];
        path = [NSString stringWithFormat:@"%@/%@/folders/%@/files",serviceName,accountID,albumIDString];
    }
    
    NSLog(@"path:%@",path);
    NSMutableURLRequest *request = [apiClient requestWithMethod:kClientGET path:path parameters:nil];
    
    [apiClient request:request success:^(GCResponseStatus *responseStatus, NSArray *folders, NSArray *files) {
        success(responseStatus,folders,files);
    } failure:failure];
}

#warning implement it when becomes live!
+ (void)postSelectedImages:(NSArray *)selectedImages success:(void(^)(GCResponseStatus *, NSArray *))success failure:(void(^)(NSError *))failure
{
    GCClient *apiClient = [GCClient sharedClient];
    
    GCOptions *options;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GCConfiguration" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *oauth = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"oauth"]];

    [options setClientID:[oauth objectForKey:@"client_id"]];
    
    NSMutableArray *media = [[NSMutableArray alloc] initWithCapacity:[selectedImages count]];
    for(GCAccountAssets *asset in selectedImages)
    {
        [media addObject:asset];
    }
    
    NSDictionary *param = @{@"options":options,
                            @"media":media};
    
    NSString *path = [NSString stringWithFormat:@"widgets/native"];
    
    NSMutableURLRequest *request = [apiClient requestWithMethod:kGCClientPOST path:path parameters:param];
    [request setValue:[apiClient authorizationToken] forHTTPHeaderField:kGCAuth];
    
    [apiClient request:request factoryClass:[GCAccountAssets class] success:^(GCResponse *response) {
        success(response.response,response.data);
    } failure:failure];
}

@end
