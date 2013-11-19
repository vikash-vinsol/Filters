//
//  MainViewController.m
//  Filters
//
//  Created by Vikash Soni on 19/11/13.
//  Copyright (c) 2013 Vikash Soni. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadImageAction:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Image Picker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image= image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveImageAction:(id)sender
{
    UIGraphicsBeginImageContextWithOptions(_imageView.bounds.size, NO,0.0);
    [_imageView.image drawInRect:CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
            [alert show];
            
    }
    else
    {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in Photo Album."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
            [alert show];
    }
}

#pragma mark - Filter Action

- (IBAction)filterOneAction:(id)sender
{
    CIImage *beginImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    self.imageView.image = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
}

- (IBAction)filterTwoAction:(id)sender
{
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIFilter *exposureAdjustFilter = [CIFilter filterWithName:@"CIExposureAdjust"];
    [exposureAdjustFilter setDefaults];
    [exposureAdjustFilter setValue: inputImage forKey: @"inputImage"];
    [exposureAdjustFilter setValue:[NSNumber numberWithFloat: 5.0f] forKey:@"inputEV"];
    CIImage *outputImage = [exposureAdjustFilter valueForKey: @"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    self.imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)filterThreeAction:(id)sender
{
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIFilter *highlightShadowAdjustFilter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
    [highlightShadowAdjustFilter setDefaults];
    [highlightShadowAdjustFilter setValue: inputImage forKey: @"inputImage"];
    [highlightShadowAdjustFilter setValue:[NSNumber numberWithFloat: 6.0f] forKey:@"inputShadowAmount"];
    CIImage *outputImage = [highlightShadowAdjustFilter valueForKey: @"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    _imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)filterFourAction:(id)sender
{
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIFilter *invertFilter = [CIFilter filterWithName:@"CIColorInvert"];
    [invertFilter setDefaults];
    [invertFilter setValue: inputImage forKey: @"inputImage"];
    CIImage *outputImage = [invertFilter valueForKey: @"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    _imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)filterFiveAction:(id)sender
{
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIFilter *hueFilter = [CIFilter filterWithName:@"CIHueAdjust"];
    [hueFilter setDefaults];
    [hueFilter setValue: inputImage forKey: @"inputImage"];
    [hueFilter setValue: [NSNumber numberWithFloat: 1.0f] forKey: @"inputAngle"];
    CIImage *outputImage = [hueFilter valueForKey: @"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    _imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

- (IBAction)filterSixAction:(id)sender
{
    CIImage *inputImage = [CIImage imageWithData: UIImagePNGRepresentation(self.imageView.image)];
    CIFilter *brightnesContrastFilter = [CIFilter filterWithName:@"CIColorControls"];
    [brightnesContrastFilter setDefaults];
    [brightnesContrastFilter setValue: inputImage forKey: @"inputImage"];
    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:0.5f] forKey:@"inputBrightness"];
    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:6.0f] forKey:@"inputContrast"];
    CIImage *outputImage = [brightnesContrastFilter valueForKey: @"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    _imageView.image = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
}

@end
