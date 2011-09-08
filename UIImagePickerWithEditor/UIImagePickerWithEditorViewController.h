//
//  UIImagePickerWithEditorViewController.h
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSImagePickerEditorDelegate.h"
#import "YSImagePickerEditor.h"
@interface UIImagePickerWithEditorViewController : UIViewController <YSImagePickerEditorDelegate>{
    IBOutlet UIBarButtonItem* chooseImageButton;
    IBOutlet UIImageView * imageView;
    YSImagePickerEditor* imagePicker;
}
@property (nonatomic,retain) YSImagePickerEditor* imagePicker;

-(IBAction)chooseImage:(id)sender;

@end
