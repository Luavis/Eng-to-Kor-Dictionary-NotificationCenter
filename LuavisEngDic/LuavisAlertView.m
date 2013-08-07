//
//  LuavisAlertView.m
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "LuavisAlertView.h"

@implementation LuavisAlertView
@synthesize delegate;

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
    if (delegate)
    {
        [delegate viewWillAppear];
    }
}

- (void)buttonClick
{
    [self dismissWithClickedButtonIndex:-1 animated:YES];
}

- (id)init
{
    self = [super init];
    if (self) 
    {        
        wView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, LSALERTVIEW_WIDTH, LSALERTVIEW_HEIGHT)];
        wView.layer.cornerRadius = 10;
        [wView setClipsToBounds:YES];
        
        cancle = [[UIButton alloc] initWithFrame:CGRectMake(LSALERTVIEW_WIDTH-LSALERTVIEW_BUTTON_HEIGHT, 0, LSALERTVIEW_BUTTON_HEIGHT, LSALERTVIEW_BUTTON_HEIGHT)];
        [cancle setImage:[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/LuavisEngDic.bundle/x.png"] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [[wView layer] setBorderColor:[[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor]];
        [[wView layer] setBorderWidth:2.75];        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView * subView in [self subviews]) 
    {
        [subView setHidden:YES];
    }
    
    self.bounds = wView.bounds;
    [self addSubview:wView];   
    [self addSubview:cancle];
}

- (void) drawRect:(CGRect)rect 
{    
    [super drawRect:rect];
}

- (void)showWithLoadString:(NSString *)code
{
    [super show];
    [wView loadHTMLString:code baseURL:nil];
}

- (void)dealloc
{
    [wView release];
    [cancle release];
    [super release];
}

@end