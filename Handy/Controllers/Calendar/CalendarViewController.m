//
//  CalendarViewController.m
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//
//fernando

#import "CalendarViewController.h"
#import "ZBarReaderViewController.h"
#import "EshowViewController.h"
@interface CalendarViewController ()

@end

@implementation CalendarViewController

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
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setBackgroundImage:myImage.image forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    navBar.translucent = NO;
    
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
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDuration:1.5];
//    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
//    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
//    //[UIView beginAnimations: nil context: nil];
//    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [self.navigationController pushViewController:eVC animated:YES];
    //[UIView commitAnimations];
   
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
    
    
    //[self.ImageViewContenedor setImage:[UIImage imageNamed:@"Banner-Publicidad.png"]];
    
  
    [self.ImageViewContenedorReborde setImage:[UIImage imageNamed:@"Contenedor-Recomendaciones.png"]];
    
    recomendacion = false;
    
    //Timer para mostrar el botón + etiqueta
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(changeRecomendacion:)
                                   userInfo:nil
                                    repeats:YES];
}

- (IBAction)changeRecomendacion:(id)sender
{
    if (recomendacion)
    {
        //Cargamos la recomendacion 1 por defecto (ensalada siciliana)
        [self.ImageViewContenedorReborde setImage:[UIImage imageNamed:@"Contenedor-Recomendaciones.png"]];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Banner-Publicidad-2.png"]];
        //[iv setFrame:CGRectMake(280, 110, 19, 262)];
        
        //[self.ImageViewContenedor setFrame:CGRectMake(14, 258, 296, 100)];
        [self.ImageViewContenedor setImage:iv.image];
        recomendacion = false;
    }
    else
    {
        //Cargamos la recomendacion 1 por defecto (ensalada siciliana)
        [self.ImageViewContenedorReborde setImage:[UIImage imageNamed:@"Contenedor-Recomendaciones-2.png"]];
        //UIImage *i = [UIImage imageNamed:@"sandwich_publi.png"];
        
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Banner-Publicidad.png"]];
        //[iv setFrame:CGRectMake(295, 99, 15, 260)];
        
        //[self.ImageViewContenedor setFrame:CGRectMake(19, 255, 287, 100)];
        [self.ImageViewContenedor setImage:iv.image];
        recomendacion = true;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
