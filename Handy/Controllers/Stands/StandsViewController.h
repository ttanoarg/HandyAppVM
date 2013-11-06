//
//  StandsViewController.h
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iCarouselViewController;
@class EshowViewController;
@class ZBarReaderViewController;

@interface StandsViewController : UIViewController
{
    iCarouselViewController *carrusel;
    EshowViewController *eVC;
    __weak IBOutlet UINavigationBar *myNavBar;
    ZBarReaderViewController *reader;
}

@property (strong, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)buttoneShow:(id)sender;
- (IBAction)buttonQR:(id)sender;
@end
