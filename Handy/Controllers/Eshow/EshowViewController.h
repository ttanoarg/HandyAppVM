//
//  EshowViewController.h
//  Handy
//
//  Created by Fernando Pabón on 29/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface EshowViewController : UIViewController<MenuProtocol>
{
    MenuViewController *mVC;
    
}
- (IBAction)buttonReturn:(id)sender;

@end
