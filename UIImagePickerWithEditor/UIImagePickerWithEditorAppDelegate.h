//
//  UIImagePickerWithEditorAppDelegate.h
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIImagePickerWithEditorViewController;

@interface UIImagePickerWithEditorAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIImagePickerWithEditorViewController *viewController;

@end
