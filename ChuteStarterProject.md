Chute Starter Project Tutorial
==============================

Photo Picker Plus is a drop-in component that replaces the default photo picker in your app.  It allows you to take a photo or record a video as well as choose a photo or video from the device or from several online sources. It also supports multiple selection. This tutorial will show you how to use the Photo Picker Plus component to present the user with a multi-service photo picker and use the chosen image/images to set a scrollView with imageView.  This tutorial was written using version 6.0 of the iOS SDK and version 4.2 of Xcode. Some changes may need to be made for other software versions.

![image1](/screenshots/screen1.png)
![image2](/screenshots/screen2.png)
![image3](/screenshots/screen3.png)

Create A New Project
--------------------
Start by creating a new Xcode project.  A single view application will be easiest to modify for this tutorial.  You can choose whatever name you like, I'll call it PhotoPickerPlus.

![image4](/screenshots/5.png)

Preparation
-----------
1.  Download the PhotoPickerPlus component and Chute SDK from https://github.com/chute/photo-picker-plus-ios or add as a pod `pod PhotoPickerPlus` in your podfile.
2.  Create a Chute developer account and make a new app in Chute at http://apps.getchute.com/
	*  For the URL you can enter http://getchute.com/ if you don't have a site for your app
	*  For the Callback URL you can use http://getchute.com/oauth/callback if you don't need callbacks for another purpose.

![image5](/screenshots/1.png)
![image6](/screenshots/2.png)

Add The SDK And Component And Link Dependancies
-----------------------------------------------
1. Add the SDK to the project
2. Add the picker component
3. Link the required libraries
     *  AssetsLibrary
     *  SenTestingKit

![image7](/screenshots/3.png)

Configure the PhotoPicker+
---------------------------
First you need to setup the configuration. Follow [PhotoPickerConfiguration.md](PhotoPickerConfiguration.md) on how to initialize PhotoPicker+ component with proper configuration.

At this point you may want to try running the project to make sure that everything is added ok.  If it builds then everything should be correctly added and linked.

Set ViewController As Delegate And Add Objects/Methods
-----------------------------------------------
In your ViewController.h file import PhotoPickerViewController.h and set up the class as a `PhotoPickerViewControllerDelegate`. There are some properties and actions that are going to be connected during creating the UI later.

ViewController.h

```objective-c
	#import <UIKit/UIKit.h>
	#import "PhotoPickerViewController.h"

	@interface ViewController : UIViewController <PhotoPickerViewControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate>

	@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
	@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
	@property (strong, nonatomic) UIPopoverController   *popoverController;

	- (IBAction)pickPhotoSelected:(id)sender;
	- (IBAction)pickMultiplePhotosSelected:(id)sender;
	- (IBAction)changePage:(id)sender;

	@end
```

Write The Display Methods
-------------------------------------------------
In ViewController.m write the methods to display the photo picker plus component. The methods will initialize the controller, set itself as the delegate, set single or multiple selection by setting isMultipleSelectionEnabled and present it. For the iPad version the component is presented as pop over.

ViewController.m

```objective-c
	@synthesize scrollView, pageControl, popoverController;


	- (IBAction)pickPhotoSelected:(id)sender
	{
    	PhotoPickerViewController *picker = [[PhotoPickerViewController alloc ] initWithTitle:@"Select Photo"];
	    [picker setDelegate:self];
    	[picker setIsMultipleSelectionEnabled:NO];
	    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    	    if (![[self popoverController] isPopoverVisible]) {
        	    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
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
    	PhotoPickerViewController *picker = [[PhotoPickerViewController alloc ] initWithTitle:@"Select Photo"];
	    [picker setDelegate:self];
	    [picker setIsMultipleSelectionEnabled:YES];
    	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        	if (![[self popoverController] isPopoverVisible]) {
            	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
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
```

Write The Delegate Methods
--------------------------
The PhotoPickerViewControllerDelegate methods are just as same as in UIImagePickerControllerDelegate, the only difference is the class type of the picker.  These work exactly the same as the UIImagePickerController delegate methods to make things easier.  You can refer to Apple's documentation on UIImagePickerControllerDelegate to see what the keys in the dictionary are.

####Note: The following code is just to show the delegate methods and not to copy the whole code from ViewController.m. For detail implementation you can check the tutorial.

ViewController.m

```objective-c
	- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker
	{
    	if (self.popoverController) {
        	[self.popoverController dismissPopoverAnimated:YES];
    	}
    	else {
        	[self dismissViewControllerAnimated:YES completion:nil];
    	}
	}
	
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
	{

    	// your code for displaying the chosen image/video. For detail implementation code you can check the tutorial.
    	
    	    
    	if (self.popoverController) {
        	[self.popoverController dismissPopoverAnimated:YES];
	    }
    	else {
        	[self dismissViewControllerAnimated:YES completion:nil];
	    }
	}
	
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info
	{

    	// your code for displaying the array of chosen images/videos. For detail implementation code you can check the tutorial.
    	
    	if (self.popoverController) {
        	[self.popoverController dismissPopoverAnimated:YES];
	    }
		    else {
        		[self dismissViewControllerAnimated:YES completion:nil];
	    	}
	}
```



Create The UI
-------------
Open MainStoryboard_iPhone.storyboard and add an UIScrollView covering most of the view. Underneath place UIPageControl and two UIButton below it.  Hook the UIScrollView up to the scrollView object, the UIPageControl to the pageControl object, the pickPhotoSelected action to the touchUpInside event of the button, the pickMultiplePhotosSelected action to the touchUpInside event of the button and the changePage action to the valueChanged event of the page control.  You do this by right clicking on the view controller and dragging from the circle for the outlet or action that you want to it's corresponding object either in the object's list or in the view itself.  You can set the title for the buttons whatever you want by selecting it then changing it's title in the attribute inspector on the right side of the screen.  I called mine Pick Photo and Pick Multiple Photos.

![image9](/screenshots/6.png)

Conclusion
----------
You should have a fully working app now that allows you to take a photo, pick an image from the device, or pick an image from a variety of online sources.  Due to the picker accessing the ALAssets it will present the user with a dialog asking if they want to allow location services.  This is because ALAssets have location data associated with the images.  If the user declines then the picker will not allow them to choose images that are on the device however all other sources should still work.
