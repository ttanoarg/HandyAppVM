//
//  ProgramacionEventosViewController.m
//  Handy
//
//  Created by Fernando Pabón on 05/11/13.
//  Copyright (c) 2013 VM. All rights reserved.
//

#import "ProgramacionEventosViewController.h"

@interface ProgramacionEventosViewController ()

@end

@implementation ProgramacionEventosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(self.content.frame.size.width, self.content.frame.size.height)];
    
    [self.scrollView addSubview:self.content];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
