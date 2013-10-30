#import "TranslatorManager.h"

@implementation TranslatorManager


//Método donde retornamos el texto traducido para una determinada cadena si se encuentra en el fichero de localización
//en y es son los 2 ficheros que hacen referencia a los 2 idiomas requeridos en el proyecto (inglés y español)
+(NSString*) languageSelectedStringForKey:(NSString*) key
{
    NSString *path;
	
    if([ConfigurationManager givemeLanguage]==ENGLISH_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]; 
	else if([ConfigurationManager givemeLanguage]==SPANISH_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"es" ofType:@"lproj"];
	
    else return key; //En caso que no encontremos ninguno de los 2 idomas devolvemos por defecto
	
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}



@end
