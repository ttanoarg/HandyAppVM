#import <UIKit/UIKit.h>
#import "ListScaneoCell.h"
#import "ZBarSDK.h"

@class ListScaneroViewController;

@interface ListScaneroViewController : UIViewController<TableQRCellProtocol,ZBarReaderDelegate>
{
    __unsafe_unretained IBOutlet UITableView *myTableView;
    ListScaneroViewController *LSVC;
    NSMutableArray *cellArray;
    IBOutlet UIView *miPedidoView;
    IBOutlet UIView *viewEuroVip;
    __unsafe_unretained IBOutlet UILabel *labelEuroVip;
    __unsafe_unretained IBOutlet UILabel *labelCantidad;
 
    UILabel *qrLabel;
    UIImage *myImage;
    
    UIImageView *resultImage;
    UILabel *resultText;
    NSMutableArray *mylabelQRElements;
    NSMutableArray *myimageQRElements;

}

@property (retain, nonatomic) IBOutlet UIImageView *resultImage;
@property (retain, nonatomic) IBOutlet UILabel *resultText;

- (void)cellPush:(int)cellNumber;
- (IBAction)buttonAceptar:(id)sender;

//Redefinición del constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end
