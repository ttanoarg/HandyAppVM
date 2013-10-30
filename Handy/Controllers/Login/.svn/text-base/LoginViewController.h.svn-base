#import <UIKit/UIKit.h>
#import "TranslatorManager.h"


@class MenuViewController;
@class CustomNavigationBar;
@class NavigationController;


//Creamos un protoco. Se ejecutará en caso que el usuario se haya autenticado correctamente (pin correcto)
@protocol LoginProtocol <NSObject>

-(void) LoginPerformed;  //El delegado se ejecutará en el RootViewController (AppDelegate)
 
@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
     MenuViewController *menuVC;                   //Definido para cargar el menu principal
    
    //TEMPORAL PARA DAR ALTAS Y CAMBIO DE IDIOMA
    __weak IBOutlet UILabel *labelPinCode;        

    __weak IBOutlet UIButton *buttonAddUser;          
    __weak IBOutlet UIButton *buttonCancelInsert; 
  
     bool edit;                                   //TEMPORAL PARA CONTROLAR TECLADO EN LA EDICIÓN (BORRARLO LUEGO
    
    
    NSString *alertTitle;
    NSString *alertMessage; 
    
    
    //Definimos cada uno de los dígitos de nuestro teclado
    __weak IBOutlet UILabel *digit1;
    __weak IBOutlet UILabel *digit2;
    __weak IBOutlet UILabel *digit3;
    __weak IBOutlet UILabel *digit4;
    __weak IBOutlet UILabel *digit5;
    __weak IBOutlet UILabel *digit6;
    __weak IBOutlet UILabel *digit7;
    __weak IBOutlet UILabel *digit8;
    
    //Contador empleado en el teclado automático creado
    int cont;
    
    //TEMPORAL PARA DAR ALTAS
    __weak IBOutlet UITextField *textFieldPruebaAlta;
    
    //Definimos el campo donde guardaremos el Pin
    NSString *miPasswd;
    //Definición del delegado
    id<LoginProtocol> myLoginDelegate;
}


@property (weak, nonatomic) IBOutlet UITextField *textFieldPass;

//Empleado para borrar dígitos
- (IBAction)buttonDeleteText:(id)sender;

//Método provisional para la insercción
- (IBAction)ButtonAddUser:(id)sender;
- (IBAction)buttonCancelInsert:(id)sender;
- (void) searchUser:(NSString *)passwd;

//Método para variar la animación
- (void) changeStateAnimation:(BOOL) state;


//Redefinicón del constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<LoginProtocol>) delegate;

@end
