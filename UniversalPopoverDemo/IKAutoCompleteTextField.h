//
//  IKAutoCompleteTextField.h
//  UniversalPopoverDemo
//
//  Created by Ilya Kalinin on 8/5/14.
//  Copyright (c) 2014 Ilya Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"

@interface IKAutoCompleteTextField : UITextField
<UITableViewDataSource, UITableViewDelegate, WYPopoverControllerDelegate>

@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) NSArray *filteredArray;

- (void)filter:(NSString *)strings;
- (void)showPopover;
- (void)hidePopover;

@end
