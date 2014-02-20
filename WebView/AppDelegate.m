//
//  AppDelegate.m
//  WebView
//
//  Created by shenyixin on 10/15/12.
//  Copyright (c) 2012 All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize btnGoBack;
@synthesize btnGoForward;
@synthesize navbar;
@synthesize webView;


- (void) awakeFromNib {
    //设置delegate
    [webView setFrameLoadDelegate:self];
    [webView setPolicyDelegate:self];

    [[webView preferences] setPlugInsEnabled:YES];
    NSString *urlString = @"http://www.baidu.com";
    [navbar setStringValue:urlString];
    [self onGo];
}

//回车访问网站
- (IBAction)enterToGo:(id)sender {
    [self onGo];
}

//点击Go按钮访问网站
- (IBAction)clickTogo:(id)sender {
    [self onGo];
}

//加载网站
- (void)onGo{
    NSString *urlString =  [navbar stringValue];
    if(![urlString hasPrefix:@"http://"]){
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
    }
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

//开始加载,可以在这里加loading
- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
    NSString * currentURL = [webView mainFrameURL];
    [navbar setStringValue:currentURL];

}

//收到标题，把标题展示到窗口上面
- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame
{   
    // Report feedback only for the main frame.
    if (frame == [sender mainFrame]){
        [[sender window] setTitle:title];
    }
}

//加载完成
- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    //设置前进，后退按钮的状态
    if (frame == [sender mainFrame]){
        [btnGoBack setEnabled:[sender canGoBack]];
        [btnGoForward setEnabled:[sender canGoForward]];
    }
}

//错误处理
- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    
}

//错误处理
- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    
}


//网页里面target=_blank的链接，在这里捕获，并在这里控制对该事件的处理。
- (void)webView:(WebView *)sender decidePolicyForNewWindowAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request newFrameName:(NSString *)frameName decisionListener:(id < WebPolicyDecisionListener >)listener
{
    NSURL *URL = [request URL];
    //在当前窗口打开
    [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:URL]];
    //也可以用默认浏览器打开
    //[[NSWorkspace sharedWorkspace] openURL:URL];
    //或者也可以加代码，新建一个tab打开 
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
}

@end




