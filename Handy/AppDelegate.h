#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "MenuViewController.h"
#import "SplashVC.h"

@class PreferencesViewController;
@class TBViewController;
@class ListScaneroViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,LoginProtocol,MenuProtocol,ZBarReaderDelegate>
{
    IBOutlet UIWindow *window;
    LoginViewController *loginVC;
    SplashVC *sVC;
    PreferencesViewController *pvController;
    TBViewController *tabBarVC;
    MenuViewController *menuVC;
    NSTimer *timer;
    ListScaneroViewController *LSVC;
    ZBarReaderViewController *reader;
    BOOL viewExist;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) PreferencesViewController *pvController;

-(void) LoginPerformed;
-(void) optionSelected:(int) optionNumber;
-(void) returnMenu;
-(void)timerCall;

@end
