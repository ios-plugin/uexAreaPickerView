//
//  LDAreaPickerView.h
//  AppCanPlugin
//
//  Created by Frank on 15/1/17.
//  Copyright (c) 2015年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    LDAreaPickerWithStateAndCity,
    LDAreaPickerWithStateAndCityAndDistrict
} LDAreaPickerStyle;
@interface LDLocation : NSObject
@property (copy, nonatomic) NSString *country;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property (copy, nonatomic) NSString *street;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end

@protocol LDAreaPickerDelegate;
@interface LDAreaPickerView : UIPickerView
@property (assign, nonatomic) id <LDAreaPickerDelegate> areaDelegate;
@property (strong, nonatomic) LDLocation *locate;
@property (nonatomic,assign) LDAreaPickerStyle pickerStyle;

- (id)initWithFrame:(CGRect)frame Style:(LDAreaPickerStyle)pickerStyle delegate:(id <LDAreaPickerDelegate>)delegate;
@end

@protocol LDAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(LDAreaPickerView *)picker;

@end