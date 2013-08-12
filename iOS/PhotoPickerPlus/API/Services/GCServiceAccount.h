//
//  GCServiceAccount.h
//  Chute-SDK
//
//  Created by ARANEA on 7/30/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCResponseStatus, GCAccount;

@interface GCServiceAccount : NSObject

+ (void)getProfileInfoWithSuccess:(void(^)(GCResponseStatus *responseStatus,NSArray *accounts))success failure:(void (^)(NSError *error))failure;

+ (void)getAlbumsForAccountWithID:(NSNumber *)albumID withSuccess:(void(^)(GCResponseStatus *responseStatus, NSArray *accountAlbums))success failure:(void(^)(NSError *error))failure;

@end
