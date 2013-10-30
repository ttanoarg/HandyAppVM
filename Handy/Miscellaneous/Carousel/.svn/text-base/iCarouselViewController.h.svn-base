//
//  iCarouselViewController.h
//  Vips
//
//  Created by Fernando Pabón on 08/03/13.
//  Copyright (c) 2013 Planetmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@class MiPedidoViewController;


@protocol CarruselSelectProtocol <NSObject>

-(void) ObjectSelect;  //El delegado se ejecutará en el RootViewController (pedidos)

@end

@protocol CarruselProtocol <NSObject>

-(void) loadCarrusel;  //El delegado se ejecutará en el RootViewController (AppDelegate)

@end

@interface iCarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
{
    MiPedidoViewController *mpVC;
    id<CarruselProtocol> myCarruselDelegate;
    id<CarruselSelectProtocol> objectDelegate;
    NSMutableArray *myButtonImages;
    UIImage *myImage;
    UIButton *button;
    NSString *viewTypeCarrusel;
    int tag;
    
}

//Redefinicón del constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id<CarruselProtocol>) delegate delegateO:(id<CarruselSelectProtocol>) delegateO viewType:(NSString*)viewType;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) IBOutlet UINavigationItem *navItem;


@end
