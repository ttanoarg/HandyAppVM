#import "ListScaneroViewController.h"
#import "ListScaneoCell.h"

@interface ListScaneroViewController ()

@end

@implementation ListScaneroViewController
@synthesize resultImage, resultText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    cellArray = [NSMutableArray arrayWithCapacity:10];
    return self;
}


-(void)back
{
    [miPedidoView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) viewWillAppear:(BOOL)animated
{
    
    // Leemos desde la cámara
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    //... (Podemos añadir más lectuas)
    
    // Rendimiento en el escaneo
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    //[self presentModalViewController: reader animated: YES];
    
    //[self presentViewController:reader animated:YES completion:nil];
    [self presentModalViewController:[[UINavigationController alloc] initWithRootViewController:reader] animated:YES];
    
    
    //Creamos nuestra barra y la personalizamos con una imágen de fondo
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImageView *myImBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Barra-navegacion.png"]];
    [navBar setBackgroundImage:myImBar.image forBarMetrics:UIBarMetricsDefault];
    
    UIImage* image3 = [UIImage imageNamed:@"volver.png"];
    CGRect frameimg = CGRectMake(0, 0, image3.size.width-30, image3.size.height-22);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=mailbutton;        
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    if (mylabelQRElements == nil) mylabelQRElements = [[NSMutableArray alloc] init];
    if (myimageQRElements == nil) myimageQRElements = [[NSMutableArray alloc] init];
    

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
    
    //Extraemos la información de la etiqueta QR
    resultText.text = symbol.data;
    
    //Extraemos la imagen
    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];

    
    [reader dismissModalViewControllerAnimated: YES];
    
    [myimageQRElements addObject:resultImage.image];
    [mylabelQRElements addObject:resultText];
    
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

//Personalizamos la alerta
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [myTableView reloadData];
    /*
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        NSLog(@"NUMERO DE IMAGENES %i", [myimageQRElements count]);
        NSLog(@"NUMERO DE LABELS %i", [mylabelQRElements count]);
        
        [myTableView reloadData];
    }
    //En el caso que deseemos volver a escanear un código
    else
    {
        resultText.text = nil;
        resultImage.image = nil;
                
        // Leemos desde la cámara
        ZBarReaderViewController *reader = [ZBarReaderViewController new];
        reader.readerDelegate = self;
        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        
        ZBarImageScanner *scanner = reader.scanner;
        //... (Podemos añadir más lectuas)
        
        // Rendimiento en el escaneo
        [scanner setSymbology: ZBAR_I25
                       config: ZBAR_CFG_ENABLE
                           to: 0];

        
        [self presentModalViewController: reader animated: YES];
    }
     */
}
- (void)viewDidUnload
{
    miPedidoView = nil;
    viewEuroVip = nil;
    viewEuroVip = nil;
    labelEuroVip = nil;
    labelCantidad = nil;
    myTableView = nil;
    [super viewDidUnload];
}

//Método donde indicamos el número de secciones de la tabla. En este caso sólo habrá 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Método que controla el número de celdas a pintar sobre la tabla. Corresponderá con el número de pedidos que tengamos
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myimageQRElements count];
    
}

//Método que se ejecuta cada vez que creamos una celda
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    NSString *simpleCellIdentifier = [NSString stringWithFormat:@"ListScaneoCell%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCellIdentifier];
    
    if (cell == nil)
    {
        
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCellIdentifier];
        
        
        if (indexPath.row >= [myimageQRElements count])
        {
            
            //Añadimos 2 celdas vacias
        }
        else
        {
            ListScaneoCell *customCell = [[ListScaneoCell alloc] initWithDelegate:self cellNumber:indexPath.row imageQR:[myimageQRElements objectAtIndex: indexPath.row]  textQR:[mylabelQRElements objectAtIndex: indexPath.row]];
            
            [cellArray addObject:customCell];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background-home.png"]];
            tableView.backgroundView = imageView;
            [cell addSubview:customCell.view];
        }
        
    }
    
    return cell;
}


- (void)cellPush:(int)cellNumber
{
    NSLog(@"Celda pulsada %d", cellNumber);
    [miPedidoView setFrame:CGRectMake(0, 63, 324, 370)];
    [self.view.window addSubview:miPedidoView];
    
}

- (IBAction)buttonAceptar:(id)sender
{
    [miPedidoView removeFromSuperview];
    
    
    [labelCantidad setFrame:CGRectMake(259,434, 40, 44)];
    labelCantidad.textColor = [UIColor redColor];
    [self.view.window addSubview:labelCantidad];
}



//Método donde indicamos la dimensión que tendrá la celda
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
