#import "ConfigurationManager.h"

@implementation ConfigurationManager

//Método que almacena la configuración del idioma

+(void) saveLanguageConfigurationData:(int)lang
{
    NSInteger index = lang;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults]; 
    
    [settings setInteger:index forKey:@"Language"]; 
    
    [settings synchronize]; 
}


//Método donde se modifica la variable selectedlanguage con el valor actual. Por defecto será 1 (idioma en inglés)

+(int) givemeLanguage
{  
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if([settings objectForKey:@"Language"] != nil) 
    { 
        return [settings integerForKey:@"Language"]; 
    }
    
    else 
    {
        
        
        NSUserDefaults *settings = [NSUserDefaults standardUserDefaults]; 
        
        [settings setInteger:1 forKey:@"Language"]; 
        
        [settings synchronize]; 
        
        return 1; //Lenguaje por defecto (Inglés)
    }
 
}

//Método que almacena la configuración de gps

+(void) saveGpsConfigurationData:(int)lang
{
    int index = lang;
    NSString *concat;
    NSString *decimal = @"f";
    
    if (index == 0)
    {
        concat = [NSString stringWithFormat:@"%@%@",@"15.000000",decimal];
        
    }
    else
    {
        NSString *indexString = [NSString stringWithFormat:@"%i",index];
        concat = [NSString stringWithFormat:@"%@%@",indexString,decimal];
        
    }
    NSLog(@"Concat: %f", [concat floatValue]);
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults]; 
    [settings setFloat:[concat floatValue] forKey:@"GpsTime"];
    [settings synchronize]; 
}


//Método donde se modifica la variable tiempo con el valor actual. Por defecto valdrá 15 minutos

+(float) givemeGpsConfigurationData
{
    NSString *gpsValue;
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    gpsValue = [settings objectForKey:@"GpsTime"];
    
    if ([gpsValue floatValue] == 0)
    {
        return 15.000000f;
        
    }
    else
    {
        return [gpsValue floatValue];
    }
}


@end
