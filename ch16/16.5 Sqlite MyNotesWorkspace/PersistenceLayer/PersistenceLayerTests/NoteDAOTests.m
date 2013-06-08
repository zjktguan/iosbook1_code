//
//  NoteDAOTests.m
//  NoteDAOTests
//
//  Created by 关东升 on 12-10-22.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <GHUnitIOS/GHUnit.h>
#import "NoteDAO.h"
#import "Note.h"

@interface NoteDAOTests : GHTestCase {
    
}

@property (nonatomic,strong) NSDateFormatter * dateFormatter;
@property (nonatomic,strong) NoteDAO * dao;

@property (nonatomic,strong) NSString* theContent;
@property (nonatomic,strong) NSDate* theDate;

@end

@implementation NoteDAOTests

- (void)setUpClass {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.dao = [NoteDAO sharedManager];
    
    self.theContent = @"welcome www.51work6.com";
    self.theDate = [self.dateFormatter dateFromString:@"2000-06-03 08:20:38"];
}

- (void)tearDownClass {
    self.dateFormatter = nil;
    self.dao = nil;
}

- (void)setUp {}

- (void)tearDown { }


//测试 插入Note方法
-(void) testCreate
{
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    note.content = self.theContent;
    
    int res = [self.dao create:note];
    //断言 无异常，返回值为0，
    GHAssertTrueNoThrow(res == 0, @"数据插入失败");
    
}

//测试 查询所有数据方法
-(void) testFindAll
{
    NSArray* list =  [self.dao findAll];
    //断言 查询记录数为1
    GHAssertTrue([list count] == 1, @"查询记录数期望值为：1 实际值为：%i", [list count]);
    
    Note* note  = list[0];
    //断言 cdate=2000-06-0308:20:38
    GHAssertEqualObjects(self.theDate, note.date, @"日期字段期望值数为：%@ 实际值为：%@", self.theDate,note.date);
    //断言 content= welcome www.51work6.com
    GHAssertEqualObjects(self.theContent, note.content, @"内容字段期望值数为：%@ 实际值为：%@", self.theContent,note.content);
}

//测试 按照主键查询数据方法
-(void) testFindById
{
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果非nil
    GHAssertNotNil(resNote, @"查询记录为nil");
    //断言 cdate=2000-06-0308:20:38
    GHAssertEqualObjects(note.date , resNote.date, @"日期字段期望值数为：%@ 实际值为：%@",  note.date ,resNote.date);
    //断言 content= welcome www.51work6.com
    GHAssertEqualObjects(self.theContent, resNote.content, @"内容字段期望值数为：%@ 实际值为：%@", self.theContent,resNote.content);
}

//测试 修改Note方法
-(void) testModify
{
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    note.content = @"www.51work6.com";
    
    int res = [self.dao modify:note];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果非nil
    GHAssertNotNil(resNote, @"查询记录为nil");
    //断言 cdate=2000-06-0308:20:38
    GHAssertEqualObjects(note.date , resNote.date, @"日期字段期望值数为：%@ 实际值为：%@",  note.date ,resNote.date);
    //断言 content=www.51work6.com
    GHAssertEqualObjects(note.content, resNote.content, @"内容字段期望值数为：%@ 实际值为：%@", note.content,resNote.content);
}


//测试 删除数据方法
-(void) testRemove
{
    //创建Note对象
    Note *note = [[Note alloc] init];
    note.date  = self.theDate;
    
    int res =   [self.dao remove:note];
    //断言 无异常，返回值为0
    GHAssertTrueNoThrow(res == 0, @"数据修改失败");
    
    Note* resNote = [self.dao findById:note];
    //断言 查询结果nil
    GHAssertNil(resNote, @"记录删除失败");
    
}


@end
