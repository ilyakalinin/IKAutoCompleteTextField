//
//  IKAutoCompleteTextField.m
//  UniversalPopoverDemo
//
//  Created by Ilya Kalinin on 8/5/14.
//  Copyright (c) 2014 Ilya Kalinin. All rights reserved.
//

#import "IKAutoCompleteTextField.h"

@interface IKAutoCompleteTextFieldDelegate : NSObject <UITextFieldDelegate>
    @property (nonatomic, weak) IKAutoCompleteTextField *textField;
    @property(nonatomic,assign) id<UITextFieldDelegate> delegate;

@end

@implementation IKAutoCompleteTextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
        
    }
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.textField filter:textField.text];
    [self.textField showPopover];
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldDidBeginEditing:textField];

    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    
    }
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.textField hidePopover];
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldDidEndEditing:textField];
    
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
    [text replaceCharactersInRange:range withString:string];
    [self.textField filter:text];
    [self.textField showPopover];
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    
    }
    return YES;
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldClear:textField];
    
    }
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:_cmd]) {
        return [self.delegate textFieldShouldReturn:textField];
    
    }
    return YES;
    
}

@end

@interface IKAutoCompleteTextField ()

@property (nonatomic, strong) UITableViewController *tableViewController;
@property (nonatomic, strong) WYPopoverController *popoverController;
@property (nonatomic, strong) IKAutoCompleteTextFieldDelegate *localDelegate;

@property (nonatomic, assign) CGSize popoverDefaultSize;

- (void)configuration;
- (void)resizePopoverToFitResults;

@end

@implementation IKAutoCompleteTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self configuration];
        
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configuration];
        
    }
    return self;
    
}

#pragma mark - Setters

- (void)setDelegate:(id)delegate {
    if ([delegate isKindOfClass:[IKAutoCompleteTextFieldDelegate class]]) {
        [super setDelegate:delegate];
        
    } else {
        self.localDelegate.delegate = delegate;
    
    }
}

#pragma mark - Helper

- (void)configuration {
    self.localDelegate = [[IKAutoCompleteTextFieldDelegate alloc] init];
    self.localDelegate.textField = self;
    self.delegate = self.localDelegate;
    self.tableViewController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableViewController.tableView.delegate = self;
    self.tableViewController.tableView.dataSource = self;
    self.popoverController = [[WYPopoverController alloc] initWithContentViewController:self.tableViewController];
    self.popoverController.delegate = self;
    self.popoverDefaultSize = self.popoverController.popoverContentSize;
    
}

- (void)resizePopoverToFitResults {
    if (self.filteredArray.count) {
        CGFloat width = self.popoverController.popoverContentSize.width;
        CGFloat height = self.tableViewController.tableView.rowHeight * self.filteredArray.count - 1;
        if (height < self.popoverDefaultSize.height) {
            self.popoverController.popoverContentSize = CGSizeMake(width, height);
            
        }
    }
}

- (void)filter:(NSString *)strings {
    if (self.dataSourceArray.count > 0) {
        if (!strings || [strings isEqualToString:@""]) {
            self.filteredArray = self.dataSourceArray;
            
        } else {
            self.filteredArray = [self.dataSourceArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self contains[cd] %@", strings]];
            
        }
//        [self resizePopoverToFitResults];
        [self.tableViewController.tableView reloadData];

    }
}

- (void)showPopover {
    if (!self.filteredArray || [self.filteredArray count] == 0) {
        [self.popoverController dismissPopoverAnimated:YES];
        
    } else if (!self.popoverController.isPopoverVisible) {
        [self.popoverController presentPopoverFromRect:self.bounds
                                                inView:self
                              permittedArrowDirections:WYPopoverArrowDirectionAny
                                              animated:YES
                                               options:WYPopoverAnimationOptionFadeWithScale];
        
    }
}

- (void)hidePopover {
    [self.popoverController dismissPopoverAnimated:YES];
    
}

#pragma mark - WYPopoverController Delegate

- (void)popoverControllerDidPresentPopover:(WYPopoverController *)popoverController {
    self.popoverDefaultSize = self.popoverController.popoverContentSize;
    
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text = [self.filteredArray objectAtIndex:indexPath.row];
    return cell;
    
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setText:[self.filteredArray objectAtIndex:indexPath.row]];
    [self resignFirstResponder];

}

@end
