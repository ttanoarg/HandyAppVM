#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@class SettingsViewController;
@class LogisticsViewController;
@class OperationalViewController;
@class SettingsViewController;
@class SynchronizationViewController;
@class EshowViewController;


@protocol MenuProtocol <NSObject>

-(void) optionSelected:(int) optionNumber;

@end

@interface MenuViewController : UIViewController<ZBarReaderDelegate>

{
    __weak IBOutlet UINavigationBar *myNavBar;
    EshowViewController *eVC;
    NSString *dateFormatting;
    NSString *hourFormatting;
    NSDate *date;
    NSDate *hour;
    NSInteger code;
    float lon;
    float lat;
    float alt;
    
    
    
    __weak IBOutlet UILabel *labeStands;

    __weak IBOutlet UILabel *labelCalendar;
    __weak IBOutlet UILabel *labelLocation;
    __weak IBOutlet UILabel *labelConfiguration;
    SettingsViewController *settingsVC;
    LogisticsViewController *logisticVC;
    OperationalViewController *operationalVC; 
    SynchronizationViewController *SynchronizationVC;
    id<MenuProtocol> myMenuDelegate;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<MenuProtocol>) delegate;


- (IBAction)buttonStands:(id)sender;
- (IBAction)buttonLocation:(id)sender;
- (IBAction)buttonCalendar:(id)sender;
- (IBAction)buttonConfiguration:(id)sender;

- (IBAction)buttonEshow:(id)sender;
- (IBAction)buttonQR:(id)sender;
@end
