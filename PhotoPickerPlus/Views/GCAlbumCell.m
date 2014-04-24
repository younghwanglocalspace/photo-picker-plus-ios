//
//  GCAlbumCell.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 3/17/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "GCAlbumCell.h"

@implementation GCAlbumCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor colorWithRed:0.97 green:0.99 blue:1 alpha:1]];
        
        CGFloat borderWidth = 0.5f;
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        UIView *myContentView = [[UIView alloc] initWithFrame:myContentRect];
        myContentView.layer.borderColor = [UIColor colorWithRed:0.62 green:0.63 blue:0.64 alpha:1].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        [self.contentView addSubview:myContentView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 17.5, 25, 22)];
        [self.imageView setImage:[UIImage imageNamed:@"albumIcon"]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9]];
        [self.titleLabel setNumberOfLines:2];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.titleLabel setTextColor:[UIColor colorWithRed:0.2 green:0.21 blue:0.23 alpha:1]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeMake(self.contentView.frame.size.width - 10, 42)];
    [self.titleLabel setFrame:CGRectMake(5, self.imageView.frame.origin.y + self.imageView.frame.size.height + 5, self.contentView.frame.size.width - 10, labelSize.height)];
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
