//
//  ViewController.m
//  PhotoPickerPlus-SampleApp
//
//  Created by Aleksandar Trpeski on 7/28/13.
//  Copyright (c) 2013 Chute. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

-(IBAction)pickPhotoSelected:(id)sender
{
    PhotoPickerViewController *picker = [PhotoPickerViewController new];
    [picker setDelegate:self];
    [picker setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:picker animated:YES completion:^(void){
    }];
}

#pragma mark - PhotoPickerViewController Delegate Methods

- (void)photoPickerViewController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(id)info
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        [[self imageView] setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }];
}

- (void)photoPickerViewControllerDidCancel:(PhotoPickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        
    }];
}


@end
