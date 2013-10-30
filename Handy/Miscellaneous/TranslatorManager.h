#import <Foundation/Foundation.h>
#import "ConfigurationManager.h"


#define ENGLISH_LANGUAGE 1
#define SPANISH_LANGUAGE 2

@interface TranslatorManager : NSObject
{ 
    
    int selectedLanguage; //Lenguaje que tenemos actualmente configurado 
    
}

//Método donde retornamos el texto traducido para una determinada cadena
+(NSString*) languageSelectedStringForKey:(NSString*) key;


@end
