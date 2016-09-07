//
//  ViewController.m
//  YHPickerView
//
//  Created by YH_O on 16/7/27.
//  Copyright © 2016年 OYH. All rights reserved.
//

#import "ViewController.h"
#import "YHPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    YHPickerView *pickerView = [[YHPickerView alloc] initWithFrame:CGRectMake(40, 100, 300, 200)];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.layer.cornerRadius = 5;
    pickerView.layer.masksToBounds = YES;
    
    [self.view addSubview:pickerView];
}


























@end
