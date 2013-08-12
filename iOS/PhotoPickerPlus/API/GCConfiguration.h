//
//  GCConfiguration.h
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 8/10/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCAccount;

@interface GCConfiguration : NSObject

@property (strong, nonatomic) NSArray           *services;
@property (strong, nonatomic) NSDictionary      *oauthData;
@property (strong, nonatomic) NSMutableArray    *accounts;

+ (GCConfiguration *) configuration;

- (void)addAccount:(GCAccount *)account;

@end
