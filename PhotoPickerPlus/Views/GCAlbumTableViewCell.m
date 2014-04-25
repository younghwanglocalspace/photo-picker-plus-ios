//
//  GCAlbumTableViewCell.m
//  PhotoPickerPlus-SampleApp
//
//  Created by Aranea | Oli on 4/25/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "GCAlbumTableViewCell.h"

@implementation GCAlbumTableViewCell

@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(65, 12, self.contentView.frame.size.width - 75, 21)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
