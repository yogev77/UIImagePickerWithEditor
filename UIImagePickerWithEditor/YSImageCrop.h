//
//  YSImageCrop.h
//  UIImagePickerWithEditor
//
//  Created by yogev shelly on 9/7/11.
//  Copyright 2011 http://www.27dv.com All rights reserved.
//
//  The cropping methods were created based on Arjun  ImagePreview.h ImageCroppingExample 
//  from the 30/08/11 - https://github.com/ArjunNair/ImageCroppingExample - Thanks!
//  
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

#import <UIKit/UIKit.h>
#import "YSImageCropDelegate.h"

@interface YSImageCrop : UIViewController  <UIScrollViewDelegate>{
    
    UIScrollView * _scrollView;
    UIImage* _imageSource;
    UIImageView* imageView;
    id<YSImageCropDelegate> delegate;
    CGSize size;
}
@property(nonatomic,assign)   id<YSImageCropDelegate> delegate;
@property (nonatomic, retain) UIImage* imageSource;
@property (nonatomic, retain) UIScrollView* scrollView;

-(id)initWithImage:(UIImage*)image andSize:(CGSize)size;
@end
