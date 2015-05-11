//
//  BaseViewController.m
//  RongYun
//
//  Created by 于君 on 15/5/7.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "BaseViewController.h"
#import "WHResult.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lifeState = WYViewLifeCircleState_DidLoad;
    [self allocData];
    [self configSubviews];
}
//leon.begin
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WYPageManager sharedInstance].currentViewController = self;
    
    _lifeState = WYViewLifeCircleState_WillAppear;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [WYPageManager sharedInstance].needNibFile = YES;
    [WYPageManager sharedInstance].currentLoadedViewController = self;
    
#if !(TARGET_IPHONE_SIMULATOR)
//    [[BaiduMobStat defaultStat] pageviewStartWithName:self.trackTitle];
#endif

    _lifeState = WYViewLifeCircleState_DidAppear;
    //MLOG(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    //leon.end
    
}
//leon.begin
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _lifeState = WYViewLifeCircleState_WillDisappear;

    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

//leon.end

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#if !(TARGET_IPHONE_SIMULATOR)
//    [[BaiduMobStat defaultStat] pageviewEndWithName:self.trackTitle];
#endif
    
    //leon.begin
    _lifeState = WYViewLifeCircleState_DidDisappear;
    
}
- (void)awakeFromNib
{
    
}

#pragma mark -private method
- (void)allocData;
{
    self.httpRequest = [WHHttpClient defaultClient];
    self.dataArray = [NSMutableArray array];
}
- (void)requestData
{
    
}
- (void)configSubviews;
{
//    [self setNavigationBarAppearance:NO];
//    self.view.backgroundColor = RGB(236.0, 235.0, 232.0);
    if (IS_IOS7_OR_LATER) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self.navigationController.childViewControllers count] > 1) {
//        [self addNavBackButtonWithDefaultAction];
    }
//    self.navigationController.navigationBar.translucent = NO;
    
    self.errorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    self.errorView.backgroundColor = [UIColor whiteColor];
    UIImageView *errorImage = [[UIImageView alloc]initWithImage:ImageFile(@"ima_nodate", @"png") highlightedImage:ImageFile(@"ima_nodate", @"png") ];
    errorImage.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/3);
    self.errorView.userInteractionEnabled = YES;
    
    UILabel *errorLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(errorImage.frame)+15, SCREENWIDTH, 30)];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"点击屏幕，重新加载" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSShadowAttributeName:shadow,NSLigatureAttributeName:@(0.5),NSStrokeWidthAttributeName:@(3),NSObliquenessAttributeName:@(0)}];
    
    errorLB.textAlignment = NSTextAlignmentCenter;
    errorLB.attributedText = str;
    
    [self.errorView addSubview:errorLB];
    [self.errorView addSubview:errorImage];
    [self.view addSubview:self.errorView];
    [self.view bringSubviewToFront:self.errorView];
    
    UITapGestureRecognizer *tapError = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapErrorAction:)];
    [self.errorView addGestureRecognizer:tapError];
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = NO;
    errorImage.translatesAutoresizingMaskIntoConstraints = NO;
    errorLB.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_errorView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_errorView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_errorView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_errorView)]];
    [self.errorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[errorLB]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(errorLB)]];
//    [self.errorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[errorImage(%f)]",(SCREENWIDTH-errorImage.frame.size.width)/2,errorImage.frame.size.width] options:0 metrics:nil views:NSDictionaryOfVariableBindings(errorImage)]];
//    [self.errorView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[errorImage][errorLB]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(errorImage,errorLB)]];
    [self.errorView addConstraint:[NSLayoutConstraint constraintWithItem:errorImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.errorView attribute:NSLayoutAttributeCenterX  multiplier:1 constant:0]];
    
    [self.errorView addConstraint:[NSLayoutConstraint constraintWithItem:errorImage attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:self.errorView attribute:NSLayoutAttributeCenterY multiplier:1 constant:-70]];
    [self.errorView addConstraint:[NSLayoutConstraint constraintWithItem:errorLB attribute:NSLayoutAttributeCenterYWithinMargins relatedBy:NSLayoutRelationEqual toItem:errorImage attribute:NSLayoutAttributeCenterY multiplier:1 constant:65]];
    
}
- (void)viewWillLayoutSubviews
{
    
}
#pragma mark -User interacton
- (void)tapErrorAction:(UITapGestureRecognizer *)gesture
{
    [self.view sendSubviewToBack:self.errorView];
}

#pragma mark -Public method
- (void)setRightBarButtonItemWithText:(NSString *)text imageName:(NSString *)image
{
    UIBarButtonItem *rigthBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = rigthBar;
}
- (void)setLeftBarButtonItemWithText:(NSString *)text imageName:(NSString *)image respond:(void(^)(UIBarButtonItem *leftItem))action;
{
    
    self.title = @"";
    UIButton *titleBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBT setTitle:text forState:UIControlStateNormal];
    if (image) {
        [titleBT setImage:ImageFile(image, @"png") forState:UIControlStateNormal];
        [titleBT setImage:ImageFile(image, @"png") forState:UIControlStateHighlighted];
    }else
    {
        [titleBT setImage:ImageFile(@"ima_nodate", @"png") forState:UIControlStateNormal];
    }
    [titleBT addTarget:self action:@selector(barButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    titleBT.titleLabel.font = NavigationTitleFont;
    [titleBT setTitleEdgeInsets:UIEdgeInsetsMake(0, -80,0, 5)];
    [titleBT setImageEdgeInsets:UIEdgeInsetsMake(8, 0, 8, 80)];
    titleBT.frame = CGRectMake(0, 0, 120, 44);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:titleBT];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)requestPostWithRelativeUrl:(NSString *)url parameters:(NSDictionary *)dic prepareExecute:(PrepareExecuteBlock) prepare success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    [self.httpRequest requestWithPath:url method:RTHttpRequestPost parameters:dic prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            success(task,responseObject);
            WHResult *result = [[WHResult alloc]initWithDict:responseObject];
            if (result.code==1) {
                success(task,responseObject);
            }else
            {
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(task,error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}
- (void)setNavigationBarAppearance:(BOOL)isDefaultBlue{
    if (isDefaultBlue) {
        UIColor *titleColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        UIFont *titleFont = [UIFont systemFontOfSize:20.0];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:titleColor,
           NSFontAttributeName:titleFont}];
        UIImage *barBackgroundImage = [[UIImage imageNamed:@"general_nav_bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        [self.navigationController.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        UIColor *titleColor = RGB(45, 129, 219);
        UIFont *titleFont = [UIFont boldSystemFontOfSize:20.0];
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:titleColor,
           NSFontAttributeName:titleFont}];
        UIImage *barBackgroundImage = [[UIImage imageNamed:@"default_bg_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.navigationController.navigationBar setBackgroundImage:barBackgroundImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) { // 首先要判断版本号，否则在iOS 6 以下的版本会闪退
        //    以下三个语句随便哪句都可以实现
        self.navigationController.navigationBar.clipsToBounds = !isDefaultBlue;
        //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        //    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    }
}

//leon.begin
#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(self.lifeState <= WYViewLifeCircleState_WillAppear){
        return NO;
    }
    
    BOOL bRet = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if([self.navigationController.viewControllers count] > 1){
            bRet = YES;
        }
        else{
            bRet = NO;
        }
    }
    return bRet;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
//leon.end
#pragma mark Interface orientation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    return NO;
}



@end
