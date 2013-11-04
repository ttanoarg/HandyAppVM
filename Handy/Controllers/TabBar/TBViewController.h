#import <UIKit/UIKit.h>

//Controlador que contiene el TabBar con todos los items para navegar entre los diferentes menus
@interface TBViewController : UIViewController <UITabBarControllerDelegate> 
{
    UIButton *b; 
    UITabBarController *tabController;
    UIImage *tabBackground;
    
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabController;

//Método que selecciona la opción en función del item recibido (itemNumber)
-(void) selectItem:(int) itemNumber; 
//Método para traducir
-(void) translator;


@end
