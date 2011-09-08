//
//  UIImagePickerWithEditorViewController.m
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImagePickerWithEditorViewController.h"
#import "YSImagePickerEditor.h"

//-------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
#pragma mark - UI Methods
//-------------------------------------------------------------------------------------

@implementation UIImagePickerWithEditorViewController
@synthesize imagePicker;

-(IBAction)chooseImage:(id)sender
{
    if([self.imagePicker isPopoverVisible])
    {
        [self.imagePicker dismissPopoverAnimated:YES];
        self.imagePicker =nil;
    }
    else
    {
        self.imagePicker = [[[YSImagePickerEditor alloc] init] autorelease];
        self.imagePicker.delegate = self;
        [self.imagePicker presentImagePickerPopoverOverButton:sender withSize:CGSizeMake(320, 220)];
    }
}

//-------------------------------------------------------------------------------------
#pragma mark - YSImagePickerEditor Delegate
//-------------------------------------------------------------------------------------

-(void)YSImagePickerFailedWithError:(NSError *)error
{
}


-(void)YSImagePickerDoneEditWithImage:(UIImage *)image
{
    imageView.image = image;
    self.imagePicker =nil;
}


//-------------------------------------------------------------------------------------
#pragma mark - Super Methods
//-------------------------------------------------------------------------------------


- (void)dealloc
{
    self.imagePicker = nil;
    [imageView release];
    [chooseImageButton release];
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
    return YES;
}

@end
