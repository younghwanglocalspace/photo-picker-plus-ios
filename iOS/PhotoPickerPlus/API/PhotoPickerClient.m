//
//  PhotoPickerClient.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 8/7/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "PhotoPickerClient.h"
#import <AFJSONRequestOperation.h>
#import <Chute-SDK/GCResponse.h>
#import <Chute-SDK/GCResponseStatus.h>
#import <Chute-SDK/GCPagination.h>
#import <DCKeyValueObjectMapping.h>

static NSString * const kBaseURLString = @"http://accounts.getchute.com/v2/accounts";
static dispatch_queue_t serialQueue;

static NSString * const kResponse = @"response";
static NSString * const kData = @"data";
static NSString * const kPagination = @"pagination";

@implementation PhotoPickerClient

+ (PhotoPickerClient *)sharedClient
{
    static PhotoPickerClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serialQueue = dispatch_queue_create("com.getchute.photopickerclient.serialqueue", NULL);
        _sharedClient = [[PhotoPickerClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
    });
    
    [_sharedClient setParameterEncoding:AFJSONParameterEncoding];
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (!self) {
        return nil;
    }
    
    return self;
}
#pragma mark - Base Method for the Services
// request, class, success, failure

- (void)request:(NSMutableURLRequest *)request factoryClass:(Class)factoryClass success:(void (^)(GCResponse *response))success failure:(void (^)(NSError *error))failure {
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [self parseJSON:JSON withFactoryClass:factoryClass success:success];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure: %@", JSON);
        
        failure(error);
        
    }];
    
    [self enqueueHTTPRequestOperation:operation];
}

- (void)parseJSON:(id)JSON withFactoryClass:(Class)factoryClass success:(void (^)(GCResponse *))success
{
    
    DCKeyValueObjectMapping *responseParser = [DCKeyValueObjectMapping mapperForClass:[GCResponseStatus class]];
    DCKeyValueObjectMapping *dataParser = [DCKeyValueObjectMapping mapperForClass:factoryClass];
    
    GCResponse *gcResponse = [GCResponse new];
    gcResponse.response = [responseParser parseDictionary:[JSON objectForKey:kResponse]];
    
    if (factoryClass != nil) {
        if ([[JSON objectForKey:kData] isKindOfClass:[NSArray class]]) {
            gcResponse.data = [dataParser parseArray:[JSON objectForKey:kData]];
        } else {
            gcResponse.data = [dataParser parseDictionary:[JSON objectForKey:kData]];
        }
    }
    else {
        gcResponse.data = [JSON objectForKey:kData];
    }
        
    success(gcResponse);
}

@end
