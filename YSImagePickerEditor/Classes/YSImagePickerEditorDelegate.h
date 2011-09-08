//
//  YSImagePickerEditorDelegate.h
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol YSImagePickerEditorDelegate <NSObject>
-(void)YSImagePickerDoneEditWithImage:(UIImage*)image;
-(void)YSImagePickerFailedWithError:(NSError *)error;

@end
