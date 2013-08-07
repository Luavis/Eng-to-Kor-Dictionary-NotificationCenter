//
//  LuavisEngDicLogController.h
//  LuavisEngDicLog
//
//  Created by Luavis on 12. 5. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define __CATransform3D__
#import <QuartzCore/QuartzCore.h>
#import "SpringBoard/BBWeeAppController.h"
#import "LuavisEngDicController.h"

@class LuavisEngDicController;

@interface LuavisEngDicLogController : NSObject <BBWeeAppController, UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_view;
    
    float height;
    NSTimer * timer;
    NSDictionary * engFile;
    NSString * head;
    
    LuavisEngDicController * dicCon;
}
- (id)initWithSuperCon:(LuavisEngDicController *)_dicCon;
- (UITableView *)view;
- (void)loadData;
- (void)reload;

@end