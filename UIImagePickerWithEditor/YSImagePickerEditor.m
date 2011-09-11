//
//  YSImagePickerEditor.m
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/8/11.
//  Copyright 2011 http://www.27dv.com All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "YSImagePickerEditor.h"
#import "YSImageCrop.h"


//------------------------------------------------------------------------------
#pragma mark - Private Interface
//------------------------------------------------------------------------------
@interface YSImagePickerEditor()
-(void)presentImagePicker;
-(void)presentPopoverImageCropWithImage:(UIImage*)image;
-(void)dismissPopoverAnimated:(BOOL)animated;

@end


//------------------------------------------------------------------------------
#pragma mark - Class Methods
//------------------------------------------------------------------------------


@implementation YSImagePickerEditor
@synthesize barButton,popoverController,delegate;


-(void)presentImagePickerPopoverOverButton:(UIBarButtonItem*)button withSize:(CGSize)size;
{
    self.barButton = button;
    popoverSize = size;
    [self presentImagePicker];
}

-(void)dismissPopoverAnimated:(BOOL)animated
{
    self.popoverController.delegate = nil;
    [self.popoverController dismissPopoverAnimated:animated];
    self.popoverController = nil;
}

-(BOOL)isPopoverVisible
{
    return [self.popoverController isPopoverVisible];
}

//------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------



-(void)presentImagePicker
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[[UIImagePickerController alloc] init] autorelease];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        //imagePicker.contentSizeForViewInPopover = popoverSize;
        self.popoverController = [[[UIPopoverController alloc]
                                   initWithContentViewController:imagePicker] autorelease];
        [self.popoverController 
         presentPopoverFromBarButtonItem:self.barButton
         permittedArrowDirections:UIPopoverArrowDirectionUp
         animated:YES];
    }
}

-(void)presentPopoverImageCropWithImage:(UIImage*)image
{
    [self dismissPopoverAnimated:FALSE];
    YSImageCrop * imageCrop = [[[YSImageCrop alloc] initWithImage:image andSize:CGSizeMake(popoverSize.width, popoverSize.height)] autorelease];
    imageCrop.delegate =self;
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:imageCrop] autorelease];     
    self.popoverController.delegate = self;
    
    self.popoverController = [[[UIPopoverController alloc]
                               initWithContentViewController:navigationController] autorelease];
    
    [self.popoverController 
     presentPopoverFromBarButtonItem:self.barButton
     permittedArrowDirections:UIPopoverArrowDirectionUp
     animated:YES];
}

//-------------------------------------------------------------------------------------
#pragma mark - Popover Delegate
//-------------------------------------------------------------------------------------

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popoverController.delegate =nil;
    [self.delegate YSImagePickerDismissed];
}

//-------------------------------------------------------------------------------------
#pragma mark - YSImageCrop Delegate
//-------------------------------------------------------------------------------------

-(void)YSImageCropDidFinishEditingWithImage:(UIImage*)image
{
    [self.delegate YSImagePickerDoneEditWithImage:image];
}

//------------------------------------------------------------------------------
#pragma mark - ImagePicker Delegate
//------------------------------------------------------------------------------


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [self presentPopoverImageCropWithImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    [self.delegate YSImagePickerFailedWithError:error];
}


//------------------------------------------------------------------------------
#pragma mark - Super Methods
//------------------------------------------------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.barButton = nil;
    self.popoverController = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
