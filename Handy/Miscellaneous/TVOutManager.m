#import <QuartzCore/QuartzCore.h>
#import "TVOutManager.h"

#define kFPS 15
#define kUseBackgroundThread NO

@implementation TVOutManager

@synthesize tvSafeMode;

+ (TVOutManager *)sharedInstance
{
	static TVOutManager *sharedInstance;
    
	@synchronized(self)
	{
		if (!sharedInstance)
			sharedInstance = [[TVOutManager alloc] init];
		return sharedInstance;
	}
}


- (id) init
{
    self = [super init];
    if (self) 
    {
		[[NSNotificationCenter defaultCenter] removeObserver: self];
        
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidConnectNotification:) name: UIScreenDidConnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenDidDisconnectNotification:) name: UIScreenDidDisconnectNotification object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(screenModeDidChangeNotification:) name: UIScreenModeDidChangeNotification object: nil];
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

		[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(deviceOrientationDidChange:) name: UIDeviceOrientationDidChangeNotification object: nil];		
    }
    return self;
}

-(void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) startTVOut
{
	//Necesitamos una vista previa para poder activar la salida de video
	if ([[UIApplication sharedApplication] keyWindow] == nil) return;
    
	NSArray* screens = [UIScreen screens];
	if ([screens count] <= 1)
    {
		NSLog(@"No se ha detectado una salida de video");
		return;	
	}
    
	if (tvoutWindow) 
    {
        //Reconecta el adaptador de video
		tvoutWindow = nil;
	}
    
	if (!tvoutWindow)
    {
		deviceWindow = [[UIApplication sharedApplication] keyWindow];
        
		CGSize max;
		max.width = 0;
		max.height = 0;
		UIScreenMode *maxScreenMode = nil;
		UIScreen *external = [[UIScreen screens] objectAtIndex: 1];
        
		for(int i = 0; i < [[external availableModes] count]; i++)
		{
			UIScreenMode *current = [[[[UIScreen screens] objectAtIndex:1] availableModes] objectAtIndex: i];
			if (current.size.width > max.width)
			{
				max = current.size;
				maxScreenMode = current;
			}
		}
		external.currentMode = maxScreenMode;
        
		tvoutWindow = [[UIWindow alloc] initWithFrame: CGRectMake(0,0, max.width, max.height)];
		tvoutWindow.userInteractionEnabled = NO;
		tvoutWindow.screen = external;
  
        
        
        CGRect  mirrorRect = [[UIScreen mainScreen] bounds];
		CGFloat horiz = max.width / CGRectGetWidth(mirrorRect);
        CGFloat vert = max.height / CGRectGetHeight(mirrorRect);
		CGFloat bigScale = horiz < vert ? horiz : vert;
        
        
		mirrorRect = CGRectMake(mirrorRect.origin.x+262, mirrorRect.origin.y+57, mirrorRect.size.width-70 * bigScale, mirrorRect.size.height-80 * bigScale);
        UIImageView *myIphone =  [[UIImageView alloc] initWithFrame: CGRectMake(0,0, max.width-60, max.height)];
        
        [myIphone setFrame:CGRectMake(mirrorRect.origin.x, mirrorRect.origin.y, mirrorRect.size.width-30 * bigScale, mirrorRect.size.height * bigScale)];
        
        myIphone.image = [UIImage imageNamed: @"iphone4.png"];
        [tvoutWindow addSubview:myIphone];
        
        
        //Modificar este mirror segun el tipo de Resolución
		mirrorRect = [[UIScreen mainScreen] bounds];
		horiz = max.width / CGRectGetWidth(mirrorRect);
		vert = max.height / CGRectGetHeight(mirrorRect);
        bigScale = horiz < vert ? horiz : vert;
		mirrorRect = CGRectMake(mirrorRect.origin.x+287, mirrorRect.origin.y+130, mirrorRect.size.width-170, mirrorRect.size.height-170);
        
		mirrorView = [[UIImageView alloc] initWithFrame: mirrorRect];
		//mirrorView.center = tvoutWindow.center;
        
        
		if (tvSafeMode) tvoutWindow.transform = CGAffineTransformScale(tvoutWindow.transform, .8, .8);
		[tvoutWindow addSubview: mirrorView];
		[tvoutWindow makeKeyAndVisible];
		tvoutWindow.hidden = NO;		
		tvoutWindow.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *myLogo=  [[UIImageView alloc] initWithFrame: CGRectMake(0,0, max.width, max.height)];
        
        [myLogo setFrame:CGRectMake(mirrorRect.origin.x+235, mirrorRect.origin.y+150, mirrorRect.size.width+18, mirrorRect.size.height-180)];
        
        mirrorView = [[UIImageView alloc] initWithFrame: mirrorRect];
        myLogo.image = [UIImage imageNamed: @"Planet.png"];
        [tvoutWindow addSubview:myLogo];
        
		
		mirrorView = [[UIImageView alloc] initWithFrame: mirrorRect];
		//mirrorView.center = tvoutWindow.center;
        
		if (tvSafeMode) tvoutWindow.transform = CGAffineTransformScale(tvoutWindow.transform, .8, .8);
		[tvoutWindow addSubview: mirrorView];
		[tvoutWindow makeKeyAndVisible];
		tvoutWindow.hidden = NO;		
		tvoutWindow.backgroundColor = [UIColor blackColor];
      
        
        startingTransform = mirrorView.transform;
        
		[deviceWindow makeKeyAndVisible];
        
		[self updateTVOut];
        
		if (kUseBackgroundThread) [NSThread detachNewThreadSelector:@selector(updateLoop) toTarget:self withObject:nil];
		else {
			updateTimer = [NSTimer scheduledTimerWithTimeInterval: (1.0/kFPS) target: self selector: @selector(updateTVOut) userInfo: nil repeats: YES];
		}
        
	}
}

- (void) stopTVOut;
{
	done = YES;
	if (updateTimer) 
    {
		[updateTimer invalidate];
		updateTimer = nil;
	}
	if (tvoutWindow) {
		tvoutWindow = nil;
		mirrorView = nil;
	}
}

- (void) updateTVOut;
{
#ifdef USE_UIGETSCREENIMAGE

	CGImageRef cgScreen = UIGetScreenImage();
	if (cgScreen) image = [UIImage imageWithCGImage:cgScreen];
	mirrorView.image = image;
	CGImageRelease(cgScreen);
	
#else
 
	UIGraphicsBeginImageContext(deviceWindow.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
		if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context, -[window bounds].size.width * window.layer.anchorPoint.x, -[window bounds].size.height * window.layer.anchorPoint.y);
            [[window layer] renderInContext:context];
            CGContextRestoreGState(context);
        }
    }	
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	mirrorView.image = image;
    
#endif
}


- (void)updateLoop;
{
	done = NO;
    
	while ( ! done )
	{
		[self performSelectorOnMainThread:@selector(updateTVOut) withObject:nil waitUntilDone:NO];
		[NSThread sleepForTimeInterval: (1.0/kFPS) ];
	}
}

-(void) deviceOrientationDidChange: (NSNotification*) notification
{
    //Deshabilitamos alguna rotación
}

@end
