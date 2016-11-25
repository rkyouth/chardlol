//
//  CHWebViewController.m
//  chardlol
//
//  Created by Chard on 2016/11/25.
//  Copyright © 2016年 com.chard. All rights reserved.
//

#import "CHWebViewController.h"

@interface CHWebViewController () <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation CHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requesUrl]];
    [self.webView loadRequest:request];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"url : %@",[request.URL absoluteString]);
    
    return YES;
}

@end
