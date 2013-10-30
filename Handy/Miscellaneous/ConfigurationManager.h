#import <Foundation/Foundation.h>

@interface ConfigurationManager : NSObject

+(int) givemeLanguage; //Método donde se modifica la variable selectedlanguage con el valor actual. Por defecto será 1 (idioma en inglés)
+(void) saveLanguageConfigurationData:(int)lang; //Método que almacena la configuración del idioma

+(void) saveGpsConfigurationData:(int)lang; //Método que almacena la configuración de gps
+(float) givemeGpsConfigurationData; //Método que nos devuelve el tiempo con el valor actual. Por defecto valdrá 15 minutos


@end
