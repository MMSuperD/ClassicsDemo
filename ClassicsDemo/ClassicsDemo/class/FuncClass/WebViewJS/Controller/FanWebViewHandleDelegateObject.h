//
//  FanWebViewHandleDelegateObject.h
//  ClassicsDemo
//
//  Created by 王丹 on 2022/6/22.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
@class FAN_JSHandleObject;

@interface FanWebViewHandleDelegateObject : NSObject<WKScriptMessageHandler>

@property (nonatomic,strong)FAN_JSHandleObject *handleObject;


/// 添加webview 与JS交互的方法
/// @param dictArray
/// @param webView

/*
 dictArray = @[@{
 @"key": "和h5关联的字段",
 @"func": "本地和当前字段关联的函数字符串",
 @"haveObject":@""
}];
 */
- (void)addNameKeyArray:(NSArray<NSDictionary *> *)dictArray webView:(WKWebView *)webView;

// 这个方法在 webViewController dealloc 时候调用,不调用的话就会造成内存泄漏
- (void)removeScriptMessageHandler;




@end


@interface FAN_JSHandleObject : NSObject

@end

NS_ASSUME_NONNULL_END
