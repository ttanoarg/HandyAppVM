#import <Foundation/Foundation.h>


//Definición de los atributos para los usuarios. Los datos tienen una correspondencia directa con las tuplas creadas en la tabla user de la BD
@interface User : NSObject
{
    //Corresponde con el id de la tabla user (clave primaria)
    NSInteger code;
    
    //Atributo que hace referencia al pin que introduce el usuario
    NSString *nameUser;
    
    //Atributo que hace referencia al pass que introduce el usuario
    NSString *pass;
    
    //Atributo que hace referencia al código de barras del e-show
    NSString *eshow;
}

@property (nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *nameUser;
@property (nonatomic,strong) NSString *pass;
@property (nonatomic,strong) NSString *eshow;

@end