#import "LoginViewController.h"
#import "MenuViewController.h"
#import "DB.h"
#import "User.h"
#import "TBViewController.h"
#import "TVOutManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize textFieldPass;


//Método que se lanza cuando se esconde el teclado. Inicializa el textField para que lo rellenemos y escribamos un nuevo codigo para dar de alta. MÉTODO DE PRUEBA PARA DAR ALTAS (BORRAR DESPUÉS)
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return true;
      
}
 
//Método para variar la animación
- (void) changeStateAnimation:(BOOL) state
{
    
    if (state)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        textFieldPruebaAlta.frame = CGRectMake(107, 34, textFieldPruebaAlta.frame.size.width, textFieldPruebaAlta.frame.size.height);
        buttonAddUser.frame = CGRectMake(268, 36, buttonAddUser.frame.size.width, buttonAddUser.frame.size.height);
        buttonCancelInsert.frame = CGRectMake(73, 35, buttonCancelInsert.frame.size.width, buttonCancelInsert.frame.size.height);
        [UIView commitAnimations]; 
        edit = true;
        [textFieldPass resignFirstResponder];
        textFieldPass.text = @"";
        [textFieldPruebaAlta becomeFirstResponder];
    }
    
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        textFieldPruebaAlta.frame = CGRectMake(79, 409, textFieldPruebaAlta.frame.size.width, textFieldPruebaAlta.frame.size.height);
        buttonAddUser.frame = CGRectMake(240, 411, buttonAddUser.frame.size.width, buttonAddUser.frame.size.height);
        buttonCancelInsert.frame = CGRectMake(79, 409, buttonCancelInsert.frame.size.width, buttonCancelInsert.frame.size.height);
        [UIView commitAnimations];
        edit = false;
        [textFieldPass becomeFirstResponder];
        [textFieldPruebaAlta resignFirstResponder];
        textFieldPruebaAlta.text = @"";
    }
     
}


//Método que se ejecutará cada vez que pulsemos un dígito del teclado
//Llamaremos al método searchUser que comprobará si el pin es correcto en caso de completar todos los dígitos
//Controlaremos también el borrado de dígitos
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //Si se trata de textField Prueba alta aceptamos todo
    if (textField == textFieldPruebaAlta)
    {
        return true;
    }
    
    //En caso de introducir más de 9 dígitos nos salimos
    if ([newText length]  > 9)
    {
        return false;
    }
    
    //En caso de que se introduzca algo no numérico nos salimos
    if ([newText length]  > 9)
    {
    
        char c = [newText characterAtIndex:[newText length]-1];
        
        if (c < '0' || c > '9')
        {
            return false;
        }
    }
    
    
    //Determinar si se ha pulsado la tecla de borrar
    bool backspacePressed = (newText.length < textField.text.length);
       
    //Actualizamos el dígito correspondiente

        switch (cont)
        {
            case 0:
                if (backspacePressed) 
                {
                    digit1.text =@"";
                }
                else
                {
                    digit1.text = @".";
                }
                break;
            case 1:
                if (backspacePressed) 
                {
                    digit1.text =@"";
                }
                else
                {
                    digit2.text = @".";
                }
                break;
            case 2:
                if (backspacePressed) 
                {
                    digit2.text =@"";
                }
                else
                {
                    digit3.text = @".";
                }
                break;
            case 3:
                if (backspacePressed) 
                {
                    digit3.text =@"";
                }
                else
                {
                    digit4.text = @".";
                }
                break;
            case 4:
                if (backspacePressed) 
                {
                    digit4.text =@"";
                }
                else
                {
                    digit5.text = @".";
                }
                break;
            case 5:
                if (backspacePressed) 
                {
                    digit5.text =@"";
                }
                else
                {
                    digit6.text = @".";
                }
                break;
            case 6:
                if (backspacePressed) 
                {
                    digit6.text =@"";
                }
                else
                {
                    digit7.text = @".";
                }
                break;
            case 7:
                if (backspacePressed) 
                {
                    digit7.text =@"";
                }
                else
                {
                    digit8.text = @".";
                    
                }
                break;        
    
    }
    //En caso de que se haya pulsado borrar ejecutamos el siguiente bloque
    if (backspacePressed)
    {
        miPasswd=[miPasswd substringToIndex:[miPasswd length]-1]; 
        cont--;
        
    }
    //En caso contrario
    else 
    {
        miPasswd=[NSString stringWithFormat:@"%@%@", miPasswd, string];
        cont++;
        
    }

    //Si hemos terminado, comprobamos si existe el usuario
    if (cont == 8) 
    {
        [self searchUser:miPasswd];
        
    }
    
    return true;
    
}

//Método para comprobar si el pin es correcto
//Todos los códigos recuperados de la BD tendrán que ser decodificados previamente
//Si el código es válido se cargará el menu principal desde el RootViewController (AppDelegate)
- (void) searchUser:(NSString *)passwd
{
    
    
    textFieldPass.text = @"";
    textFieldPruebaAlta.text = @"";
    cont=0;
    miPasswd=@"";
    digit1.text = @"";
    digit2.text = @"";
    digit3.text = @"";
    digit4.text = @"";
    digit5.text = @"";
    digit6.text = @"";
    digit7.text = @"";
    digit8.text = @"";
    
    //Obtenemos todos los usuarios
    NSArray *allUsers =[[DB getInstance] allUsersBD];
    bool found = false;
    
    
    //Comprobamos si el pin es correcto
    for (User *u in allUsers)
    {
        NSLog(@"%@",u.pass);
        
        
        if ([u.pass isEqualToString:passwd])
        {
            found = true;
        }
        
    }
    
    //PRUEBAA
    found = true;
    
    if (found == false)
    {
        alertTitle = [TranslatorManager languageSelectedStringForKey:@"Info"];
        alertMessage = [TranslatorManager languageSelectedStringForKey:@"Invalid pin code"];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else
    {
        //Si el pin es correcto lanzamos el evento
        [textFieldPass resignFirstResponder];
        [myLoginDelegate LoginPerformed];
        
    }
   
}


//Constructor (redefinido con la actuación del delegado)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<LoginProtocol>) delegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    
    myLoginDelegate = delegate;
    
    return self;
}

//Método que se ejecuta cada vez que cargamos el controlador. Inicializaremos todo lo necesario
-(void) viewWillAppear:(BOOL)animated
{ 
    
    //Llamamos a la función que traducirá
    [self translator];
    
    //Inicalizamos el contador para el teclado y sacamos el teclado de forma automática
    digit1.text = @"";
    digit2.text = @"";
    digit3.text = @"";
    digit4.text = @"";
    digit5.text = @"";
    digit6.text = @"";
    digit7.text = @"";
    digit8.text = @"";
    miPasswd    = @"";
    cont =0;
    textFieldPass.delegate = self;
    textFieldPruebaAlta.delegate = self;
    [textFieldPass becomeFirstResponder];
            
}

//Método que recoge las etiquetas definidas para realizar el cambio de idioma. Para ello utilizamos el módulo TranslatorManager
//Método que recoge las etiquetas definidas para realizar el cambio de idioma. Para ello utilizamos el módulo TranslatorManager
-(void) translator
{
    labelPinCode.text = [TranslatorManager languageSelectedStringForKey:@"Pin code"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self changeStateAnimation:false];
    
    self.textFieldPass.delegate = self;

    //Forzamos el teclado
    [textFieldPass becomeFirstResponder];
    
    //Damos de alta el pin 11111111 para las pruebas
    NSMutableArray *allUsers = [[NSMutableArray alloc] init];
    allUsers = [[DB getInstance] allUsers];
    
    if ([allUsers count] == 0)
    {
        User *u = [[User alloc] init];
        
        //Usuario por defecto (demo)
        u.pass = @"11111111";
        
        [[DB getInstance] insertUserBD:u];
        
    }
    
    
}

- (void)viewDidUnload
{

    [self setTextFieldPass:nil];
    labelPinCode = nil;
    buttonAddUser = nil;
    digit1 = nil;
    digit2 = nil;
    digit3 = nil;
    digit4 = nil;
    digit5 = nil;
    digit6 = nil;
    digit7 = nil;
    digit8 = nil;
    textFieldPruebaAlta = nil;
    buttonCancelInsert = nil;
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Método Provisional
- (IBAction)ButtonAddUser:(id)sender
{
    edit = true;
    
    User *u = [[User alloc] init];

    u.pass = textFieldPruebaAlta.text;
    
    [[DB getInstance] insertUserBD:u];
    
    [self changeStateAnimation:false];  
}

//Metodo provisional para cancelar la insercción
- (IBAction)buttonCancelInsert:(id)sender
{
    [self changeStateAnimation:false];
    
    digit1.text = @"";
    digit2.text = @"";
    digit3.text = @"";
    digit4.text = @"";
    digit5.text = @"";
    digit6.text = @"";
    digit7.text = @"";
    digit8.text = @"";
    miPasswd    = @"";
    cont =0;

    
   // [textFieldPass becomeFirstResponder];

}


//Método donde escondemos el teclado (provisional para las altas ya que será fijo)
- (IBAction)buttonHideKeyboard:(id)sender 
{
    [self changeStateAnimation:true];
}

//Método que se lanza cuando pulsamos la tecla de borrado. Eliminará 1 dígito por cada pulsación
- (IBAction)buttonDeleteText:(id)sender 
{
    textFieldPass.text = @"";
}

@end
