#import "DB.h"
#import "User.h"

//Definimos 3 constantes para hacerlo más flexible. Hacen referencia al fichero de la BD
#define name @"handy_DB"
#define type @"sqlite" 
#define fullName @"handy_DB.sqlite"


//VBLE SINGLETON
static DB *instanceDB = nil;

@interface DB (private)

//Método para abrir la BD
-(void) openDB;

@end

@implementation DB

@synthesize allUsers;


//Inicialización (nos aseguramos que la BD este cerrada)
-(DB *) init
{
    open = false;
    
    return [super init];

}


//Método empleado para inicializar el Singleton
+(DB *) getInstance
{
    //Inicialzamos el singleton
    if (instanceDB == nil)
    {
        instanceDB = [[DB alloc]init];
        
    }
    
    return instanceDB;
}

//Método empleado para abrir la BD
-(void) openDB
{
    if (open) return; //Si esta abierto no hacemos nada
    
    NSString *sourcePath= [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    BDPath = [documentsDirectory stringByAppendingPathComponent:fullName];
    
    NSError *error;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: BDPath ] == NO)
    {
        
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath 
                                                toPath:BDPath
                                                 error:&error];
    }
    
    const char *dbpath = [BDPath UTF8String];
    
    if (sqlite3_open(dbpath, &HandyDB) == SQLITE_OK)
    {
        
        NSLog(@"BD Abierta");
        sqlite3_close(HandyDB);
        
    } else 
    {
        NSLog(@"Fallo abriendo/creando la BD");
    }    
    
}

//Métodos empleados para cerrar la BD (de instancia y de clase). El motivo es que accedemos desde también (AppDelegate). De esta forma controlamos el cierre de forma más optima
-(void) closeDB
{
    open = false;
    sqlite3_close(HandyDB);
    
}
+(void) closeDB
{
    if (instanceDB!=nil) [instanceDB closeDB];
    
}

//Método empleado para insertar los elementos que hemos sincronizado (fotos, pdf...)
-(void) insertUserBD: (User*) user;
{
    [self openDB];
    
    const char *dbpath = [BDPath UTF8String];
    
    if (sqlite3_open(dbpath, &HandyDB) == SQLITE_OK)
    {
        
        NSString *sqlInsert= [NSString stringWithFormat: @"INSERT INTO user (id, name, pass, eshow) VALUES (\"%d\", \"%@\", \"%@\", \"%@\") ",user.code,user.nameUser,user.pass, user.eshow];
        
        sqlite3_exec(HandyDB, [sqlInsert UTF8String], NULL, NULL, NULL);
        
        sqlite3_close(HandyDB);
    }

}

//Método empleado para recuperar todos los usuarios del sistema
-(NSMutableArray*) allUsersBD
{
        [self openDB]; //En caso de estar cerrada la abrimos
    
        sqlite3_stmt    *statement;
        allUsers = [[NSMutableArray alloc]initWithObjects:nil, nil];
        
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM user"];
        
        
        const char *query_stmt = [querySQL UTF8String];
    
        if (sqlite3_prepare_v2(HandyDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            { 
                User *u = [[User alloc] init];
             
                u.nameUser =    [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                u.pass =    [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                u.eshow =    [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                
                [allUsers addObject:u];
            }
        }
    
    
    sqlite3_finalize(statement);
    
    return allUsers;
    
}


//Método empleado para borrar todos los usuario
-(void) deleteUsers
{
    [self openDB];
    
    const char *dbpath = [BDPath UTF8String];
    
    if (sqlite3_open(dbpath, &HandyDB) == SQLITE_OK)
    {
        
        NSString *sqlDelete= [NSString stringWithFormat: @"DELETE FROM user"];
        
        sqlite3_exec(HandyDB, [sqlDelete UTF8String], NULL, NULL, NULL);
        
        sqlite3_close(HandyDB);
    }
    
}

@end
