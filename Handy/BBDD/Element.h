//
//  Element.h
//  Handy
//
//  Created by Fernando Pabón on 29/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Element : NSObject
{
    NSString  *nombre;
    NSString  *descripcion;

}

@property (nonatomic,strong) NSString *nombre;
@property (nonatomic,strong) NSString *descripcion;

@end
