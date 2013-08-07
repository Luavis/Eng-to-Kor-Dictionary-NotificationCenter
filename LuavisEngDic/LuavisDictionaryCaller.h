//
//  LuavisDictionaryCaller.h
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>

@interface LuavisDictionaryCaller : NSObject
{
    sqlite3 * database;
}

+ (LuavisDictionaryCaller *)singleton;
- (BOOL)dbOpen;
- (NSArray *)dbQuerying:(NSString *)stmt;
- (void)dbclose;

@end
