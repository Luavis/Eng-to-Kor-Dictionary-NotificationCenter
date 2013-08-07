//
//  LuavisDictionaryCaller.m
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "LuavisDictionaryCaller.h"

LuavisDictionaryCaller * dict_singleton = nil;

@implementation LuavisDictionaryCaller

+ (LuavisDictionaryCaller *)singleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict_singleton = [[LuavisDictionaryCaller alloc] init];
    });
    return dict_singleton;
}

- (BOOL)dbOpen
{
    NSString * path = @"/User/Library/LuavisEngDic/DicData24.sqlite";
    
    if(sqlite3_open([path UTF8String], &database) == SQLITE_OK){}
    else
    {
        NSLog(@"Err");
        return NO;
    }
    return YES;
}

- (NSArray *)dbQuerying:(NSString *)stmt
{
    NSMutableArray * ret = [NSMutableArray array];
    
    const char * sqlStatement = [stmt UTF8String];
    
    sqlite3_stmt *compiledStatement;
    
    if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
    {
        while(sqlite3_step(compiledStatement) == SQLITE_ROW)
        {
            for (int i = 0;; i++)
            {
                char * ch;
                if ((ch = (char *)sqlite3_column_text(compiledStatement, i)))
                {
                    [ret addObject:[NSString stringWithCString:ch encoding:NSUTF8StringEncoding]];
                }
                else 
                {
                    break;
                }
            }
        }
    }
    else    
    {
        NSLog(@"could not prepare statemnt: %s\n", sqlite3_errmsg(database));
    }
    
    sqlite3_finalize(compiledStatement);
    return ret;
}


- (void)dbclose
{
    sqlite3_close(database);
}

- (void)dealloc
{
    [self dbclose];
    [super dealloc];
}

@end