//
//  ViewController.m
//  SMS
//
//  Created by MinYeh on 2016/8/8.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

#import "ViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <MOBFoundation/MOBFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *inputSecretNumber;
@property (weak, nonatomic) IBOutlet UILabel *result;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark -- 送出電話號碼到簡訊服務平台以便獲得驗證碼
- (IBAction)sendPhoneNumberBtn:(UIButton *)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.inputPhoneNumber.text zone:@"886" customIdentifier:nil result:^(NSError *error) {
        
        if (!error) {
            
            self.result.text = @"傳送手機號碼成功";
            self.inputPhoneNumber.text = @"";
            
        } else {
            
            self.result.text = @"傳送手機號碼失敗";
            self.inputPhoneNumber.text = @"";

        }
    }];
    
    
}

#pragma mark -- 送出驗證碼到簡訊服務平台來判斷是否驗證正確
- (IBAction)sendSecretNumberBtn:(UIButton *)sender {
    
    [SMSSDK commitVerificationCode:self.inputSecretNumber.text phoneNumber:self.inputPhoneNumber.text zone:@"886" result:^(NSError *error) {
        
        if (!error) {
            
            self.result.text = @"驗證成功";
            self.inputSecretNumber.text = @"";
            //做驗證成功要做的事情
            
        }else{
            
            self.result.text = @"驗證失敗";
            self.inputSecretNumber.text = @"";
            //做驗證失敗要做的事情
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
