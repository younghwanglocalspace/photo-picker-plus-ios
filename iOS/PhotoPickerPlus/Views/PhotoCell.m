//
//  PhotoCell.m
//  GCAPIv2TestApp
//
//  Created by Chute Corporation on 7/25/13.
//  Copyright (c) 2013 Aleksandar Trpeski. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 73.75, 73.75)];
        
        [self.contentView addSubview:imageView];
        
    }
    return self;
}
//#error  add two images, original and tinted



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
