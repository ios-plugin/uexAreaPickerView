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
//@property(nonatomic,strong)UITextField *pseudoTextField;
@property(nonatomic,strong)LDAreaPickerView *areaPicker;
@property(nonatomic,strong)UIButton *clearField;
@property(nonatomic,strong)UIButton *confirmButton;
@property(nonatomic,strong)UIImageView *confirmField;

@end
@implementation EUExAreaPickerView

const CGFloat kPickerHeight = 216.f;
const CGFloat kComfirmButtonHeight = 40.f;
const CGFloat kComfirmButtonWidth=60.f;






//-(id)initWithBrwView:(EBrowserView *)eInBrwView{
//    self = [super initWithBrwView:eInBrwView];
//    if (self) {
//    }
//    return self;
//}

-(void)clean{
    if(_areaPicker){
        [_areaPicker removeFromSuperview];
        [_areaPicker release];
        _areaPicker=nil;
    }
    if(_clearField){
        [_clearField removeFromSuperview];
        [_clearField release];
        _clearField=nil;
    }
    if(_confirmField){
        [_confirmField removeFromSuperview];
        [_confirmField release];
        _confirmField=nil;
    }
    if(_confirmButton){
        [_confirmButton removeFromSuperview];
        [_confirmButton release];
        _confirmButton=nil;
    }
}

-(void)dealloc{
    [self clean];
    [super dealloc];
}
-(void)open:(NSMutableArray *)array{
  //  if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
     //   CGFloat x = [[array objectAtIndex:0] floatValue];
       // CGFloat y = [[array objectAtIndex:1] floatValue];
      //  CGFloat w = [[array objectAtIndex:2] floatValue];
      //  CGFloat h = [[array objectAtIndex:3] floatValue];
    //CGFloat h=0;
 /*
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
            

        }
        self.pseudoTextField.inputView = self.areaPicker;
        [self.pseudoTextField becomeFirstResponder];
        
   // }
  */
    [self setup];
    [self showAll];
    
}

-(void)setup{
    CGFloat width=[EUtility screenWidth];
    CGFloat clearHeight=[EUtility screenHeight]-kComfirmButtonHeight-kPickerHeight;
    
    if(!self.clearField){
        self.clearField=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.clearField setFrame:CGRectMake(0, 0, width, clearHeight)];
        self.clearField.opaque=NO;
        //self.clearField.alpha=0;
        self.clearField.backgroundColor=[UIColor clearColor];
        self.clearField.showsTouchWhenHighlighted=NO;
        [self.clearField addTarget:self action:@selector(closeAll) forControlEvents:UIControlEventTouchUpInside];
        //self.clearField.
    }
    if(!self.confirmField){
        self.confirmField=[[UIImageView alloc]initWithFrame:CGRectMake(0, clearHeight,width, kComfirmButtonHeight)];
        self.confirmField.backgroundColor=[UIColor whiteColor];
    }
    if(!self.confirmButton){
        self.confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setFrame:CGRectMake(width-kComfirmButtonWidth,clearHeight,kComfirmButtonWidth, kComfirmButtonHeight)];

        self.confirmButton.backgroundColor=[UIColor clearColor];
        self.confirmButton.showsTouchWhenHighlighted=NO;
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.confirmButton setTitle:@"确定" forState:UIControlStateSelected];
        [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.confirmButton addTarget:self action:@selector(clickBtnDone) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!self.areaPicker) {
        self.areaPicker = [[LDAreaPickerView alloc] initWithFrame:CGRectMake(0,clearHeight+kComfirmButtonHeight, width,kPickerHeight) Style:LDAreaPickerWithStateAndCityAndDistrict delegate:self];
        
        
    }
}
-(void)showAll{
    //[EUtility brwView:meBrwView addSubview:self.clearField];
    [[self.webViewEngine webView] addSubview:self.clearField];
    
    //[EUtility brwView:meBrwView addSubview:self.confirmField];
     [[self.webViewEngine webView] addSubview:self.confirmField];
    
   // [EUtility brwView:meBrwView addSubview:self.confirmButton];
     [[self.webViewEngine webView] addSubview:self.confirmButton];
    
    //[EUtility brwView:meBrwView addSubview:self.areaPicker];
     [[self.webViewEngine webView] addSubview:self.areaPicker];
}
- (void)pickerDidChaneStatus:(LDAreaPickerView *)picker{
    NSString *resultStr = nil;
    if (picker.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        resultStr = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    } else{
        resultStr = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}
-(void)closeAll{
    if(self.areaPicker){
        [self.areaPicker removeFromSuperview];
        
    }
    if(self.clearField){
        [self.clearField removeFromSuperview];
        
    }
    if(self.confirmField){
        [self.confirmField removeFromSuperview];
        
    }
    if(self.confirmButton){
        [self.confirmButton removeFromSuperview];
    }

}

-(void)close:(NSMutableArray *)array{
  /*  if (self.pseudoTextField) {
        [self.pseudoTextField resignFirstResponder];
        [self.pseudoTextField removeFromSuperview];
        self.pseudoTextField = nil;
    }
   */
    [self closeAll];
}
-(void)clickBtnDone{
    NSString *resultStr = nil;
    if (self.areaPicker.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        resultStr = [NSString stringWithFormat:@"%@ %@ %@", self.areaPicker.locate.state, self.areaPicker.locate.city, self.areaPicker.locate.district];
    } else{
        resultStr = [NSString stringWithFormat:@"%@ %@", self.areaPicker.locate.state, self.areaPicker.locate.city];
    }
    //NSString *str =[NSString stringWithFormat:@"uexAreaPickerView.onConfirmClick('%@');",[@{@"city":resultStr} JSONRepresentation]];
    
    //[self.meBrwView stringByEvaluatingJavaScriptFromString:str];
    [self.webViewEngine callbackWithFunctionKeyPath:@"uexAreaPickerView.onConfirmClick" arguments:ACArgsPack([@{@"city":resultStr} ac_JSONFragment])];
    [self closeAll];

}
@end
