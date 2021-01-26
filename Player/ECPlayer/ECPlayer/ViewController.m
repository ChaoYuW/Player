//
//  ViewController.m
//  ECPlayer
//
//  Created by chao on 2021/1/26.
//

#import "ViewController.h"
#import "ECVideoEditViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (IBAction)editVideoClick:(UIButton *)sender {
    
    ECVideoEditViewController *vc = ECVideoEditViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
