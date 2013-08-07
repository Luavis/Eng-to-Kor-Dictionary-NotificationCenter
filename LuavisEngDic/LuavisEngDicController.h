//
//  LuavisEngDicController.h
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "LuavisEngDicLogController.h"
#import "LuavisDictionaryCaller.h"
#import "LuavisAlertView.h"

@class LuavisEngDicLogController;

@interface LuavisEngDicController : NSObject <BBWeeAppController, UISearchBarDelegate>
{
    UIView *_view;
    LuavisDictionaryCaller * dictCall;
    LuavisEngDicLogController * logView;
}

@property (nonatomic, retain) LuavisAlertView * aView;

- (UIView *)view;
- (void)saveWithString:(NSString *)name withArg:(NSString *)arg;

@end