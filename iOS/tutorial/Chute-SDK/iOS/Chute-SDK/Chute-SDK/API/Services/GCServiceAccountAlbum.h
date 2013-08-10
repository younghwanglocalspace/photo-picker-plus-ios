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

+ (void) getMediaForAccountWithID:(NSNumber *)accountID forAccountAlbumWithID:(NSNumber *)accountAlbumID success:(void(^)(GCResponseStatus *responseStatus, NSArray *accountAssets))success failure:(void(^)(NSError *error))failure;

@end
