//
//  CDSTextFieldPicker.m
//
//  Created by Chris Anderson on 5/12/14.
//  Copyright (c) 2014 Chris Anderson. All rights reserved.
//

#import "CDSTextFieldPicker.h"

@implementation CDSTextFieldPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // load picker
        [self initializePicker];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // load picker
        [self initializePicker];
    }
    return self;
}

- (void)initializePicker {
    CGRect pickerFrame;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        pickerFrame = CGRectMake(0, 740, 768, 264);
    } else {
        pickerFrame = CGRectMake(0, 480, 320, 216);
    }
    _picker = [[UIPickerView alloc] initWithFrame:pickerFrame];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    
    _pickerToolbar = [[UIToolbar alloc] init];
    _pickerToolbar.translucent = YES;
    _pickerToolbar.tintColor = nil;
    [_pickerToolbar sizeToFit];
    
    _toolbarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(pickerToolbarButtonPressed:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    [_pickerToolbar setItems:[NSArray arrayWithObjects:spacer, _toolbarButton, nil]];
    
    self.inputView = _picker;
    self.inputAccessoryView = _pickerToolbar;
}

#pragma mark - CDSTextFieldPicker Delegate Methods
- (void)pickerToolbarButtonPressed:(id)sender
{
    [_textFieldPickerDelegate pickerToolbarButtonPressed:sender];
}


#pragma mark - UIPickerView Delegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [_textFieldPickerDelegate numberOfComponentsForTextPicker:self];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_textFieldPickerDelegate textField:self numberOfRowsInComponent:component];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_textFieldPickerDelegate textField:self didSelectRow:row inComponent:component];
    self.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_textFieldPickerDelegate textField:self titleForRow:row forComponent:component];
}

#pragma mark - Additional Methods
- (void)selectRow:(NSInteger)row
{
    [self selectRow:row inComponent:0 animated:NO];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [_picker selectRow:row inComponent:component animated:animated];
    self.text = [_textFieldPickerDelegate textField:self titleForRow:row forComponent:component];
}


@end