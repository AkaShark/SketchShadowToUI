//
//  ViewController.m
//  Sketch
//
//  Created by Sharker on 2021/1/17.
//

#import "ViewController.h"

@interface CALayer (ShadowSetting)

- (void)sky_setShadowColor:(UIColor *)color alpha:(CGFloat)alpha
                         x:(CGFloat)x
                         y:(CGFloat)y
                      blur:(CGFloat)blur
                    spread:(CGFloat)spread;

@end


@implementation CALayer (ShadowSetting)

/// stkech阴影转UI
/// @param color 阴影的颜色
/// @param alpha 阴影的透明度
/// @param x x偏移
/// @param y y偏移
/// @param blur 阴影模糊  (还是阴影圆角 看api解释是圆角 多做下实验)
/// @param spread 阴影拓展
- (void)sky_setShadowColor:(UIColor *)color alpha:(CGFloat)alpha x:(CGFloat)x y:(CGFloat)y blur:(CGFloat)blur spread:(CGFloat)spread {
    self.shadowOffset = CGSizeMake(x, y);
    self.shadowRadius = blur / 2;
    self.shadowColor = color.CGColor;
    self.shadowOpacity = alpha;
    
    CGRect rect = [self insetBy: self.bounds dx: -spread dy: -spread];
    self.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
}

// 阴影扩展的设置
- (CGRect)insetBy:(CGRect)rect dx:(CGFloat)x dy:(CGFloat)y {
    CGFloat origin_x = rect.origin.x, origin_y = rect.origin.y;
    origin_x += x;
    origin_y += y;
    CGFloat originW = rect.size.width, originH = rect.size.height;
    originW -= 2 * x;
    originH -= 2 * y;
    rect =  CGRectMake(x, y, originW, originH);
    
    return rect;
}


@end



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(40, 100, 100, 100)];
    shadowView.backgroundColor = [UIColor whiteColor];
    
    // spread对应sketch里面的阴影拓展
    CGFloat spread = 10.0f;
    CGRect rect = CGRectMake(0, 0, 100, 100);
    rect = [self insetBy:rect dx: -spread dy: -spread];
    
    shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
    // 颜色是黑色
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    //  alpha 50%
    shadowView.layer.shadowOpacity = 0.5;
    // x: 0 y: 10
    shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    // 对应Sketch里面阴影的模糊设置 值是20/2 = 10
    shadowView.layer.shadowRadius = 10;
    
    [self.view addSubview:shadowView];
     
    
}

- (CGRect)insetBy:(CGRect)rect dx:(CGFloat)x dy:(CGFloat)y {
    CGFloat origin_x = rect.origin.x, origin_y = rect.origin.y;
    origin_x += x;
    origin_y += y;
    CGFloat originW = rect.size.width, originH = rect.size.height;
    originW -= 2 * x;
    originH -= 2 * y;
    rect =  CGRectMake(x, y, originW, originH);
    
    return rect;
}


@end
