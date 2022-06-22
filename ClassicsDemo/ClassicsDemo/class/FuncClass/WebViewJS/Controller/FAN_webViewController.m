//
//  FAN_webViewController.m
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/22.
//

#import "FAN_webViewController.h"
#import <WebKit/WebKit.h>
#include "FanWebViewHandleDelegateObject.h"

@interface FAN_webViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property (nonatomic,weak)WKWebView *webView;

@property (nonatomic,weak)FanWebViewHandleDelegateObject *object;


@end

@implementation FAN_webViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildSubview];
    

}


#pragma 设置UI界面
- (void)addChildSubview {
    
    [self.rightNvBarBtn setTitle:@"调用JS" forState:UIControlStateNormal];
    
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    
    

//    [configuration.userContentController addScriptMessageHandler:self name:@"Location"];
    
    FanWebViewHandleDelegateObject *object = [FanWebViewHandleDelegateObject new];
    self.object = object;
//    FAN_JSHandleObject *handleObject = [FAN_JSHandleObject new];
    [object addNameKeyArray:@[@{
        @"key":@"Location",
        @"func":NSStringFromSelector(@selector(location:)),
        @"haveObject":object.handleObject
    }] webView:webView];
    
    self.webView = webView;
    [self.view addSubview:webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.view);
        make.top.mas_equalTo(self.nvView.mas_bottom);
    }];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"jsDemo" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    //设置导航代理,监听网页加载进程
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    
    
}

#pragma WKWebviewDelegate
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"1-------在发送请求之前，决定是否跳转  -->%@",navigationAction.request);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 2 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2-------页面开始加载时调用");
}

// 3 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    /// 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
    
    NSLog(@"3-------在收到响应后，决定是否跳转");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 4 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"4-------当内容开始返回时调用");
}

// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5-------页面加载完成之后调用");
}

// 6 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"6-------页面加载失败时调用");
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"-------接收到服务器跳转请求之后调用");
}

// 数据加载发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"----数据加载发生错误时调用");
}

// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    //用户身份信息
    
    NSLog(@"----需要响应身份验证时调用 同样在block中需要传入用户身份凭证");
    
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:@""
                                                          password:@""
                                                       persistence:NSURLCredentialPersistenceNone];
    // 为 challenge 的发送方提供 credential
    [[challenge sender] useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}

// 进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"----------进程被终止时调用");
}


#pragma WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)(void))completionHandler {
    
    NSLog(@"-------web界面中有弹出警告框时调用");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
}

// 创建新的webView时调用的方法
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    NSLog(@"-----创建新的webView时调用的方法");
    return webView;
}

// 关闭webView时调用的方法
- (void)webViewDidClose:(WKWebView *)webView {
    
    NSLog(@"----关闭webView时调用的方法");
}

// 下面这些方法是交互JavaScript的方法
// JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"%@",message);
    completionHandler(YES);
}
// JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    NSLog(@"%@",prompt);
    completionHandler(@"123");
}

// 默认预览元素调用
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    
    NSLog(@"-----默认预览元素调用");
    return YES;
}

// 返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {
    
    NSLog(@"----返回一个视图控制器将导致视图控制器被显示为一个预览。返回nil将WebKit的默认预览的行为。");
    return self;
}

// 允许应用程序向它创建的视图控制器弹出
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    
    NSLog(@"----允许应用程序向它创建的视图控制器弹出");
    
}

// 显示一个文件上传面板。completionhandler完成处理程序调用后打开面板已被撤销。通过选择的网址，如果用户选择确定，否则为零。如果不实现此方法，Web视图将表现为如果用户选择了取消按钮。
- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> * _Nullable URLs))completionHandler {
    
    NSLog(@"----显示一个文件上传面板");
    
}


#pragma mark WKScriptMessageHandler
/*! @abstract Invoked when a script message is received from a webpage.
 @param userContentController The user content controller invoking the
 delegate method.
 @param message The script message received.
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"Location"]) {
        
        NSLog(@"调用了");
    }
}

- (void)location:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"Location"]) {
        
        NSLog(@"调用了");
    }
}

#pragma mark OC 调用JS

- (void)rightButtonClick:(UIButton *)sender{
    [super rightButtonClick:sender];
    
    [self.webView evaluateJavaScript:@"alertAction('OC调用了JS方法')" completionHandler:^(id _Nullable, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"OC 调用 JS 调用成功");
        }
        
    }];
    
    
}

- (void)dealloc{
    
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
    
    [self.object removeScriptMessageHandler];

}
@end
