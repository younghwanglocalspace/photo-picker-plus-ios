In order to use the PhotoPicker+ component, you need to provide a proper configuration.

Configuration
-------------
This configuration allows you to choose which services (local and remote) will be available for your application to use. From local services we include: Take Photo, Record Video, Last Photo Taken, Last Video Captured and All Media. From remote services we include: Facebook, Google, Google Drive, Instagram, Flickr, Picasa, Skydrive, Dropbox and Youtube.

First you need to make a copy of GCConfiguration-Sample.plist and name it GCConfiguration.plist. Then you need to add it to you project manually.
Then in chute-sdk dictionary you need to insert your App ID and App Secret.
In photopicker dictionary there is predefined configuration. It consists of:
 *`configuration_url` - this one should be filled in order to receive the service list from the server. When app is started for the first time it shows options that are defined in this configuration, while on the second time it shows the complete list of services retrieved from the server.
 *`services` - this array of services is shown only for the first time. It usually should show the same services as the services from the server.
 *`local_features` - this array of local services is shown for the first time. It usually should show the same local services as the services from the server.
 *`load_images_from_web` - Boolean property used to decide whether or not the asset/s should be downloaded from the Internet when we return assets from the photo picker.
 *`show_images` - Boolean property used to decide whether or not images will be shown from local and online services.
 *`shown_videos` - Boolean property used to decide whether or not videos will be shown from local and online services.
 
 ![screen 1](/screenshots/4.png)
 
 #####Attention! - We strongly recommend one of the last two boolean properties to be set to YES, because it's actually absurd to use Photo Picker + and not show anything. Additionally we throw runtime exception to remind you if this case occurs.
 
 Default Configuration
 ---------------------
 As mentioned before, if you don't set `configuration_url` then Photo Picker+ will be initialized only with the pre-defined services which are the actually all current supported services.
 
 Configuration URL
 -----------------
 
 If you want you can create your own file containing JSON model as the following one:
 ```objective-c
 	{
        "services":[
                   "facebook",
                   "instagram",
                   "skydrive",
                   "googledrive",
                   "google",
                   "picasa",
                   "flickr",
                   "dropbox",
                   "youtube"
                   ],
         "local_features":[
                   "all_media",
                   "take_photo",
                   "last_photo_taken"
                   ]
     }
 
 ``` 