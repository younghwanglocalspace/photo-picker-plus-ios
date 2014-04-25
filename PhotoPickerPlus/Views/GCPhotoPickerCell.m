//
//  PhotoPickerCell.m
//  GCAPIv2TestApp
//
//  Created by Chute Corporation on 7/24/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "GCPhotoPickerCell.h"

@implementation GCPhotoPickerCell
@synthesize titleLabel, imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.imageView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGRectMake(75, 10, 230, 25)
    [self.titleLabel setFrame:CGRectMake(15, 12, self.contentView.frame.size.width - 30, 21)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
