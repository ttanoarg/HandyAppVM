//
//  AppDelegate.m
//  Handy
//
//  Created by Fernando Pabón on 24/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import "AppDelegate.h"
#import "TBViewController.h"
#import "DB.h"
#import "LoginViewController.h"
#import "SplashVC.h"
#import "MenuViewController.h"
#import "TVOutManager.h"
#import "TranslatorManager.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize pvController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    viewExist = false;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    /* Descomentar el párrafo y comentar el siguiente para arrancar sin la salida de video
     
     //Cagarmos la pantalla de login
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil delegate:self];
     [self.window addSubview:loginVC.view];
     [self.window makeKeyAndVisible];
     */
    
    //Cargamos un Splash para la salida de Tv/Monitor y hacemos esperar unos segundos antes de cargar el loginViewController
    sVC = [[SplashVC alloc] initWithNibName:@"SplashVC" bundle:nil];
    [self.window addSubview:sVC.view];
    [self.window makeKeyAndVisible];
    
    //Activamos la salida de video para visualizar la aplicación en una pantalla/monitor
    [[TVOutManager sharedInstance] startTVOut];
    
    float t = 2.0;
    if (!timer)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:t target:self selector:@selector(timerCall) userInfo:nil repeats:NO];
    }
 
    
    return YES;
}

//Método que obtiene que lanza el splash pasados transcurrido dicho tiempo
-(void)timerCall
{
    [self.window removeFromSuperview];
    
    
    //Cagarmos la pantalla de login
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil delegate:self];
     
     
    [self.window addSubview:loginVC.view];
    [self.window makeKeyAndVisible];
}


-(void) LoginPerformed
{
    /*
    
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
    
    
    [loginVC presentViewController:reader animated:YES completion:nil];
    
    
    //Timer para mostrar el botón + etiqueta
    [NSTimer scheduledTimerWithTimeInterval:4.0
                                     target:self
                                   selector:@selector(removeImage:)
                                   userInfo:nil
                                    repeats:YES];

*/
    
    menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil delegate:self];
    [loginVC presentViewController:menuVC animated:YES completion:nil];
    
}


- (IBAction)removeImage:(id)sender
{
    UIView *subViewHandy;
    
    if (!viewExist)
    {
        CGRect frame = CGRectMake(20, 50, 230, 200);
        subViewHandy = [[UIView alloc] initWithFrame:frame];
        subViewHandy.backgroundColor = [UIColor clearColor];
    
        UIImageView *HandyView =[[UIImageView alloc] init];
        HandyView.frame = CGRectMake(20, 50, 230, 200);
        HandyView.image=[UIImage imageNamed:@"lecturaQR.jpeg"];
    
        [subViewHandy addSubview:HandyView];
    
        [reader.view addSubview:subViewHandy];
        viewExist = true;
    }
    else
    {
        [subViewHandy removeFromSuperview];
        
    }
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil delegate:self];
    [reader presentViewController:menuVC animated:YES completion:nil];
    
    
    
}

-(void)back
{
    menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil delegate:self];
    [loginVC presentViewController:menuVC animated:YES completion:nil];
    
}


-(void) optionSelected:(int) optionNumber
{
    // 1)Cargamos la barra
    tabBarVC = [[TBViewController alloc] initWithNibName:@"TBViewController" bundle:nil];
    
    [self.window addSubview:tabBarVC.view];
    
    //Seleccionamos el item por defecto
    
    [tabBarVC selectItem:optionNumber];
}


-(void) returnMenu
{
    //Para poder recuperar el menú principal
    [menuVC viewWillAppear:YES];
    [self.window bringSubviewToFront:menuVC.view];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [DB closeDB];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [DB closeDB];
    
    //Desactivamos la salida de video para visualizar la aplicación en una pantalla/monitor
    [[TVOutManager sharedInstance] stopTVOut];
}


@end
