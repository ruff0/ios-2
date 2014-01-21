//
//  RecoveryPasswordViewController.h
//  trongvm
//
//  Created by Vinh Huynh on 10/2/12.
//
//

#import <UIKit/UIKit.h>

@interface RecoveryPasswordViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *emailField;
- (IBAction)recoveryPasswordAcction:(id)sender;
- (IBAction)cancelAcction:(id)sender;
- (IBAction)hideKeyBoard:(id)sender;

- (IBAction)touchUpInsideBack:(id)sender;
@end
