//
//  UPDViewController.m
//  UniversalPopoverDemo
//
//  Created by Ilya Kalinin on 8/5/14.
//  Copyright (c) 2014 Ilya Kalinin. All rights reserved.
//

#import "UPDViewController.h"

@interface UPDViewController ()

@end

@implementation UPDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.textField.dataSourceArray = @[@"kuku", @"bebe", @"meme", @"beme"];
    self.textField.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
    
}
@end
