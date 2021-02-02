//
//  MainViewController.m
//  ChartView
//
//  Created by chao on 2020/10/8.
//

#import "MainViewController.h"
#import "ECVideoEditViewController.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *menuMuAry;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat navHeight = 64;
    if (@available(iOS 11.0, *))
    {
            UIWindow *mainWindow = [[UIApplication sharedApplication].windows firstObject];
            if (mainWindow.safeAreaInsets.bottom > 0.0) {
                navHeight = 88;
            }
    }else
    {
        navHeight = 64;
    }
    self.myTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-navHeight);
    
    
    [self.view addSubview:self.myTableView];
    
    self.menuMuAry = [NSMutableArray arrayWithObjects:
                      @"视频裁剪",
                      @"分时图",
                      nil];
    
    
    
    
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuMuAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.menuMuAry[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.menuMuAry[indexPath.row];
    if ([text isEqualToString:@"视频裁剪"]) {
        ECVideoEditViewController *vc = ECVideoEditViewController.new;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([text isEqualToString:@"分时图"])
    {
        
    }
}
- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
@end
