//
//  ViewController.m
//  SFExpandingButton
//
//  Created by Jason Clardy on 2/1/13.
//  Copyright (c) 2013 Jason Clardy. All rights reserved.
//

#import "ViewController.h"
#import "SFExpandingButton.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet SFExpandingButton *button;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.button setMainButtonImage:[UIImage imageNamed:@"menuButton.png"]];
    [self.button addItem:[UIImage imageNamed:@"HomeButton.png"] withTarget:self action:@selector(homePressed:)];
    [self.button addItem:[UIImage imageNamed:@"mapButton.png"] withTarget:self action:@selector(mapPressed:)];
}

- (void)mapPressed:(id)sender {
    [self.textLabel setText:@"Map"];
}

- (void)homePressed:(id)sender {
    [self.textLabel setText:@"Home"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
