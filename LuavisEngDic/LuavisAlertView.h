//
//  LuavisAlertView.h
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#define __CATransform3D__
#import "SpringBoard/BBWeeAppController.h"

static int LSALERTVIEW_WIDTH = 300;
static int LSALERTVIEW_HEIGHT = 360;
static int LSALERTVIEW_BUTTON_WIDTH = 30;
static int LSALERTVIEW_BUTTON_HEIGHT = 30;

@interface LuavisAlertView : UIAlertView 
{
    UIWebView * wView;
    UIButton * cancle;
}

@property (nonatomic,assign)id <BBWeeAppController> delegate;
- (void)showWithLoadString:(NSString *)code;
- (void)buttonClick;
@end