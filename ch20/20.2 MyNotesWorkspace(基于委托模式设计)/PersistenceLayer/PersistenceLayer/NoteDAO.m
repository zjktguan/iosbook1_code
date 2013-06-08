//
//  NoteDAO.m
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "NoteDAO.h"


@implementation NoteDAO

//插入Note方法
-(void) create:(Note*)model
{
    
    NSURL *url = [NSURL URLWithString:[BASE_URL URLEncodedString]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [request setPostValue:@"JSON" forKey:@"type"];
    [request setPostValue:@"add" forKey:@"action"];
    [request setPostValue:model.date forKey:@"date"];
    [request setPostValue:model.content forKey:@"content"];
    
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        if ([resultCodeNumber integerValue] >=0)
        {
            [self.delegate createFinished];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString* message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *err = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            [self.delegate createFailed:err];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [self.delegate createFailed:error];
    }];
    [request startAsynchronous];
}

//删除Note方法
-(void) remove:(Note*)model
{
    NSURL *url = [NSURL URLWithString:[BASE_URL URLEncodedString]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [request setPostValue:@"JSON" forKey:@"type"];
    [request setPostValue:@"remove" forKey:@"action"];
    [request setPostValue:model.ID forKey:@"id"];
    
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        if ([resultCodeNumber integerValue] >=0)
        {
            [self.delegate removeFinished];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString* message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *err = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            [self.delegate removeFailed:err];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [self.delegate removeFailed:error];
    }];
    [request startAsynchronous];
}

//修改Note方法
-(void) modify:(Note*)model
{

    NSURL *url = [NSURL URLWithString:[BASE_URL URLEncodedString]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [request setPostValue:@"JSON" forKey:@"type"];
    [request setPostValue:@"modify" forKey:@"action"];
    [request setPostValue:model.ID forKey:@"id"];
    [request setPostValue:model.date forKey:@"date"];
    [request setPostValue:model.content forKey:@"content"];
    
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        if ([resultCodeNumber integerValue] >=0)
        {
            [self.delegate modifyFinished];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString* message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *err = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            [self.delegate modifyFailed:err];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [self.delegate modifyFailed:error];
    }];
    [request startAsynchronous];
}

//查询所有数据方法
-(void) findAll
{
    NSURL *url = [NSURL URLWithString:[BASE_URL URLEncodedString]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setPostValue:@"<你的iosbook1.com用户邮箱>" forKey:@"email"];
    [request setPostValue:@"JSON" forKey:@"type"];
    [request setPostValue:@"query" forKey:@"action"];
    
    [request setCompletionBlock:^{
        
        NSData *data  = [request responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        if ([resultCodeNumber integerValue] >=0)
        {
            NSMutableArray* listDict = [resDict objectForKey:@"Record"];
            
            NSMutableArray *listData = [NSMutableArray new];
            
            for (NSDictionary* dic in listDict) {
                Note *note = [Note new];
                note.ID = [dic objectForKey:@"ID"];
                note.date = [dic objectForKey:@"CDate"];
                note.content = [dic objectForKey:@"Content"];
                [listData addObject:note];
            }            
            [self.delegate findAllFinished:listData];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString* message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message
                                                                 forKey:NSLocalizedDescriptionKey];
            NSError *err = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            [self.delegate findAllFailed:err];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [self.delegate findAllFailed:error];
    }];
    [request startAsynchronous];
}

@end
