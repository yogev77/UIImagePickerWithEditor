//
//  YSImageCrop.m
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/7/11.
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
//

#import "YSImageCrop.h"


//------------------------------------------------------------------------------
#pragma mark - Private Interface
//------------------------------------------------------------------------------

@interface YSImageCrop()
-(void)setupView;
@end


//------------------------------------------------------------------------------
#pragma mark - Class Methods
//------------------------------------------------------------------------------

@implementation YSImageCrop
@synthesize imageSource = _imageSource;
@synthesize scrollView = _scrollView;
@synthesize delegate;

-(id)initWithImage:(UIImage*)image andSize:(CGSize)popoverSize;
{
    self= [super init];
    if(self)
    {
        size = popoverSize;
        self.imageSource = image;
    }
    return self;
}

-(void)setupView
{
    //setup scrollview
    self.view.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    self.contentSizeForViewInPopover = size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
        
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Ok" style:UIBarButtonItemStyleBordered target:self action:@selector(doneEditing)];
    
    self.navigationItem.title = @"Crop Image";
    
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
    
    [okButton release];

    //The following piece of code makes images fit inside the scrollview
    //by either their width or height, depending on which is smaller.
    //I.e, portrait images will fit horizontally in the scrollview,
    //allowing user to scroll vertically, while landscape images will fit vertically,
    //allowing user to scroll horizontally. 
    CGFloat imageWidth = CGImageGetWidth(_imageSource.CGImage);
    CGFloat imageHeight = CGImageGetHeight(_imageSource.CGImage);
    
    int scrollWidth = _scrollView.frame.size.width;
    int scrollHeight = _scrollView.frame.size.height;
    
    //Limit by width or height, depending on which is smaller in relation to
    //the scrollview dimension.
    float scaleX = scrollWidth / imageWidth;
    float scaleY = scrollHeight / imageHeight;
    float scaleScroll =  (scaleX < scaleY ? scaleY : scaleX);
    
    _scrollView.bounds = CGRectMake(0, 0,imageWidth , imageHeight );
    _scrollView.frame = CGRectMake(0, 0, scrollWidth, scrollHeight);
    
    imageView = [[UIImageView alloc] initWithImage: _imageSource ];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = TRUE;
    _scrollView.contentSize = _imageSource.size;
    _scrollView.pagingEnabled = NO;
    _scrollView.maximumZoomScale = scaleScroll*3;
    _scrollView.minimumZoomScale = scaleScroll;
    _scrollView.zoomScale = scaleScroll;
    
    [_scrollView addSubview:imageView];
    [imageView release];
}

//------------------------------------------------------------------------------
#pragma mark - Private Methods
//------------------------------------------------------------------------------

UIImage* imageFromView(UIImage* srcImage, CGRect* rect)
{
    CGImageRef cr = CGImageCreateWithImageInRect(srcImage.CGImage, *rect);
    UIImage* cropped = [UIImage imageWithCGImage:cr];
    
    CGImageRelease(cr);
    return cropped;
}


-(void)doneEditing
{
    //Calculate the required area from the scrollview
    CGRect visibleRect;
    float scale = 1.0f/_scrollView.zoomScale;
    visibleRect.origin.x = _scrollView.contentOffset.x * scale;
    visibleRect.origin.y = _scrollView.contentOffset.y * scale;
    visibleRect.size.width = _scrollView.bounds.size.width * scale;
    visibleRect.size.height = _scrollView.bounds.size.height * scale;
    
    [self.delegate YSImageCropDidFinishEditingWithImage: imageFromView(imageView.image, &visibleRect)];    
}

//------------------------------------------------------------------------------
#pragma mark - ScrollView Delegate
//------------------------------------------------------------------------------

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
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
    self.scrollView = nil;
    self.imageSource = nil;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}


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
