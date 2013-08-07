//
//  LuavisEngDicLogController.m
//  LuavisEngDicLog
//
//  Created by Luavis on 12. 5. 8..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "LuavisEngDicLogController.h"


@implementation LuavisEngDicLogController

- (id)initWithSuperCon:(LuavisEngDicController *)_dicCon
{
	if ((self = [super init]))
	{
        height = 200;
        head = [[NSString alloc] initWithContentsOfFile:@"/System/Library/WeeAppPlugins/LuavisEngDic.bundle/head.html" encoding:NSUTF8StringEncoding error:nil];
        dicCon = _dicCon;
        [self loadData];
	}
    
	return self;
}


-(void)dealloc
{
	[_view release];
    [timer release];
    [engFile release];
    [head release];
    
	[super dealloc];
}

- (UITableView *)view
{
	if (_view == nil)
    {
        _view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 316, height) style:UITableViewStylePlain];
        [_view setSeparatorColor:[UIColor blackColor]];
        [_view setDelegate:self];
        [_view setDataSource:self];
        [_view setBackgroundColor:[UIColor clearColor]];
	}
    
	return _view;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [engFile count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identity = @"com.Luavis.LuavisEngDicLog";
    UITableViewCell * cell;
    
    if (!(cell = [_view dequeueReusableCellWithIdentifier:identity])) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identity];
    }
    
    cell.textLabel.text = [[engFile allKeys] objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * arr = [[NSMutableDictionary alloc] initWithDictionary:engFile];
    [arr removeObjectForKey:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    [arr writeToFile:@"/User/Library/LuavisEngDic/log" atomically:YES];
    
    [engFile release];
    engFile = nil;
    
    engFile = arr;
    [_view reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionHead = [[UILabel alloc] init];
    
    sectionHead.text = @"  LuavisEngDic";
    sectionHead.font = [UIFont boldSystemFontOfSize:12];
    sectionHead.textColor = [UIColor whiteColor];
    sectionHead.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    
    sectionHead.layer.borderColor = [UIColor blackColor].CGColor;
    sectionHead.layer.borderWidth = 1.3f;
    
    return sectionHead;
}



- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = [[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/LuavisEngDic/log"];
    NSString * context = [dict objectForKey:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    
    [[dicCon aView] showWithLoadString:[head stringByAppendingFormat:context]];
    
    return nil;
}

- (float)viewHeight
{
	return height;
}

- (void)loadData
{
    if(engFile)
    {
        [engFile release];
        engFile = nil;
    }
    
    engFile = [[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/LuavisEngDic/log"];
}

- (void)reload
{
    [self loadData];
    [_view reloadData];
}

@end