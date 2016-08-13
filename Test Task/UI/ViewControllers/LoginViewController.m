//
//  LoginViewController.m
//  Test Task
//
//  Created by viera on 8/8/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import "LoginViewController.h"
#import "FUITextField.h"
#import "FUIButton.h"
#import "UIViewController+BackgroundWithGradient.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "SCLAlertView.h"
#import "ServerManager.h"
#import "Utils.h"
#import "ActivityView.h"
#import "MainViewController.h"

#define kMainViewControllerSegueIdentifier @"goToMainViewController"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *login;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet FUIButton *loginButton;

@end

#pragma mark - Memory management

#pragma mark - View LifeCycle
@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareBackgroundColor];
    [self prepareLoginButton];
    [self prepareLoginFields];
}

#pragma mark - Action Handlers

- (IBAction)onLoginAction:(id)sender
{
    NSString *username = [self.login.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self isEnteredDataValid: username andPassword: password])
    {
        __weak typeof (self) weakSelf = self;
        [[ActivityView instance] showInView: self.view];
        [[ServerManager sharedManager] loginUser: username withPassword: password completetionBlock:^(BOOL success, NSArray *availableGameWorlds, NSError *error) {
            typeof (self) strongSelf = weakSelf;
            [[ActivityView instance] hide];
            
            if (strongSelf)
            {
                if (success)
                {
                    [strongSelf performSegueWithIdentifier: kMainViewControllerSegueIdentifier sender: availableGameWorlds];
                }
                else
                {
                    [Utils showAlertIn: strongSelf withTitle: @"Error" message: [error.userInfo objectForKey: NSLocalizedDescriptionKey] withDuration: 0.0f];
                }
            }

        }];
    }
}

#pragma mark - Public

#pragma mark - Private
- (void)prepareLoginButton
{
    self.loginButton.buttonColor = [UIColor clearColor];
    self.loginButton.shadowColor = [UIColor clearColor];
    self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginButton.layer.borderWidth = 1.0;
    self.loginButton.layer.cornerRadius = 5.0;
    self.loginButton.shadowHeight = 3.0f;
    self.loginButton.cornerRadius = 3.0f;
    self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:14];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (BOOL)isEnteredDataValid:(NSString*)username andPassword:(NSString*)password
{
    BOOL isValid = true;
    
    NSString *errorTitle = @"Wow!";
    NSString *errorMessage = @"";
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    alert.hideAnimationType = FadeIn;
    alert.backgroundType = Transparent;
    
    if (username.length == 0)
    {
        isValid = false;
        errorMessage = @"Make sure you entered username";

    }
    else if (password.length == 0)
    {
        isValid = false;
        errorMessage = @"Make sure you entered password";
    }
    
    if (!isValid)
    {
        [alert showError: errorTitle subTitle: errorMessage closeButtonTitle: @"Ok"  duration:0.0f];
    }
    
    return isValid;
}

- (void)prepareLoginFields
{
    NSArray *fieldsArray = @[self.login, self.password];
    
    for (UITextField *tmpField in fieldsArray)
    {
        tmpField.font = [UIFont flatFontOfSize:16];
        tmpField.backgroundColor = [UIColor clearColor];
        tmpField.layer.borderColor = [UIColor whiteColor].CGColor;
        tmpField.layer.borderWidth = 1.0;
        tmpField.layer.cornerRadius = 5.0;
        [tmpField setValue: [UIColor cloudsColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: kMainViewControllerSegueIdentifier])
    {
        MainViewController *mainVC = segue.destinationViewController;
        NSArray *availableWorlds = sender;
        [mainVC setAvailableWorlds: availableWorlds];
    }
}

#pragma mark - Delegates

@end
