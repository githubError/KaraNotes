//
//  UIWebView+Extension.m
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

#import "UIWebView+Extension.h"

@implementation UIWebView (Extension)

- (UIView *)getUIWebBrowserView {
    
    for (UIView *subview in self.subviews) {
        if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
            for (UIView *subview_2 in subview.subviews) {
                if ([[subview_2 class] isSubclassOfClass: NSClassFromString(@"UIWebBrowserView")]) {
                    return subview_2;
                }
            }
        }
    }
    return nil;
}
    
@end
