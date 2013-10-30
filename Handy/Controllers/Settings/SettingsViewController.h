//
//  SettingsViewController.h
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RegionViewController;
@class InfoViewController;
@class EshowViewController;
@class ZBarReaderViewController;

@interface SettingsViewController : UIViewController
{
    RegionViewController *rVC;
    InfoViewController *iVC;
    EshowViewController *eVC;
    ZBarReaderViewController *reader;
}

- (IBAction)buttonRegion:(id)sender;
- (IBAction)buttonInfo:(id)sender;
@end
