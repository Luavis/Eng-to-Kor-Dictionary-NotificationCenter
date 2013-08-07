//
//  LuavisEngDicController.m
//  LuavisEngDic
//
//  Created by Luavis on 12. 5. 3..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "LuavisEngDicController.h"

@implementation LuavisEngDicController
@synthesize aView;

-(id)init
{
	if ((self = [super init]))
	{
//        logView = [[LuavisEngDicLogController alloc] initWithSuperCon:self];
        dictCall = [LuavisDictionaryCaller singleton];
        [dictCall dbOpen];
	}

	return self;
}

-(void)dealloc
{
    [dictCall dealloc];
    [_view release];
    
    if(aView)
    {
        [aView release];
    }
    
	[super dealloc];
}



- (UIView *)view
{
	if (_view == nil)
	{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            _view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 440, 66.0f)];//+ [logView viewHeight])];
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            _view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 320, 66.0f)];//+ [logView viewHeight])];
        }
        else 
        {
            _view = nil;
            NSLog(@"Unknown ");
            exit(0);
        }
        
        
		UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/LuavisEngDic.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        
		UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            bgView.frame = CGRectMake(0, 0, 440, 66.0f);
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            bgView.frame = CGRectMake(0, 0, 320, 66.0f);
        }
        else 
        {
            bgView = nil;
            NSLog(@"Unknown ");
            exit(0);
        }
        
		[_view addSubview:bgView];
		
        [bgView release];
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 440, 20)];
		lbl.backgroundColor = [UIColor clearColor];
		lbl.textColor = [UIColor whiteColor];
		
        NSLocale *locale = [NSLocale currentLocale];
        NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
        
        if([countryCode isEqualToString:@"KR"])
        {
            lbl.text = @"영어 사전";
        }
        else 
        {
            lbl.text = @"Korean Dictionary";
        }
        
		lbl.textAlignment = UITextAlignmentCenter;
		[_view addSubview:lbl];
		[lbl release];
        
        
        UISearchBar * bar;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 22, 440, 40)];
        }
        else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            bar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 22, 310, 40)];
        }
        else 
        {
            bar = nil;
            NSLog(@"Unknown ");
            exit(0);
        }
        
        
        bar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
//        for (UIView *subview in bar.subviews)
//        {
//            if ([subview conformsToProtocol:@protocol(UITextInputTraits)])
//            {
//                [(UITextField *)subview setClearButtonMode:UITextFieldViewModeWhileEditing];
//            }
//        }
        
        [bar setDelegate:self];
        [[[bar subviews] objectAtIndex:0] removeFromSuperview];
        
        [_view addSubview:bar];
        [bar release];        
        
// Log View;        
//        UITableView * viewForlog = (UITableView *)[logView view];
//        
//        [viewForlog setUserInteractionEnabled:YES];
//        [viewForlog setFrame:CGRectMake(0, 66.0f, 316, [logView viewHeight])];
//        
//        [_view addSubview:viewForlog];
//        [viewForlog release];
	}
    
	return _view;
}

- (float)viewHeight
{
	return 66.0f;// + [logView viewHeight];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{    
    NSString * head = [[NSString alloc] initWithContentsOfFile:@"/System/Library/WeeAppPlugins/LuavisEngDic.bundle/head.html" encoding:NSUTF8StringEncoding error:nil];
    NSString * stringForWhatYouFind = [[searchBar text] lowercaseString];
    NSString * perfix = [stringForWhatYouFind substringToIndex:1];
    
    [searchBar resignFirstResponder];
    
    for ( int i=0; i<[stringForWhatYouFind length];i++) {
        unichar oneCode = [stringForWhatYouFind characterAtIndex:i];
        if ( oneCode >= 0xAC00 && oneCode <= 0xD7A3 ) 
        {
            [aView showWithLoadString:[NSString stringWithFormat:@"<html><head></head><body link=\"green\" vlink=\"green\" alink=\"green\">&nbsp;&nbsp;<DIV style=\"TEXT-ALIGN: center\">=한영 사전은 지원 하지 않습니다.=</DIV>&nbsp;&nbsp;<DIV style=\"TEXT-ALIGN: center\"><a href=\"http://endic.naver.com/popManager.nhn?m=search&searchOption=&query=%@\" target=\"_blank\">네이버 사전으로 이동</a></DIV>",[stringForWhatYouFind stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            [head release];
            return;
        }
    }
    
    
    NSArray * ar = [dictCall dbQuerying:[NSString stringWithFormat:@"select korean from english_korean_google_%@ where english=\'%@\'",perfix,stringForWhatYouFind]];    
    
    if ([ar count]>0) 
    {
        [self saveWithString:stringForWhatYouFind withArg:[ar objectAtIndex:0]];
        [aView showWithLoadString:[head stringByAppendingString:[ar objectAtIndex:0]]];
        [logView reload];
    }
    else 
    {
        [aView showWithLoadString:[head stringByAppendingString:@"&nbsp;&nbsp;<DIV style=\"TEXT-ALIGN: center\">=결과가 없습니다.=</DIV>"]];
    }
    
    [head release];
}

- (void)saveWithString:(NSString *)name withArg:(NSString *)arg
{
    NSMutableDictionary * arr = [NSMutableDictionary dictionaryWithContentsOfFile:@"/User/Library/LuavisEngDic/log"];
    
    if(!arr)
    {
        arr = [NSMutableDictionary dictionary];
    }
    
    [arr setObject:arg forKey:name];
    [arr writeToFile:@"/User/Library/LuavisEngDic/log" atomically:YES];
}


- (void)viewWillAppear
{
    if(aView)
    {
        [aView release];
    }
    
    aView = [[LuavisAlertView alloc] init];
    aView.delegate = self;
}

- (void)viewWillDisappear
{
    [aView dismissWithClickedButtonIndex:-1 animated:YES];
}

@end