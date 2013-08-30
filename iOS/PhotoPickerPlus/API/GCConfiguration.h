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

///--------------------------------
/// @name Creating Singleton object
///--------------------------------

/**
 Creates a singleton object for the configuration.
 */
+ (GCConfiguration *) configuration;

///------------------------
/// @name Adding an account
///------------------------

/**
 Adding an account to an array. It is used for bigger controll for which account is already logged in.
 
 @param account The account that needs to be added to logged accounts.
 
 @warning This method requires `GCAccount` class. Add am  
*/

- (void)addAccount:(GCAccount *)account;

@end
