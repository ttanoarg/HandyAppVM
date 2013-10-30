#import <UIKit/UIKit.h>


//Definimos un delegado para volver a al controlador principal
@protocol TableQRCellProtocol <NSObject>

- (void)cellPush:(int)cellNumber;

@end


@interface ListScaneoCell : UIViewController<UITextFieldDelegate>
{
    //Definicion de la variable para el delegado
    id<TableQRCellProtocol> pedidoDelegate;
    
    int myCellNumber;
    int count;
    __unsafe_unretained IBOutlet UITextField *textCantidad;
    
    __unsafe_unretained IBOutlet UIImageView *myQRImage;
    __unsafe_unretained IBOutlet UILabel *labelQR;
    
    UILabel *myRecibeLabel;
    UIImage *myRecobeImage;
}
- (IBAction)buttonCesta:(id)sender;
- (IBAction)buttonSelectPedido:(id)sender;

@property (nonatomic,strong) NSMutableArray *PedidoElements;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *buttonHiddenKeyboard;
- (IBAction)buttonHidden:(id)sender;

//Redefinición del constructor
- (id) initWithDelegate:(id<TableQRCellProtocol>)delegate cellNumber:(int)cellNumber imageQR:(UIImage*)imQR textQR:(UILabel*)textQR;


@end
