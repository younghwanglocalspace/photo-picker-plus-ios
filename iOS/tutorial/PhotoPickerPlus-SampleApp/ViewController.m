//
//  ViewController.m
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 7/28/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "GCPopoverBackgroundView.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView, popoverController;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)pickPhotoSelected:(id)sender
{
    PhotoPickerViewController *picker = [PhotoPickerViewController new];
    [picker setDelegate:self];
//    [picker setOauth2Client:[GCOAuth2Client clientWithClientID:@"4f3c39ff38ecef0c89000003" clientSecret:@"c9a8cb57c52f49384ab6117c4f6483a1a5c5a14c4a50d4cef276a9a13286efc9"]];
    [picker setIsMultipleSelectionEnabled:NO];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (![[self popoverController] isPopoverVisible]) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popover setPopoverBackgroundViewClass:[GCPopoverBackgroundView class]];
            [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popoverController = popover;
        }
        else {
            [[self popoverController] dismissPopoverAnimated:YES];
        }
    }
    else {
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)pickMultiplePhotosSelected:(id)sender
{
    PhotoPickerViewController *picker = [PhotoPickerViewController new];
    [picker setDelegate:self];
//    [picker setOauth2Client:[GCOAuth2Client clientWithClientID:@"4f3c39ff38ecef0c89000003" clientSecret:@"c9a8cb57c52f49384ab6117c4f6483a1a5c5a14c4a50d4cef276a9a13286efc9"]];
    [picker setIsMultipleSelectionEnabled:YES];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (![[self popoverController] isPopoverVisible]) {
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
            [popover setPopoverBackgroundViewClass:[GCPopoverBackgroundView class]];
            [popover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            self.popoverController = popover;
        }
        else {
            [[self popoverController] dismissPopoverAnimated:YES];
        }
    }
    else {
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - PhotoPickerViewController Delegate Methods

- (void)imagePickerController:(GCPhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info
{

    for (UIView *v in [scrollView subviews]) {
        [v removeFromSuperview];
    }
    
    CGRect workingFrame = scrollView.frame;
    workingFrame.origin.x = 0;
        
    for(NSDictionary *dict in info) {
        
        UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        imageView.frame = workingFrame;
        
        [scrollView addSubview:imageView];
        
        workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
    }
    [scrollView setPagingEnabled:YES];
    [scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerController:(GCPhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    for (UIView *v in [scrollView subviews]) {
        [v removeFromSuperview];
    }
    
    CGRect workingFrame = scrollView.frame;
    workingFrame.origin.x = 0;
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    imageView.frame = workingFrame;
    
    [scrollView addSubview:imageView];
    
    workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
    [scrollView setPagingEnabled:YES];
    [scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)imagePickerControllerDidCancel:(GCPhotoPickerViewController *)picker
{
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect workingFrame = scrollView.frame;
    workingFrame.origin.x = 0;

    for (UIView *v in [scrollView subviews]) {
        v.frame = workingFrame;
        workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
    }
    [scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
}

@end
