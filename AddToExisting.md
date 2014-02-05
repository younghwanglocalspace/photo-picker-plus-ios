Adding Photo Picker+ To A Project
=================================

Photo Picker Plus is a drop-in component that replaces the default photo picker in your app.  It allows you to take a photo or record a video as well as choose a photo or video from the device or from several online sources. It also supports multiple selection. This tutorial will show you how to replace the default UIImagePicker in your application with Photo Picker Plus.  This tutorial was written using version 6.0 of the iOS SDK and version 4.2 of Xcode.  Some changes may need to be made for other software versions.

![image1](/screenshots/screen1.png)
![image2](/screenshots/screen2.png)
![image3](/screenshots/screen3.png)

Preparation
-----------
1.  Download the PhotoPickerPlus component and Chute SDK from https://github.com/chute/photo-picker-plus-ios or add as a pod `pod PhotoPickerPlus` in your podfile.
2.  If you don't have a Chute developer account or an app created on chute for this project then create a Chute developer account and make a new app in Chute at http://apps.getchute.com/
	*  For the URL you can enter http://getchute.com/ if you don't have a site for your app
	*  For the Callback URL you can use http://getchute.com/oauth/callback if you don't need callbacks for another purpose.

![image4](/screenshots/1.png)
![image5](/screenshots/2.png)

Add The SDK And Component And Link Dependancies
-----------------------------------------------
1. Add the Chute SDK to the project
2. Add the Photo Picker Plus component
3. Link the required libraries
     *  AssetsLibrary
	 *  SenTestingKit
![image6](/screenshots/3.png)


Configure the PhotoPicker+
------------------------------
Follow [Photo Picker Configuration](PhotoPickerConfiguration.md) on how to initialize PhotoPicker+ component with proper configuration.

At this point you may want to try running the project to make sure that everything is added ok.  If it builds then everything should be correctly added and linked.

Change your delegate
--------------------
In the header for the controller that will be using the component `#import "PhotoPickerViewController.h"` and inherit the `PhotoPickerViewControllerDelegate` instead of the `UIImagePickerDelegate` protocol.

```objective-c
	#import <UIKit/UIKit.h>
	#import "PhotoPickerViewController.h"

	@interface ViewController : UIViewController <PhotoPickerViewControllerDelegate>
	
	//existing code for your class

	@end
```

Change The Delegate Methods
---------------------------
In your class, in UIImagePickerController delegate methods, just change the class type of the picker from  `UIImagePickerController` to `PhotoPickerViewController`.  You can leave the code in these methods exactly the same as you had before because the return values are the same format.

```objective-c
	- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker{
	    //cancel code
	}
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
	{
   		//image picked code
	}
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info
	{
    	//array of images picked code
	}

```
**Note:** If you have set the boolean property `show_videos` to `YES` in the configuration, then you can also return videos with these methods. You can check what type of media you have chosen by inspecting the `UIImagePickerControllerMediaType`.

Displaying The Image Picker
---------------------------
Finally replace the code to display the image picker.  Photo Picker Plus lets the user select a source for the image so you don't need to set it ahead of time. You will only need to specify if you want multiple selection picker or single, by setting isMultipleSelectionEnabled. 

```objective-c
	PhotoPickerViewController *picker = [[PhotoPickerViewController alloc ] initWithTitle:@"Select Photo"];
    [picker setDelegate:self];
    [picker setIsMultipleSelectionEnabled:NO]; // [picker setIsMultipleSelectionEnabled:YES] - for multiple choice.
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
```

Conclusion
----------
You now have a multi-service photo picker in your app instead of Apple's UIImagePickerController.  Most of your existing code for the imagePicker should still work because the info dictionary returned is designed to match the info dictionary returned by the UIImagePicker.
