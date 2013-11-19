//
//  MainViewController.h
//  Filters
//
//  Created by Vikash Soni on 19/11/13.
//  Copyright (c) 2013 Vikash Soni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)loadImageAction:(id)sender;
- (IBAction)saveImageAction:(id)sender;
- (IBAction)filterOneAction:(id)sender;
- (IBAction)filterTwoAction:(id)sender;
- (IBAction)filterThreeAction:(id)sender;
- (IBAction)filterFourAction:(id)sender;
- (IBAction)filterFiveAction:(id)sender;
- (IBAction)filterSixAction:(id)sender;


@end
