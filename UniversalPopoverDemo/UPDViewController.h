//
//  UPDViewController.h
//  UniversalPopoverDemo
//
//  Created by Ilya Kalinin on 8/5/14.
//  Copyright (c) 2014 Ilya Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IKAutoCompleteTextField.h"

@interface UPDViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet IKAutoCompleteTextField *textField;

@end
