//
//  GCServiceAccountAlbum.h
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/1/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCResponseStatus;

@interface GCServiceAccountAlbum : NSObject

+ (void)getDataForServiceWithName:(NSString *)serviceName forAccountWithID:(NSNumber *)accountID forAlbumWithID:(NSNumber *)albumID success:(void(^)(GCResponseStatus *responseStatus,NSArray *folders, NSArray *files))success failure:(void(^)(NSError *error))failure;

//+ (void) getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:(NSNumber *)accountAlbumID success:(void(^)(GCResponseStatus *responseStatus, NSArray *accountAssets))success failure:(void(^)(NSError *error))failure;

@end
