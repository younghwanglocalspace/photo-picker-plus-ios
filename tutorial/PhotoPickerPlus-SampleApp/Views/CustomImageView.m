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
#import "UIImage+VideoImage.h"

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
            
            [self setImage:[UIImage makeImageFromBottomImage:[info objectForKey:UIImagePickerControllerOriginalImage] withFrame:frame andTopImage:[UIImage imageNamed:@"play_overlay.png"] withFrame:CGRectMake(110, 110, 60, 60)]];
            
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
