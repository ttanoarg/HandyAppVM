//
//  EshowViewController.m
//  Handy
//
//  Created by Fernando Pabón on 29/10/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import "EshowViewController.h"
#import "MenuViewController.h"


@interface EshowViewController ()

@end

@implementation EshowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonReturn:(id)sender
{
    mVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil delegate:self];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationTransitionFlipFromRight];
    UIViewAnimationTransition trans = UIViewAnimationTransitionFlipFromRight;
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationTransition: trans forView: [self.view window] cache: YES];
  
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [UIView commitAnimations];
}
@end
