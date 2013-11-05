//
//  CalendarViewController.h
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
// prueba

#import <UIKit/UIKit.h>
@class ZBarReaderViewController;
@class EshowViewController;

@interface CalendarViewController : UIViewController
{
    bool recomendacion;
    ZBarReaderViewController *reader;
    EshowViewController *eVC;
}

@property (weak, nonatomic) IBOutlet UIImageView *ImageViewContenedorReborde;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewContenedor;
@end
