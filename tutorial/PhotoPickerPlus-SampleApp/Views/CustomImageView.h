//
//  CustomImageView.h
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 1/27/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomImageViewDelegate <NSObject>

@required

- (void)playVideoWithURL:(NSURL *)videoURL;

@end

@interface CustomImageView : UIImageView <CustomImageViewDelegate>

- (id)initWithFrame:(CGRect)frame andInfo:(NSDictionary *)info;
@property (nonatomic, assign) id <CustomImageViewDelegate>delegate;

@end
