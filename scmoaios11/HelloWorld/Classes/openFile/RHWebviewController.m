//
//  RHWebviewController.m
//  EaseChat
//
//  Created by 刘威举 on 12/4/15.
//  Copyright © 2015 刘威举. All rights reserved.
//

#import "RHWebviewController.h"
#import "RHWebViewProgress.h"

static const CGFloat kProgressBarHeight = 3;     // 进度条高度

@interface RHWebviewController ()<NSURLConnectionDelegate>

/**
 *  加载进度条
 */
@property (nonatomic, strong) RHWebViewProgress *progressView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *fileServerUrl;

@property (nonatomic, strong) UIView *coverView; //加载时出现蒙层

@property (nonatomic, strong) UIActivityIndicatorView *loadVIew; //系统自带小菊花转转转

@property (nonatomic, assign) BOOL stopLoadingFlag; // 遮罩停止加载标识

@property (nonatomic, strong) UIView *loadFailView;                     // 加载失败view
@property (nonatomic, strong) UIImageView *loadFailRefreshImageView;    // 网络出错显示图标
@property (nonatomic, strong) UILabel *loadFailRefreshLabel;            // 网络出错显示文字

@end

@implementation RHWebviewController

#pragma mark - lifecycle method
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(webViewStopLoading:)
                                                 name:@"webViewStopLoading"
                                               object:nil];
    [self setUpViews];
}

- (void)setUpViews {
    [self.view addSubview:self.loadFailView];
    [self hideFailureView];
    
    self.view.clipsToBounds = YES;
    [self.view addSubview:self.coverView];
    [self showLoading];
    
    [self setUpBarButtonItem];
    //进度条
    [self.navigationController.navigationBar addSubview:self.progressView];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURLRequest* appReq = [NSURLRequest requestWithURL:[NSURL URLWithString:self.openUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    [self.webView loadRequest:appReq];
}

- (void)setUpBarButtonItem {
//    UIBarButtonItem *leftBarButton  =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(disMissViewController)];
//    leftBarButton.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftBarButton;

    UIBarButtonItem *leftBarItem = [UIBarButtonItem customLeftItemWithImage:@"" highImage:@"" target:self action:@selector(disMissViewController)];
     [self.navigationItem addLeftBarButtonItem:leftBarItem];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)disMissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.progressView.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.progressView removeFromSuperview];
}

#pragma mark - init method

- (RHWebViewProgress *)progressView {
    if (!_progressView) {
        CGFloat progressBarHeight = kProgressBarHeight;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height, navigaitonBarBounds.size.width, progressBarHeight);
        _progressView = [[RHWebViewProgress alloc] initWithFrame:barFrame];
        _progressView.progressColor = [UIColor colorWithRed:55 /255.0 green:177 /255.0 blue:44 /255.0 alpha:0.8];
        [_progressView displayStartAnimation];
    }
    return _progressView;
}


- (UIView * )coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectZero];
        _coverView.frame = CGRectMake(0, 44, screenWidth, screenHeight-44);
        _coverView.backgroundColor = [UIColor colorWithRed:90 /255.0 green:90 /255.0 blue:90 /255.0 alpha:0.4];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapDissappear = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLoading)];
        [_coverView addGestureRecognizer:tapDissappear];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        titleLabel.frame = CGRectMake((screenWidth - 120) * 0.5, screenHeight * 0.5+15, 120, 40);
        titleLabel.text = @"加载中...";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_coverView addSubview:titleLabel];
        [_coverView addSubview:self.loadVIew];
    }
    return _coverView;
}

- (UIActivityIndicatorView *)loadVIew {
    if (!_loadVIew) {
        _loadVIew = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.loadVIew.hidden = NO;
        CGFloat loadViewX = (self.coverView.width - self.loadVIew.width) * 0.5;
        CGFloat loadViewY = (self.coverView.height - self.loadVIew.height) * 0.5;
        self.loadVIew.x = loadViewX;
        self.loadVIew.y = loadViewY;
        _loadVIew.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    }
    return _loadVIew;
}

- (UIView *)loadFailView {
    if (!_loadFailView) {
        _loadFailView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
        _loadFailView.backgroundColor = [UIColor whiteColor];
        [_loadFailView addSubview:self.loadFailRefreshImageView];
        [_loadFailView addSubview:self.loadFailRefreshLabel];
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refresh:)];
        [_loadFailView addGestureRecognizer:gesture];
    }
    return _loadFailView;
}

- (UIImageView *)loadFailRefreshImageView {
    if (!_loadFailRefreshImageView) {
        _loadFailRefreshImageView = [[UIImageView alloc]init];
        _loadFailRefreshImageView.frame = CGRectMake((screenWidth - 120) / 2, 80, 120, 120);
        _loadFailRefreshImageView.image = [UIImage imageNamed:@"WebView_LoadFail_Refresh_Icon"];
    }
    return _loadFailRefreshImageView;
}

- (UILabel *)loadFailRefreshLabel {
    if (!_loadFailRefreshLabel) {
        _loadFailRefreshLabel = [[UILabel alloc]init];
        _loadFailRefreshLabel.textColor = [UIColor lightGrayColor];
        UIFont *textFont = [UIFont systemFontOfSize:12];
        NSString *title = @"网络出错，轻触屏幕重新加载";
        _loadFailRefreshLabel.text = title;
        _loadFailRefreshLabel.font = textFont;
        CGSize size = [title boundingRectWithSize:CGSizeMake(screenWidth, MAXFLOAT) andFont:textFont].size;
        CGFloat x = (screenWidth - size.width) / 2;
        CGFloat y = CGRectGetMaxY(self.loadFailRefreshImageView.frame) + 20;
        _loadFailRefreshLabel.frame = CGRectMake(x, y, size.width, size.height);
    }
    return _loadFailRefreshLabel;
}

#pragma mark - private method

- (void)webViewStopLoading:(NSNotification *)center {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)[center object];
    if (!self.stopLoadingFlag) {
        self.stopLoadingFlag = YES;
        [self hideLoading];
        if (response) {
            NSInteger statusCode = response.statusCode;
            if (statusCode != 200) {
                // 失败
                [self showFailureView];
            }
        }
    }
}



- (void)showLoading {
    [self.view addSubview:self.coverView];
    self.coverView.hidden = NO;
    [self.coverView addSubview:self.loadVIew];
    [self.loadVIew startAnimating];
}
- (void)hideLoading {
    if (!self.coverView.hidden) {
        [self.loadVIew stopAnimating];
        self.coverView.hidden = YES;
    }
}

- (void)showFailureView {
    self.loadFailView.hidden = NO;
}

- (void)hideFailureView {
    self.loadFailView.hidden = YES;
}

- (void)refresh:(UITapGestureRecognizer *)sender {
    if (self.webView.isLoading) {
        return;
    }
    self.stopLoadingFlag = NO;
    [self showLoading];
    [self hideFailureView];
    [self.webView reload];
    [self.progressView displayStartAnimation];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

//加载完成
- (void)webViewDidFinishLoad:(UIWebView*)theWebView {
    [self hideLoading];
    if (!self.title) {
        NSString *title = [theWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if (title) {
            self.title = title;
        }
    }
    [self.progressView setProgress:1.0];
    //支持缩放
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"", theWebView.frame.size.width];
    [theWebView stringByEvaluatingJavaScriptFromString:meta];
    
    // Disable user selection
    [theWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [theWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideLoading];
    [self showFailureView];
    self.stopLoadingFlag = NO;
    [self.progressView setProgress:1.0];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"webViewStopLoading" object:nil];
}
@end
