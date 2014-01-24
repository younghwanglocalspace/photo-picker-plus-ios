//
//  VideoButton.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 1/24/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "VideoButton.h"

@interface VideoButton ()

@property (nonatomic, strong) NSURL *videoURL;

@end

@implementation VideoButton

@synthesize videoURL;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andVideoUrl:(NSURL *)_videoURL
{
    self = [self initWithFrame:frame];
    if (self) {
        
        self.videoURL = _videoURL;
    }
    
    return self;
}

@end
