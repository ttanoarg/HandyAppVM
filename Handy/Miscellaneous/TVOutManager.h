#import <Foundation/Foundation.h>

//Clase realizada para controlar la salida de video del dispositivo
@interface TVOutManager : NSObject
{
    
	UIWindow* deviceWindow;
	UIWindow* tvoutWindow;
	NSTimer *updateTimer;
	UIImage *image;
	UIImageView *mirrorView;
    UIImageView *mirrorIphone;
	BOOL done;
	CGAffineTransform startingTransform;
}

@property(assign) BOOL tvSafeMode;


+ (TVOutManager *)sharedInstance;

- (void) startTVOut;
- (void) stopTVOut;
- (void) updateTVOut;
- (void) updateLoop;
- (void) deviceOrientationDidChange: (NSNotification*) notification;

@end