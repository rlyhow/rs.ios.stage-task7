//
//  ViewController.m
//  Demo
//
//  Created by Mikita Shalima on 4.07.21.
//  Copyright © 2021 Viktar Semianchuk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *rsTitle;

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *personButton;

@property (weak, nonatomic) IBOutlet UIView *secureBorder;
@property (weak, nonatomic) IBOutlet UIButton *numberOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *numberThreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *secureCodeLabel;

@property (strong, nonatomic) NSDictionary<NSString *, NSString *> *listOfUsers;

typedef enum
{   ready = 0,
    error = 1,
    success = 2
} TextFieldState;

@end

// MARK: - Keyboard category
@interface ViewController (KeyboardHandling)
- (void)hideWhenTappedAround;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listOfUsers = @{ @"username" : @"password"};
    
    // textFields
    
    _loginTextField.layer.borderWidth = 1.5;
    _loginTextField.layer.cornerRadius = 5.0;
    _loginTextField.delegate = self;
    
    _passwordTextField.layer.borderWidth = 1.5;
    _passwordTextField.layer.cornerRadius = 5.0;
    _passwordTextField.delegate = self;
    
    [self hideWhenTappedAround];
    
    // personButton
    
    _personButton.layer.borderWidth = 2.0;
    _personButton.layer.cornerRadius = 10.0;
    _personButton.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:1.0].CGColor;
    
    [_personButton setTitleColor:[UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:0.2] forState:UIControlStateHighlighted];
    UIImage *btnImage = [UIImage imageNamed:@"FillPerson.png"];
    [_personButton setImage:btnImage forState:UIControlStateHighlighted];
    
    [_personButton addTarget:self action:@selector(tapHandle) forControlEvents:UIControlEventTouchUpInside];
    [_loginTextField addTarget:self action:@selector(tapLoginField) forControlEvents:UIControlEventTouchDown];
    [_passwordTextField addTarget:self action:@selector(tapPasswordField) forControlEvents:UIControlEventTouchDown];
    
    // secure layer
    
    _secureBorder.hidden = YES;
    
    _numberOneBtn.layer.borderWidth = 1.5;
    _numberOneBtn.layer.cornerRadius = 25.0;
    _numberOneBtn.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:1.0].CGColor;
    
    _numberTwoBtn.layer.borderWidth = 1.5;
    _numberTwoBtn.layer.cornerRadius = 25.0;
    _numberTwoBtn.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:1.0].CGColor;
    
    _numberThreeBtn.layer.borderWidth = 1.5;
    _numberThreeBtn.layer.cornerRadius = 25.0;
    _numberThreeBtn.layer.borderColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:1.0].CGColor;
    
}


// functions

// закрывает клавиатуру при нажатии return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

// только символы латинского алфавита
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![myCharSet characterIsMember:c] && theTextField == _loginTextField) {
            return NO;
        }
    }
    
    return YES;
}

- (void)tapHandle
{
    for(id key in _listOfUsers)
        if ([_loginTextField.text isEqualToString:key] && [_passwordTextField.text isEqualToString:[_listOfUsers objectForKey:key]]) {
            [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil]; // close keyboard
            [self changeStateOfPasswordField:success];
            [self changeStateOfLoginField:success];
            [self changeStateOfPersonButton:success];
            _secureBorder.hidden = NO;
            
            return;
        } else if (![_loginTextField.text isEqualToString:key] && ![_passwordTextField.text isEqualToString:[_listOfUsers objectForKey:key]]){
            [self changeStateOfLoginField:error];
            [self changeStateOfPasswordField:error];
            return;
        }else if (![_passwordTextField.text isEqualToString:[_listOfUsers objectForKey:key]]) {
            [self changeStateOfPasswordField:error];
            _loginTextField.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:0.5].CGColor;
            return;
        } else if (![_loginTextField.text isEqualToString:key]) {
            [self changeStateOfLoginField:error];
            _passwordTextField.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:0.5].CGColor;
            return;
        }
}

- (void)tapLoginField {
    [self changeStateOfLoginField:ready];
}

- (void)tapPasswordField {
    [self changeStateOfPasswordField:ready];
}

- (IBAction)tapNumberCode:(id)sender {
    
    _secureBorder.layer.borderWidth = 0;
    
    switch ([sender tag]) {
        case 1:
            if ([_secureCodeLabel.text isEqualToString:@"_"]) { _secureCodeLabel.text = @"1"; }
            else { _secureCodeLabel.text = [_secureCodeLabel.text stringByAppendingString:@" 1"]; }
            _numberOneBtn.layer.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:0.2].CGColor;
            break;
        case 2:
            if ([_secureCodeLabel.text isEqualToString:@"_"]) { _secureCodeLabel.text = @"2"; }
            else { _secureCodeLabel.text = [_secureCodeLabel.text stringByAppendingString:@" 2"]; }
            _numberTwoBtn.layer.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:0.2].CGColor;
            break;
        case 3:
            if ([_secureCodeLabel.text isEqualToString:@"_"]) { _secureCodeLabel.text = @"3"; }
            else { _secureCodeLabel.text = [_secureCodeLabel.text stringByAppendingString:@" 3"]; }
            _numberThreeBtn.layer.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:0.2].CGColor;
            break;
        default:
            NSLog(@"0");
            break;
    }
    
    switch (_secureCodeLabel.text.length) {
        case 5:
            if ([_secureCodeLabel.text isEqualToString:@"1 3 2"]) {
                [self changeStateOfSecure:success];
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                                                               message:@"You are successfuly authorized!"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                    
                    self.loginTextField.text = @"";
                    self.passwordTextField.text = @"";
                    [self changeStateOfLoginField:ready];
                    [self changeStateOfPasswordField:ready];
                    [self changeStateOfPersonButton:ready];
                    [self changeStateOfSecure:ready];
                    
                }];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            } else {
                [self changeStateOfSecure:error];
            }
            break;
        default:
            break;
    }
}


// buttons change bagroundColor
- (IBAction)buttonClicked:(id)sender {
    switch ([sender tag]) {
        case 0:
            _personButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
            break;
        case 1:
            _numberOneBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            break;
        case 2:
            _numberTwoBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            break;
        case 3:
            _numberThreeBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            break;
        default:
            NSLog(@"0");
            break;
    }
}

- (IBAction)buttonReleased:(id)sender {
    _personButton.layer.backgroundColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:0.2].CGColor;
}


- (void)changeStateOfLoginField:(TextFieldState)state {
    switch (state) {
        case 0:
            _loginTextField.alpha = 1;
            _loginTextField.userInteractionEnabled = YES;
            _loginTextField.layer.borderColor = [UIColor colorWithRed:76.0/255.0 green:92.0/255.0 blue:104.0/255.0 alpha:1.0].CGColor;
            break;
        case 1:
            _loginTextField.layer.borderColor = [UIColor colorWithRed:194.0/255.0 green:1.0/255.0 blue:20.0/255.0 alpha:1.0].CGColor;
            break;
        case 2:
            _loginTextField.alpha = 0.5;
            _loginTextField.userInteractionEnabled = NO;
            _loginTextField.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:0.5].CGColor;
            break;
            
        default:
            break;
    }
}

- (void)changeStateOfPasswordField:(TextFieldState)state {
    switch (state) {
        case 0:
            _passwordTextField.alpha = 1;
            _passwordTextField.userInteractionEnabled = YES;
            _passwordTextField.layer.borderColor = [UIColor colorWithRed:76.0/255.0 green:92.0/255.0 blue:104.0/255.0 alpha:1.0].CGColor;
            break;
        case 1:
            _passwordTextField.layer.borderColor = [UIColor colorWithRed:194.0/255.0 green:1.0/255.0 blue:20.0/255.0 alpha:1.0].CGColor;
            break;
        case 2:
            _passwordTextField.alpha = 0.5;
            _passwordTextField.userInteractionEnabled = NO;
            _passwordTextField.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:0.5].CGColor;
            break;
            
        default:
            break;
    }
}

- (void)changeStateOfPersonButton:(TextFieldState)state {
    switch (state) {
        case 0:
            _personButton.alpha = 1;
            _personButton.userInteractionEnabled = YES;
            break;
        case 2:
            _personButton.alpha = 0.5;
            _personButton.userInteractionEnabled = NO;
            break;
            
        default:
            break;
    }
}

- (void)changeStateOfSecure:(TextFieldState)state {
    switch (state) {
        case 0:
            self.secureBorder.hidden = YES;
            self.secureBorder.layer.borderWidth = 0;
            self.secureCodeLabel.text = @"_";
            break;
        case 1:
            _secureCodeLabel.text = @"_";
            _secureBorder.layer.borderWidth = 2.0;
            _secureBorder.layer.cornerRadius = 10.0;
            _secureBorder.layer.borderColor = [UIColor colorWithRed:194.0/255.0 green:1.0/255.0 blue:20.0/255.0 alpha:1.0].CGColor;
            break;
        case 2:
            _secureBorder.layer.borderWidth = 2.0;
            _secureBorder.layer.cornerRadius = 10.0;
            _secureBorder.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:0.5].CGColor;
            _numberTwoBtn.layer.backgroundColor = [UIColor whiteColor].CGColor;
            break;
            
        default:
            break;
    }
}


@end





// MARK: - Keyboard category
@implementation ViewController (KeyboardHandling)

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

@end
