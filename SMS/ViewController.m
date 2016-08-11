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

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *inputSecretNumber;
@property (weak, nonatomic) IBOutlet UILabel *result;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Set textField's delegate
    self.inputPhoneNumber.delegate = self;
    self.inputSecretNumber.delegate = self;
    
    //Set keyboard's type  only number 
    self.inputPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.inputSecretNumber.keyboardType = UIKeyboardTypeNumberPad;
}

//碰觸鍵盤以外的地方收起鍵盤
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:true];
    
}

/*按下鍵盤的return時收起鍵盤
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}*/


#pragma mark -- 送出電話號碼到簡訊服務平台以便獲得驗證碼
- (IBAction)sendPhoneNumberBtn:(UIButton *)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.inputPhoneNumber.text zone:@"886" customIdentifier:nil result:^(NSError *error) {
        
        if (!error) {
            
            self.result.text = @"傳送手機號碼成功";
            
        } else {
            
            self.result.text = @"傳送手機號碼失敗";
            

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
