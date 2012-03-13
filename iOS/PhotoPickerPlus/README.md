PhotoPickerPlus
==============

no external dependancies beyond Chute SDK (version 1.0.5 or newer)

Description
-----------

This class allows you to pick a photo from the any supported online source such as Facebook, picasa and instagram among others.  It also replaces the standard picker in that it allows you to pick photos from the device or take a photo with the camera. It can optionally be used to select multiple images from the device and online sources.  At this time with multi-image selection you are still limited to a single photo with the camera, however it will return an array with the single photo in the multi-image delegate function.  We are working to bring multiple images from the camera in a future update.

Screenshots
-----------
![screen1](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen1.png)![screen2](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen2.png)![screen3](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen3.png)![screen4](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen4.png)![screen5](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen5.png)![screen6](https://github.com/chute/photo-picker-plus/raw/master/iOS/PhotoPickerPlus/screenshots/screen6.png)

Subclassing
-----------

While subclassing this component is possible, it is not really recommended.  If you want to change the appearance of the component it is recommended that you simply modify the .xib file.  Image selection is passed to a delegate method so any custom behavior can be handled there.

Initialization
--------------

 *   sourceType (optional) - `PhotoPickerPlusSourceType` - Sets whether to display the source selection screen or to only allow image selection from a specific source.  The different options are `PhotoPickerPlusSourceTypeAll`, `PhotoPickerPlusSourceTypeLibrary`, `PhotoPickerPlusSourceTypeCamera` and `PhotoPickerPlusSourceTypeNewestPhoto`.  If you don't set this then it defaults to `PhotoPickerPlusSourceTypeAll`.
 *   multipleImageSelectionEnabled (optional) - `BOOL` - if on picker does multi image selection if off picker does single image selection.  If not set then it defaults to off.
 *   delegate - `NSObject <PhotoPickerPlusDelegate>` - The delegate for this component.  It should implement two methods.
    *  `-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;`
    *  `-(void)PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker;`
    *  `-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingArrayOfMediaWithInfo: (NSArray*)info;`


Implementation
--------------


```objective-c

	/////////////////////////
	//     Single Photo    //
	/////////////////////////
	
    -(void)showPhotoPickerPlus{
	    PhotoPickerPlus *temp = [[PhotoPickerPlus alloc] init];
	    [temp setDelegate:self];
	    self.modalPresentationStyle = UIModalPresentationCurrentContext;
	    [self presentModalViewController:temp animated:NO];
	    [temp release];
	}
	-(void)PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker{
	    //place code for when the user cancels here
	    //such as removing the picker from the screen
	}
	-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	    //place code for when the user picks a photo here and do any
	    //additional work such as removing the picker from the screen
	}

	////////////////////////
	//     Multi Photo    //
	////////////////////////
	
    -(void)showPhotoPickerPlus{
	    PhotoPickerPlus *temp = [[PhotoPickerPlus alloc] init];
	    [temp setDelegate:self];
    	[temp setMultipleImageSelectionEnabled:YES];
	    self.modalPresentationStyle = UIModalPresentationCurrentContext;
	    [self presentModalViewController:temp animated:NO];
	    [temp release];
	}
	-(void)PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker{
	    //place code for when the user cancels here
	    //such as removing the picker from the screen
	}
	-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingArrayOfMediaWithInfo: (NSArray*)info{
	    //place code for when the user picks photos here and do any
	    //additional work such as removing the picker from the screen
	}
	
	/////////////////////////
	//  Only Choose Photo  //
	/////////////////////////
	
    -(void)showPhotoPickerPlus{
	    PhotoPickerPlus *temp = [[PhotoPickerPlus alloc] init];
	    [temp setDelegate:self];
    	[temp setSourceType:PhotoPickerPlusSourceTypeLibrary];
	    self.modalPresentationStyle = UIModalPresentationCurrentContext;
	    [self presentModalViewController:temp animated:NO];
	    [temp release];
	}
	-(void)PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker{
	    //place code for when the user cancels here
	    //such as removing the picker from the screen
	}
	-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	    //place code for when the user picks a photo here and do any
	    //additional work such as removing the picker from the screen
	}
```
