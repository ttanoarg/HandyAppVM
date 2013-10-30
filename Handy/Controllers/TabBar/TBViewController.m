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
    for (int i=0; i < self.tabController.tabBar.items.count;i++) 
    {
        
        UITabBarItem* item = [self.tabController.tabBar.items objectAtIndex:i];
        
        switch (i)
        {
            case 0:
                
                //Controlamos el idioma
                item.title = [TranslatorManager languageSelectedStringForKey:@"Stands"];
                
                /*
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x97d60e),UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                */
                break;
            case 1:
                
                //Controlamos el idioma
                item.title = [TranslatorManager languageSelectedStringForKey:@"Calendar"];
                
                /*
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x97d60e),UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                */
                break;
            case 2:
                
                //Controlamos el idioma
                item.title = [TranslatorManager languageSelectedStringForKey:@"Location"];
                
                /*
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x97d60e),UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                 */
                break;
                
            case 3:
                
                //Controlamos el idioma
                item.title = [TranslatorManager languageSelectedStringForKey:@"Configuration"];
                
                /*
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
                [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x97d60e),UITextAttributeTextColor,nil] forState:UIControlStateSelected];
                 */
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
