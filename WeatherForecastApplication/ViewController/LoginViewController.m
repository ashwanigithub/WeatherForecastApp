//
//  LoginViewController.m
//  WeatherForecastApplication
//
//  Created by Ashwin Sharma  on 03/09/17.
//  Copyright © 2017 asap. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "WeatherViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end

@implementation LoginViewController

- (IBAction)loginBtnAction:(id)sender {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
//    [loginManager logInWithReadPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        //TODO: process error or result.
        if (error) {
            NSLog(@"Process error");
            [self facebookLoginFailed:YES];
        } else if (result.isCancelled) {
            [self facebookLoginFailed:NO];
        } else {
            if ([FBSDKAccessToken currentAccessToken]) {
                NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id,name,email,first_name,last_name,picture.type(large)" forKey:@"fields"];
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         
                         NSString *userEmailID = [result objectForKey:@"email"];
                         NSString *valueToSave = userEmailID;
                         [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceEmailID"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                             WeatherViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"WeatherViewControllerID"];
                             [self presentViewController:add animated:YES completion:nil];
                         });

                     }
                 }];
            }
            else {
                [self facebookLoginFailed:YES];
            }
        }
    }];
}
- (void)facebookLoginFailed:(BOOL)isFBResponce{
    if(isFBResponce){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"request_error", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"login cancelled", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceEmailID"];

    if ( ( ![savedValue isEqual:[NSNull null]] ) && ( [savedValue length] != 0 ) ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                WeatherViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"WeatherViewControllerID"];
                [self presentViewController:add animated:YES completion:nil];
            });
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"User Not Valid", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [alert show];
    }



    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

