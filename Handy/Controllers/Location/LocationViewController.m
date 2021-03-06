//
//  LocationViewController.m
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import "LocationViewController.h"
#import "PabellonesViewController.h"
#import "SalidasEmergenciaViewController.h"
#import "ItinerarioViewController.h"
#import "ProgramacionEventosViewController.h"
#import "ZBarReaderViewController.h"
#import "EshowViewController.h"
@interface LocationViewController ()

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Barra-Header-With-Icon.png"]];

   eVC = [[EshowViewController alloc] init];
    
    [navBar setBackgroundImage:myImage.image forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    navBar.translucent = NO;
    [navBar setTintColor:[UIColor whiteColor]];
    //Creamos un boton para QR
    UIImage* botImage = [UIImage imageNamed:@"Icono-QR"];
    CGRect frameimg = CGRectMake(0, 0, botImage.size.width*0.5, botImage.size.height*0.5);
    
    //Creamos un boton para e-Show
    UIImage* botImage2 = [UIImage imageNamed:@"Icono-Tarjeta.png"];
    CGRect frameimg2 = CGRectMake(0, 0, botImage2.size.width*0.5, botImage2.size.height*0.5);
    
    //Creamos un boton para QR
    UIButton *barB = [[UIButton alloc] initWithFrame:frameimg];
    [barB setBackgroundImage:botImage forState:UIControlStateNormal];
    [barB addTarget:self action:@selector(buttonQR) forControlEvents:UIControlEventTouchUpInside];
    [barB setShowsTouchWhenHighlighted:YES];
    
    //Creamos un boton para e-Show
    UIButton *barB2 = [[UIButton alloc] initWithFrame:frameimg2];
    [barB2 setBackgroundImage:botImage2 forState:UIControlStateNormal];
    [barB2 addTarget:self action:@selector(buttoneShow) forControlEvents:UIControlEventTouchUpInside];
    [barB2 setShowsTouchWhenHighlighted:YES];
    
    
    UIBarButtonItem *mailbutton1 =[[UIBarButtonItem alloc] initWithCustomView:barB];
    self.navigationItem.rightBarButtonItem=mailbutton1;
    
    
    UIBarButtonItem *mailbutton2 =[[UIBarButtonItem alloc] initWithCustomView:barB2];
    self.navigationItem.leftBarButtonItem=mailbutton2;
}


- (IBAction)buttoneShow
{
//    [UIView beginAnimations:@"View Flip" context:nil];
//    [UIView setAnimationDuration:1.5];
//    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
//    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
//   // [UIView beginAnimations: nil context: nil];
//    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [self.navigationController pushViewController:eVC animated:YES];
   // [UIView commitAnimations];
    
}

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
    
}
- (IBAction)buttonQR
{
    // Leemos desde la cámara
    reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    //... (Podemos añadir más lectuas)
    
    // Rendimiento en el escaneo
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    [self.navigationController pushViewController:reader animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPabellones:(id)sender
{
    pVC = [[PabellonesViewController alloc] init];
    [self.navigationController pushViewController:pVC animated:YES];
}

- (IBAction)buttonEmergencias:(id)sender
{
    seVC = [[SalidasEmergenciaViewController alloc] init];
    [self.navigationController pushViewController:seVC animated:YES];
    
}


- (IBAction)buttonProgramacionEventos:(id)sender
{
    peVC = [[ProgramacionEventosViewController alloc] init];
    [self.navigationController pushViewController:peVC animated:YES];
}
@end
