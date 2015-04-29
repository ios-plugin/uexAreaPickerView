//
//  LDAreaPickerView.m
//  AppCanPlugin
//
//  Created by Frank on 15/1/17.
//  Copyright (c) 2015年 zywx. All rights reserved.
//

#import "LDAreaPickerView.h"
@implementation LDLocation
@end
@interface LDAreaPickerView () <UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *provinces, *cities, *areas;
}
@end
@implementation LDAreaPickerView
-(LDLocation *)locate
{
    if (_locate == nil) {
        _locate = [[LDLocation alloc] init];
    }
    
    return _locate;
}
- (id)initWithFrame:(CGRect)frame Style:(LDAreaPickerStyle)pickerStyle delegate:(id<LDAreaPickerDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.areaDelegate = delegate;
        //marc weak what can i do？
 //       __weak __typeof(&*self)weakSelf = self;
        self.delegate = self;
        self.dataSource = self;
        self.pickerStyle = pickerStyle;
        [self setBackgroundColor:[UIColor whiteColor]];
        self.showsSelectionIndicator = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        //加载数据
        if (self.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"uexAreaPickerView/uexAreaPickerView.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0) {
                self.locate.district = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
        } else{
            provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"uexAreaPickerView/uexAreaPickerView.plist" ofType:nil]];
            cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
            self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
            self.locate.city = [cities objectAtIndex:0];
        }
    }
    
    return self;
    
}
#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [areas objectAtIndex:row];
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [cities objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == LDAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self selectRow:0 inComponent:1 animated:YES];
                [self reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [self selectRow:0 inComponent:2 animated:YES];
                [self reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [self selectRow:0 inComponent:2 animated:YES];
                [self reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self selectRow:0 inComponent:1 animated:YES];
                [self reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [cities objectAtIndex:0];
                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                break;
            default:
                break;
        }
    }
    
    if([self.areaDelegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.areaDelegate pickerDidChaneStatus:self];
    }
    
}


@end
