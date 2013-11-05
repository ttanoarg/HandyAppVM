#import "TBViewController.h"
#import "TranslatorManager.h"


//Para poder definir colores en RGB
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
 

@interface TBViewController ()

@end

@implementation TBViewController

@synthesize tabController;


//Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    
    return self;
}

//Método que llama a la función translator
-(void) viewWillAppear:(BOOL)animated
{
    
    [self translator];
        
}

//Método que recoge las etiquetas definidas para realizar el cambio de idioma y activa o desactiva los items de la barra. Para la traducción utilizamos el módulo TranslatorManager
//Además cambiamos el color de la fuente
-(void) translator
{
    //tabBackground = [[UIImage imageNamed:@"Tapbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 431, 320, 49)];
    
    /*
     //Colocamos la barra en la parte inferior
     Para Iphone 5
     UIImage *tabBackground = [[UIImage imageNamed:@"fondo_barra.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 519, 320, 49)];
     */
    
    [tabController.tabBar setBackgroundImage:tabBackground];
    
    
    for (int i=0; i < self.tabController.tabBar.items.count;i++) 
    {
        
        
        UITabBarItem* item = [self.tabController.tabBar.items objectAtIndex:i];
        
        //Inicalizamos las imagenes que pondremos de fondo en cada item
        UIImage *selectedContact = [[UIImage alloc] init];
        UIImage *unselectedContact = [[UIImage alloc] init];
        
        switch (i)
        {
            case 0:
                
                //Controlamos el idioma
                item.title = @"Stands";
                
                
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:32.0f/255.0f green:140.0f/255.0f blue:218.0f/255.0f alpha:1],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                
                
                //Establecemos la imagen de fondo del item
                selectedContact = [UIImage imageNamed:@"Stands-TB.png"];
                unselectedContact = [UIImage imageNamed:@"Stands-TB.png"];
                [item setFinishedSelectedImage:selectedContact withFinishedUnselectedImage:unselectedContact];
                
                break;
            case 1:
                
                //Controlamos el idioma
                item.title = @"Calendario";
                
                
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:32.0f/255.0f green:140.0f/255.0f blue:218.0f/255.0f alpha:1],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                
                
                //Establecemos la imagen de fondo del item
                selectedContact = [UIImage imageNamed:@"Calendario-TB.png"];
                unselectedContact = [UIImage imageNamed:@"Calendario-TB.png"];
                [item setFinishedSelectedImage:selectedContact withFinishedUnselectedImage:unselectedContact];
                break;
                
            case 2:
                
                //Controlamos el idioma
                item.title = @"Localización";
                
                
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:32.0f/255.0f green:140.0f/255.0f blue:218.0f/255.0f alpha:1],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                 
                
                //Establecemos la imagen de fondo del item
                selectedContact = [UIImage imageNamed:@"Localizacion-TB.png"];
                unselectedContact = [UIImage imageNamed:@"Localizacion-TB.png"];
                [item setFinishedSelectedImage:selectedContact withFinishedUnselectedImage:unselectedContact];
                
                break;
                
            case 3:
                
                //Controlamos el idioma
                item.title = @"Configuración";
                
                /*
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x97d60e),UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                 */
                
                //Establecemos la imagen de fondo del item
                selectedContact = [UIImage imageNamed:@"Configuracion-TB.png"];
                unselectedContact = [UIImage imageNamed:@"Configuracion-TB.png"];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:32.0f/255.0f green:140.0f/255.0f blue:218.0f/255.0f alpha:1],UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                [item setFinishedSelectedImage:selectedContact withFinishedUnselectedImage:unselectedContact];
                
                break;

        }
      
    }
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.view addSubview:tabController.view];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//Detectamos el elemento pulsado para marcarlo en la barra
-(void) selectItem:(int) itemNumber
{

    [tabController setSelectedIndex:itemNumber];
    
}


@end
