//
//  PhotoPickerPlus.h
//  ChuteSDKDevProject
//
//  Created by Brandon Coston on 1/21/12.
//  Copyright (c) 2012 Chute Corporation. All rights reserved.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "GetChute.h"

enum {
    PhotoPickerPlusSourceTypeAll,
    PhotoPickerPlusSourceTypeLibrary,
    PhotoPickerPlusSourceTypeCamera,
    PhotoPickerPlusSourceTypeNewestPhoto
};
typedef NSUInteger PhotoPickerPlusSourceType;

@protocol PhotoPickerPlusDelegate;

@interface PhotoPickerPlus : GCUIBaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) NSObject <PhotoPickerPlusDelegate> *delegate;

//set to the source of the image selected
@property (nonatomic) PhotoPickerPlusSourceType sourceType;

@property (nonatomic) BOOL appeared;
@property (nonatomic) BOOL multipleImageSelectionEnabled;

@end

@interface AccountViewController : GCUIBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSObject <PhotoPickerPlusDelegate> *delegate;
@property (nonatomic, assign) PhotoPickerPlus *P3;

@property (nonatomic, retain) NSArray *photoAlbums;
@property (nonatomic, retain) NSArray *accounts;

@property (nonatomic, retain) UITableView *accountsTable;

@property (nonatomic) int accountIndex;

@property (nonatomic) BOOL multipleImageSelectionEnabled;

-(UIView*)tableView:(UITableView *)tableView viewForIndexPath:(NSIndexPath*)indexPath;

@end

@interface AccountLoginViewController : GCUIBaseViewController <UIWebViewDelegate>

@property (nonatomic, retain) UIWebView *AddServiceWebView;
@property (nonatomic, retain) NSString *service;

@end

@interface AlbumViewController : GCUIBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSObject <PhotoPickerPlusDelegate> *delegate;
@property (nonatomic, assign) PhotoPickerPlus *P3;

@property (nonatomic, retain) NSArray *albums;

@property (nonatomic, retain) UITableView *albumsTable;

@property (nonatomic) BOOL multipleImageSelectionEnabled;

@property (nonatomic, assign) NSDictionary *account;

-(UIView*)tableView:(UITableView *)tableView viewForIndexPath:(NSIndexPath*)indexPath;

@end

@interface PhotoViewController : GCUIBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSObject <PhotoPickerPlusDelegate> *delegate;
@property (nonatomic, assign) PhotoPickerPlus *P3;

@property (nonatomic, retain) NSArray *photos;
@property (nonatomic, retain) NSMutableSet *selectedAssets;

@property (nonatomic, retain) UITableView *photosTable;

@property (nonatomic, retain) UIView *photoCountView;
@property (nonatomic, retain) UILabel *photoCountLabel;

@property (nonatomic) BOOL multipleImageSelectionEnabled;
@property (nonatomic, assign) NSDictionary *account;
@property (nonatomic, assign) NSDictionary *album;
@property (nonatomic, assign) ALAssetsGroup *group;

-(UIView*)tableView:(UITableView *)tableView viewForIndexPath:(NSIndexPath*)indexPath;

@end

@protocol PhotoPickerPlusDelegate <NSObject>

-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void)PhotoPickerPlusControllerDidCancel:(PhotoPickerPlus *)picker;
-(void)PhotoPickerPlusController:(PhotoPickerPlus *)picker didFinishPickingArrayOfMediaWithInfo: (NSArray*)info;

@end

