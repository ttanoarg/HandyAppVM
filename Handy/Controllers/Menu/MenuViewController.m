#import "MenuViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SettingsViewCOntroller.h"
#import "TranslatorManager.h"
#import "ZBarReaderViewController.h"
#import "EshowViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<MenuProtocol>) delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    myMenuDelegate = delegate;    
    return self;
    
}

//Método que llama a la función translator
-(void) viewDidAppear:(BOOL)animated
{
    //[self translator];
    
    eVC = [[EshowViewController alloc] init];
    
    UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Barra-Header.png"]];
    
    [myNavBar setBackgroundImage:myImage.image forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    myNavBar.translucent = YES;
    
    [myNavBar setBackgroundImage:myImage.image forBarMetrics:UIBarMetricsDefault];
    
    
    /*
    Rafa método
     
    UIView *auxview = [[UIView alloc] initWithFrame:    CGRectMake(0, -20, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height + 20)
                       ];
    [auxview setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    
    [auxview setBackgroundColor:[UIColor colorWithRed:35.0f/255.0f green:137.0f/255.0f blue:212.0f/255.0f alpha:1.0f]];
    
    [self.navigationController.navigationBar setBackgroundImage:[self ChangeViewToImage:auxview] forBarMetrics:UIBarMetricsDefault];

    [myNavBar addSubview:auxview];
    
    */
                       
    
    /*
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImageView *myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Barra-Header.png"]];
    [navBar setBackgroundImage:myImage.image forBarMetrics:UIBarMetricsDefault];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    navBar.translucent = NO;
     */
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIImage *) ChangeViewToImage : (UIView *) view{
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (IBAction)buttonEshow:(id)sender
{
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
    //[UIView beginAnimations: nil context: nil];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
    [self presentModalViewController: eVC animated: NO];
    [UIView commitAnimations];
}

- (IBAction)buttonQR:(id)sender
{
    
}



//Método que recoge las etiquetas definidas para realizar el cambio de idioma. Para ello utilizamos el módulo TranslatorManager
-(void) translator
{
    //labelOperationalData.text = [TranslatorManager languageSelectedStringForKey:@"Operational data"];
    //labelLogisticData.text = [TranslatorManager languageSelectedStringForKey:@"Logistic data"];
    //labelMultimedia.text = [TranslatorManager languageSelectedStringForKey:@"Multimedia information"];
    //labelConfiguration.text = [TranslatorManager languageSelectedStringForKey:@"Configuration"];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)viewDidUnload
{
    labelConfiguration = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)buttonStands:(id)sender
{
    [myMenuDelegate optionSelected:0];
}

- (IBAction)buttonLocation:(id)sender
{
    [myMenuDelegate optionSelected:2];
}

- (IBAction)buttonCalendar:(id)sender
{
    [myMenuDelegate optionSelected:1];
}

- (IBAction)buttonConfiguration:(id)sender
{
    [myMenuDelegate optionSelected:3];
}


@end
