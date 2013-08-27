PhotoPickerPlus
==============

no external dependancies beyond Chute SDK

Description
-----------

This class allows you to pick a photo from any supported online source such as Facebook, Instagram and Dropbox among others. It also replaces the standard picker in that it allows you to pick photos from the device, take photo with the camera or just to pick the latest photo in your library. It has integrated support for multiple image selection, just as the original Image Picker from Apple.

Screenshots
-----------


Initialization
--------------

 *   isMultipleSelectionEnabled - `BOOL` - If YES, picker does multi image selection, if NO, picker does single image selection.
 *   delegate `NSObject <PhotoPickerPlusDelegate>` - The delegate for this component. It should implement two of the following delegate methods, depending on single or multiple selection.
    *  `- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;`
    *  `- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info;`
    *  `- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker;`
    
Implementation
--------------
You will need to implement PhotoPickerPlus.h in your .h file. You will also need to put `<PhotoPickerViewControllerDelegate>`
```objective-c

    ////////////////////////
    //	  Single Photo	  //
    ////////////////////////
    
    - (void)showPhotoPickerPlus {
    	PhotoPickerViewController *picker = [PhotoPickerViewController new];
    	[picker setDelegate:self];
    	[picker setIsMultipleSelectionEnabled:NO];
        [self presentViewController:picker animated:YES completion:nil];
	}

	- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker{
    	//place code for when the user cancels here
	    //such as removing the picker from the screen
	}
	
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
		//place code for when the user picks photos here and do any
	    //additional work such as removing the picker from the screen
	}
	
	///////////////////////
    //	  Multi Photo    //
    ///////////////////////
    
    - (void)showPhotoPickerPlus {
    	PhotoPickerViewController *picker = [PhotoPickerViewController new];
    	[picker setDelegate:self];
    	[picker setIsMultipleSelectionEnabled:YES];
        [self presentViewController:picker animated:YES completion:nil];
	}

	- (void)imagePickerControllerDidCancel:(PhotoPickerViewController *)picker{
    	//place code for when the user cancels here
	    //such as removing the picker from the screen
	}
	
	- (void)imagePickerController:(PhotoPickerViewController *)picker didFinishPickingArrayOfMediaWithInfo:(NSArray *)info{
		//place code for when the user picks photos here and do any
	    //additional work such as removing the picker from the screen
	}