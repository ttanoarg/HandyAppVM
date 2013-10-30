#import "ListScaneoCell.h"

@interface ListScaneoCell ()

@end

@implementation ListScaneoCell

//Delegados utilizados para el teclado
-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return true;
    
}
-(void) textFieldDidBeginEditing:(UITextField *)textFieldView
{
    //NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:myCellNumber inSection:0];
    //[myTV scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


- (id) initWithDelegate:(id<TableQRCellProtocol>)delegate cellNumber:(int)cellNumber imageQR:(UIImage*)imQR textQR:(UILabel*)textQR
{
    myRecibeLabel = textQR;
    myRecobeImage = imQR;
    self = [self initWithNibName:@"ListScaneoCell" bundle:nil];
    myCellNumber = cellNumber;
    pedidoDelegate = delegate;
    
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [myQRImage setImage:myRecobeImage];
    [labelQR setText:myRecibeLabel.text];
    //rellenar elementos a partir del objeto recibido en elconstructor...
}

-(void) viewWillAppear:(BOOL)animated
{
    textCantidad.delegate = self;
    
    UIImage* image3 = [UIImage imageNamed:@"volver.png"];
    CGRect frameimg = CGRectMake(0, 0, image3.size.width-30, image3.size.height-22);
    
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=mailbutton;
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidUnload
{
    textCantidad = nil;
    [self setButtonHiddenKeyboard:nil];
    myQRImage = nil;
    labelQR = nil;
    [super viewDidUnload];
}

- (IBAction)buttonHidden:(id)sender
{
    [textCantidad resignFirstResponder];
}
- (IBAction)buttonCesta:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Información" message:@"Se ha añadido el producto escaneado a la cesta" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)buttonSelectPedido:(id)sender
{
    [pedidoDelegate cellPush:myCellNumber];
    
}
@end


