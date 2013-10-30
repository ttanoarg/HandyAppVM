//
//  iCarouselViewController.m
//  Vips
//
//  Created by Fernando Pabón on 08/03/13.
//  Copyright (c) 2013 Planetmedia. All rights reserved.
//

#import "iCarouselViewController.h"

@interface iCarouselViewController () <UIActionSheetDelegate>

@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;

@end


@implementation iCarouselViewController

@synthesize carousel;
@synthesize navItem;
@synthesize wrap;
@synthesize items;

- (void)setUp
{
    //Inicializamos todos los elementos (array de imagenes, array de indices...)
	wrap = YES;
	self.items = [NSMutableArray array];
  
    myButtonImages = [[NSMutableArray alloc] init];
    
    //Cargamos 4 imágenes en el array myImagesView para el el carrusel de Pedidos
    if ([viewTypeCarrusel isEqualToString:@"1"])
    {
        myImage = [[UIImage alloc] init];
        //Cargamos 5 imágenes en el array myImagesView para el el carrusel de Home
        for (int i = 0; i < 6; i++)
        {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTag:tag];
            tag++;
            
        if (i == 0)
        {
            myImage = [UIImage imageNamed:@"s1.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

        }else if (i == 1)
        {
            myImage = [UIImage imageNamed:@"s2.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

            
        }else if (i == 2)
        {
            myImage = [UIImage imageNamed:@"s3.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

            
        }else if (i == 3)
        {
            myImage = [UIImage imageNamed:@"s4.jpeg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

            
        }else if (i == 4)
        {
            myImage = [UIImage imageNamed:@"s5.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

            
        }else if (i == 5)
        {
            myImage = [UIImage imageNamed:@"s6.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];

            
        }
            [items addObject:[NSNumber numberWithInt:i]];
        }
        
		
      
    }else if ([viewTypeCarrusel isEqualToString:@"2"])
    {
    //Cargamos 4 imágenes en el array myImagesView para el el carrusel de Home
	for (int i = 0; i < 6; i++)
	{
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTag:tag];
        tag++;
        
        if (i == 0)
        {
            myImage = [UIImage imageNamed:@"s1.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
        }else if (i == 1)
        {
            myImage = [UIImage imageNamed:@"s2.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
            
        }else if (i == 2)
        {
            myImage = [UIImage imageNamed:@"s3.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
            
        }else if (i == 3)
        {
            myImage = [UIImage imageNamed:@"s4.jpeg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
            
        }else if (i == 4)
        {
            myImage = [UIImage imageNamed:@"s5.jpg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
            
        }else if (i == 5)
        {
            myImage = [UIImage imageNamed:@"s6.jpeg"];
            [button setBackgroundImage:myImage forState:UIControlStateNormal];
            [myButtonImages addObject:button];
            
            
        }
        
		[items addObject:[NSNumber numberWithInt:i]];
    }
	}
}

- (IBAction) buttonTap:(id)sender
{
    UIButton *buttonTap = (UIButton *)sender;
    int tagReceive = buttonTap.tag;
    
    if (tagReceive == 2)
    {
        [objectDelegate ObjectSelect];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Información" message:@"Funcionalidad no implementada para la demostración" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
}

//Constructor (redefinido con la actuación del delegado)
//Redefinicón del constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<CarruselProtocol>) delegate delegateO:(id<CarruselSelectProtocol>) delegateO viewType:(NSString*)viewType;
{
    tag = 0;
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){}
    
    viewTypeCarrusel = viewType;
    
    myCarruselDelegate = delegate;
    
    objectDelegate = delegateO;
       
    return self;
    
}


- (void)dealloc
{

	carousel.delegate = nil;
	carousel.dataSource = nil;
}

- (void) viewDidAppear:(BOOL)animated
{
    
    //Configuracion de imágenes
    [self setUp];
    
    
    //Configuramos el tipo de carrusel que queremos sacar por pantalla a aprtir del motor
    
    if ([viewTypeCarrusel isEqualToString:@"1"])
    {
        //Definimos la orientación horizontal (vista home)
        [UIView beginAnimations:nil context:nil];
        carousel.vertical = carousel.vertical;
        [UIView commitAnimations];
        
        carousel.type = iCarouselTypeRotary;
        [carousel reloadData];
        [UIView commitAnimations];
        
        
    }
    else if ([viewTypeCarrusel isEqualToString:@"2"])
    {
        //Definimos la orientación vertical (vista home)
        [UIView beginAnimations:nil context:nil];
        carousel.vertical = carousel.vertical;
        [UIView commitAnimations];
        
        carousel.type = iCarouselTypeLinear;
        [carousel reloadData];
        [UIView commitAnimations];
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];   

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    self.navItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

//Método que saca las imágenes del array, crea la vista y las muestra
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
   
    for (int i = 0; i < [myButtonImages count]; i++)
	{
        button = nil;
        button = [myButtonImages objectAtIndex:index];

        if (view == nil)
        {
            if ([viewTypeCarrusel isEqualToString:@"2"])
            {
                //[myImageView setFrame:CGRectMake(23, 65, 200.0f, 100.0f)];
                [button setFrame:CGRectMake(40, 65, 200.0f, 100.0f)];
                view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
                view.backgroundColor = [UIColor clearColor];
            }
            else if ([viewTypeCarrusel isEqualToString:@"1"])
            {
                //[myImageView setFrame:CGRectMake(23, 25, 140.0f, 140.0f)];
                [button setFrame:CGRectMake(60, 75, 150.0f, 150.0f)];
                view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
                view.backgroundColor = [UIColor clearColor];
            }
            
            [view addSubview:button];
        }
        else
        {
            //myImageView = [[view subviews] lastObject];
            button = [[view subviews] lastObject];
        }
 
        [view addSubview:button];
        
    }
    
    return view;
        
	
}



- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}


@end