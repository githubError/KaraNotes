//
//  UIView+CPFView.m
//  KaraNotes
//
//  Created by 崔鹏飞 on 2017/5/2.
//  Copyright © 2017年 崔鹏飞. All rights reserved.
//

#import "UIView+CPFView.h"

@implementation UIView (CPFView)

    -(UIView *)getSubviewFromString:(NSString *)name {
        
        for (UIView *subview in self.subviews) {
            if ([[subview class] isSubclassOfClass: [UIScrollView class]]) {
                for (UIView *subview2 in subview.subviews) {
                    if ([[subview2 class] isSubclassOfClass: NSClassFromString(name)]) {
                        return subview2;
                    }
                }
            }
        }
        return nil;
    }
    
@end
