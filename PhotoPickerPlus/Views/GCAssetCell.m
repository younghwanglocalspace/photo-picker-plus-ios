//
//  AssetCell.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 3/17/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "GCAssetCell.h"

#define IS_IOS7 [[UIDevice currentDevice].systemVersion hasPrefix:@"7"]

@interface GCAssetCell ()

@property (nonatomic, strong) UIImageView   *overlayView;

@end

@implementation GCAssetCell

@synthesize overlayView, imageView, titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (IS_IOS7)
            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 55, 55)];
        else
            self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        
        self.overlayView = [[UIImageView alloc] initWithFrame:self.imageView.frame];
        [self.overlayView setImage:[UIImage imageNamed:@"overlay.png"]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + 15, 8, self.contentView.bounds.size.width - (self.imageView.frame.origin.x + self.imageView.frame.size.width) - 23, 40)];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14]];
        [self.titleLabel setNumberOfLines:2];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        
        [self.contentView insertSubview:self.imageView atIndex:1];
        [self.contentView insertSubview:self.overlayView atIndex:2];
        [self.contentView addSubview:self.titleLabel];
        [self.overlayView setHidden:YES];

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (IS_IOS7) {
            [self setSeparatorInset:UIEdgeInsetsMake(0, 85, 0, 0)];
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self.overlayView setHidden:!selected];
}

@end
