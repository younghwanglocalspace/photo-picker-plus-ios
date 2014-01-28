//
//  CustomImageView.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 1/27/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "CustomImageView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CustomImageView ()

@property (nonatomic, strong) NSURL     *videoUrl;

@end

@implementation CustomImageView

@synthesize videoUrl;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self setUserInteractionEnabled:YES];
        [self setContentMode:UIViewContentModeScaleAspectFit];

        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

        if ([mediaType isEqualToString:(NSString *)kUTTypeVideo] || [mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
            self.videoUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performAction:)];
            tap.numberOfTapsRequired = 1;
            
            UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextSaveGState(context);
            UIImage *bottomImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            CGRect bottomImageRect = CGRectMake(0, 0, frame.size.width, frame.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextTranslateCTM(context, 0, -bottomImageRect.size.height);
            CGContextDrawImage(context, bottomImageRect, bottomImage.CGImage);
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            UIImage *topImage = [UIImage imageNamed:@"play_overlay.png"];
            CGRect topImageRect = CGRectMake(110, -110, 60, 60);
            CGContextScaleCTM(context, 1.0, -1.0);
            CGContextTranslateCTM(context, 0, -topImageRect.size.height);
            CGContextDrawImage(context, topImageRect, topImage.CGImage);
            CGContextRestoreGState(context);
            UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            [self setImage:result];
            
            [self addGestureRecognizer:tap];
        }
        else
            [self setImage:[info objectForKey:UIImagePickerControllerOriginalImage]]; 
    }
    
    return self;
}

#pragma mark - IBAction

- (void)performAction:(id)sender
{
    [self.delegate playVideoWithURL:self.videoUrl];
    
    NSLog(@"Tapped :%@!",self.videoUrl);
    
}

#pragma mark - Delegate Methods

- (void)playVideoWithURL:(NSURL *)URL
{
    if ([self.delegate respondsToSelector:@selector(playVideoWithURL:)]) {
        [self.delegate playVideoWithURL:URL];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
