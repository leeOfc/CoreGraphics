//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by leo on 2016/11/22.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView


- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    //根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    //使外层圆形成为视图的外接圆
    float maxradius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxradius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    path.lineWidth = 10;
    [[UIColor lightGrayColor] setStroke];
    [path stroke];
    
    //完成绘制工作
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    UIBezierPath *myPath =[[UIBezierPath alloc] init];
    
    [myPath moveToPoint:CGPointMake(bounds.origin.x + bounds.size.width / 2.0, bounds.origin.y + bounds.size.height / 6.0)];
    [myPath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width / 6.0, bounds.origin.y + bounds.size.height / 6.0 * 5.0)];
    [myPath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width / 6.0 * 5.0, bounds.size.height / 6.0 * 5.0)];
    [myPath addClip];
    
    
    //渐变
    CGFloat location[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 1.0, 0.0, 1.0,//其实颜色为红色
                                1.0, 1.0, 0.0, 1.0};//终止颜色为黄色
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, location, 2);
    
    CGPoint startPoint =  CGPointMake(bounds.origin.x + bounds.size.width / 2.0, bounds.origin.y +
                                      bounds.size.height / 6.0);
    
    CGPoint endPoint = CGPointMake(bounds.origin.x + bounds.size.width /2.0, bounds.origin.y +
                                   bounds.size.height / 6.0 * 5);
    
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(currentContext);
    
    //阴影
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    //图片 透明背景
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    CGRect logoRect;
    logoRect.origin.x = bounds.origin.x + bounds.size.width / 4.0;
    logoRect.origin.y = bounds.origin.y + bounds.size.height / 4.0;
    logoRect.size.width = bounds.size.width / 2.0;
    logoRect.size.height = bounds.size.height / 2.0;
    [logoImage drawInRect:logoRect];
    
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置BNRHypnosisView对象的背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}

@end
