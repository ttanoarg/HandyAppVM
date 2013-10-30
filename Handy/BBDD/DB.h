#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "sqlite3.h"


@class User;


/*
 Singleton para la BD de nuestra aplicación
*/
@interface DB : NSObject
{
    NSString        *BDPath;  //Contiene la ruta al fichero sqllite 
    sqlite3         *HandyDB; //Contendrá el fichero sqllite con nuestra BD
    bool            open;     //Controlamos la apertura de la BD+
}

//Definimos los arrays que contendran cada uno de los elementos de nuestra BD
@property (nonatomic,strong) NSMutableArray *allUsers;

//Método que hacen referencia a las consultas que haremos sobre nuestra BD y creación del Singleton
+(DB *) getInstance;
-(void) openDB;
-(void) closeDB;
+(void) closeDB;
-(void) insertUserBD: (User*) user;
-(NSMutableArray*) allUsersBD;
-(void) deleteUsers;
@end

