//
//  LocationViewController.h
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBViewController;
@class PabellonesViewController;
@class SalidasEmergenciaViewController;
@class ItinerarioViewController;
@class PuntoInformacionViewController;
@class EshowViewController;
@class ZBarReaderViewController;

@interface LocationViewController : UIViewController
{
    PabellonesViewController *pVC;
    SalidasEmergenciaViewController *seVC;
    ItinerarioViewController *iVC;
    PuntoInformacionViewController *piVCM;
    EshowViewController *eVC;
    ZBarReaderViewController *reader;
}


- (IBAction)buttonPabellones:(id)sender;
- (IBAction)buttonEmergencias:(id)sender;
- (IBAction)buttonPuntosInformacion:(id)sender;
- (IBAction)buttonPlanItinerario:(id)sender;
@end
