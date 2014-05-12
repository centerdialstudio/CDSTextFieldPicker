//
//  CDSTextFieldPicker.h
//
//  Created by Chris Anderson on 5/12/14.
//  Copyright (c) 2014 Chris Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDSTextFieldPicker;

@protocol CDSTextFieldPickerDelegate
- (void)pickerToolbarButtonPressed:(id)sender;
- (NSInteger)numberOfComponentsForTextPicker:(CDSTextFieldPicker *)textField;
- (NSInteger)textField:(CDSTextFieldPicker *)textField numberOfRowsInComponent:(NSInteger)component;
- (void)textField:(CDSTextFieldPicker *)textField didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
- (NSString *)textField:(CDSTextFieldPicker *)textField titleForRow:(NSInteger)row forComponent:(NSInteger)component;
@end

@interface CDSTextFieldPicker : UITextField <
    UITextFieldDelegate,
    UIPickerViewDataSource,
    UIPickerViewDelegate
>

/// Delegate
@property (nonatomic, weak) id <CDSTextFieldPickerDelegate>textFieldPickerDelegate;
/// Picker
@property (nonatomic, strong) UIPickerView *picker;
/// Toolbar
@property (nonatomic, strong) UIToolbar *pickerToolbar;
/// Toolbar button
@property (nonatomic, strong) UIBarButtonItem *toolbarButton;

- (void)selectRow:(NSInteger)row;
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

@end
