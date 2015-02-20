//
//  UIImage+VideoImage.m
//  PhotoPickerPlus-SampleApp
//
//  Created by ARANEA on 1/30/14.
//  Copyright (c) 2014 Chute. All rights reserved.
//

#import "UIImage+VideoImage.h"

@implementation UIImage (VideoImage)

+ (UIImage *)makeImageFromBottomImage:(UIImage *)bottomImage withFrame:(CGRect)bottomImageFrame andTopImage:(UIImage *)topImage withFrame:(CGRect)topImageFrame
{
  CGSize newSize = CGSizeMake(bottomImage.size.width, bottomImage.size.height);
  UIGraphicsBeginImageContext( newSize );
  
  // Use existing opacity as is
  [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
  
  // Apply supplied opacity if applicable
  [topImage drawInRect:topImageFrame blendMode:kCGBlendModeNormal alpha:1];
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();

  return newImage;
//    UIGraphicsBeginImageContextWithOptions(bottomImageFrame.size, NO, 0.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSaveGState(context);
//    UIImage *mainImage = bottomImage;
//    CGRect bottomImageRect = CGRectMake(0, 0, bottomImageFrame.size.width, bottomImageFrame.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextTranslateCTM(context, 0, -bottomImageRect.size.height);
//    CGContextDrawImage(context, bottomImageRect, mainImage.CGImage);
//    CGContextRestoreGState(context);
//    
//    CGContextSaveGState(context);
//    UIImage *overlayImage = topImage;
//    CGRect topImageRect = CGRectMake(topImageFrame.origin.x, -topImageFrame.origin.y, topImageFrame.size.width, topImageFrame.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    CGContextTranslateCTM(context, 0, -topImageRect.size.height);
//    CGContextDrawImage(context, topImageRect, overlayImage.CGImage);
//    CGContextRestoreGState(context);
//    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return result;
}

@end
