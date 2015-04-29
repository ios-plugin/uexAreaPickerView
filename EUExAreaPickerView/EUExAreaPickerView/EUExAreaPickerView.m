//
//  EUExAreaPickerView.m
//  AppCanPlugin
//
//  Created by Frank on 15/1/17.
//  Copyright (c) 2015年 zywx. All rights reserved.
//

#import "EUExAreaPickerView.h"
//#import "UIView+Helpers.h"
#import "LDAreaPickerView.h"
#import "EUtility.h"
#import "JSON.h"
@interface EUExAreaPickerView() <LDAreaPickerDelegate>
@property(nonatomic,strong)UITextField *pseudoTextField;
@property(nonatomic,strong)LDAreaPickerView *areaPicker;
@end
@implementation EUExAreaPickerView

-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
    }
    return self;
}

-(void)open:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
        CGFloat x = [[array objectAtIndex:0] floatValue];
        CGFloat y = [[array objectAtIndex:1] floatValue];
        CGFloat w = [[array objectAtIndex:2] floatValue];
        CGFloat h = [[array objectAtIndex:3] floatValue];
 
        if (!self.pseudoTextField) {
            self.pseudoTextField = [[UITextField alloc] initWithFrame:CGRectZero];
            [EUtility brwView:meBrwView addSubview:self.pseudoTextField];
            UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
            keyboardDoneButtonView.barStyle = UIBarStyleDefault;
            [keyboardDoneButtonView sizeToFit];
            UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                           style:UIBarButtonItemStyleBordered target:self
                                                                          action:@selector(clickBtnDone)];
            UIBarButtonItem *spaceBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:spaceBtn,doneButton, nil]];
            self.pseudoTextField.inputAccessoryView = keyboardDoneButtonView;
        }
        if (!self.areaPicker) {
            self.areaPicker = [[LDAreaPickerView alloc] initWithFrame:CGRectMake(0, [EUtility screenHeight] - h, [EUtility screenWidth], h) Style:LDAreaPickerWithStateAndCityAndDistrict delegate:self];
            self.pseudoTextField.inputView = self.areaPicker;

        }
        [self.pseudoTextField becomeFirstResponder];
        
    }
}
- (void)pickerDidChaneStatus:(LDAreaPickerView *)picker{
    NSString *resultStr = nil;
    if (picker.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        resultStr = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    } else{
        resultStr = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}
-(void)close:(NSMutableArray *)array{
    if (self.pseudoTextField) {
        [self.pseudoTextField resignFirstResponder];
        [self.pseudoTextField removeFromSuperview];
        self.pseudoTextField = nil;
    }
}
-(void)clickBtnDone{
    NSString *resultStr = nil;
    if (self.areaPicker.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        resultStr = [NSString stringWithFormat:@"%@ %@ %@", self.areaPicker.locate.state, self.areaPicker.locate.city, self.areaPicker.locate.district];
    } else{
        resultStr = [NSString stringWithFormat:@"%@ %@", self.areaPicker.locate.state, self.areaPicker.locate.city];
    }
    [self.meBrwView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"uexAreaPickerView.onConfirmClick(%@);",[@{@"city":resultStr} JSONRepresentation]]];

}
@end
