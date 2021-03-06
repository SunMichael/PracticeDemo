//
//  ViewController.m
//  TestExtern
//
//  Created by keyrun on 14-5-9.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "BGView.h"
#import "CoderModel.h"
#import "Header.h"
#import "RenameViewController.h"
#import "Student.h"
#import "TTViewController.h"
#import "UIButton+ClickArea.h"
#import "SecController.h"
#import <objc/runtime.h>
#import "NSObject+Observe.h"
#import "UIImage+RoundedCorner.h"
#import "UIView+RoundedCorner.h"

const NSString* externConstString = @"first";

extern NSString* url;


@interface Message : NSObject

@property (nonatomic, copy) NSString *text;

@end

@implementation Message

@end



@interface RenameViewController () {
    NSString* nomalString;
    UIView* view;
    __block float angleValue;
    __block BGView* yellow;
    Message *msg;
}
@end

@implementation RenameViewController
@synthesize isAllowOrNot = aisallowornot;
- (void)extracted_method:(NSString*)arg
{
    self.view.backgroundColor = [UIColor whiteColor];
    aisallowornot = YES;

    NSLog(@" %d  %d ", self.isAllowOrNot, aisallowornot);
    url = @"asdsad";

    staticString = @"new static";
    constString2 = @"new const";

    //   constString =@"new constr";
    externConstString = @"new extern";
    NSLog(@"extern %@ const %@ const2 %@  static %@", externConstString, constString, constString2, staticString);
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@" runloop3 %@",[NSRunLoop currentRunLoop]);
    [self testForGCDSemaphore];
    [self extracted_method:nil];

    struct SSPoint aPoint;
    aPoint.x = 10;

//    self.scrollView.hidden = YES;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width, scroll.frame.size.height)];
    scroll.delegate = self;
    [self.view addSubview:scroll];
    

    [[BGView appearance] setBackColor:[UIColor orangeColor]];
    yellow = [[BGView alloc] initWithFrame:CGRectMake(50, 50, 232, 232)];
//    [yellow addCorner:5.f borderWidth:1.f backgroundColor:[UIColor clearColor] borderColor:[UIColor orangeColor]];
    [yellow addCorner];
    [self.view addSubview:yellow];
//    yellow.backColor = [UIColor yellowColor];

    view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 232, 232)];
    UIImage *imgae = [UIImage imageNamed:@"hothead@2x"];
    imgae = [imgae sh_imageWithRoundedCornersAndSize:imgae.size andRoundedRadius:5.f];
    UIImageView* head = [[UIImageView alloc] initWithImage: imgae];
    head.frame = CGRectMake(50, 150, imgae.size.width, imgae.size.height);
    [self.view addSubview:head];

    UIImageView* head2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"connect_view_head"]];
    head2.frame = CGRectMake(232 / 2 - 59 / 2, 0, 59, 17);
    [view addSubview:head2];

    view.layer.cornerRadius = view.frame.size.width / 2;

    [self.view addSubview:view];

    [self change];

    [self testForKVO];
    [self testForAddButtonClickArea];
    [self testForMutableCopy];

    //    [self testForURLSession];

    [self testForKVC];
}
- (void)testForKVC
{
//    NSDictionary* dic = @{ @"key" : @"value1",
//        @"key2" : @"value2" };
    //以下是测试观察依赖键
    Student *student = [[Student alloc] init];
    student.age = 20;
    CoderModel* model = [[CoderModel alloc] init:student];
    [model addObserver:self forKeyPath:@"information" options:NSKeyValueObservingOptionNew context:nil];
    student.age = 10;
    model.weakstr = @"assign";
    NSLog(@" model: %@ ", model);
    
    //如果数组里的是对象类 有基本数据属性amount  也可以 把self替换成amount
    //集合运算符，简单集合运算符共有@avg，@count，@max，@min，@sum5种
    NSArray* arr = @[ @10, @23, @9 ];
    NSLog(@" max: %@ ", [arr valueForKeyPath:@"@max.self"]);
    
    [model removeObserver:self forKeyPath:@"information"];
}


- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}
/**
*  增大button可点击区域
*/
- (void)testForAddButtonClickArea
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100.0f, 300.0f, 50.0f, 50.0f);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    btn.need = YES;
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn setClickAreaWithTop:20.0f left:20.0f bottom:20.0f right:20.0f];
    NSLog(@" btn need  %d",btn.need);
    btn.adress = @"adress";
    
    [btn addObserver:self forKeyPath:@"adress" options:NSKeyValueObservingOptionNew context:nil];
    btn.adress = @"new adress";
    
    [btn removeObserver:self forKeyPath:@"adress"];
}
- (void)btnClicked
{
    NSLog(@" clicked  ");
    TTViewController* tt = [[TTViewController alloc] init];
    SecController *secVC = [[SecController alloc] init];
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [mArray addObject:tt];
    [mArray addObject:secVC];
    [self.navigationController setViewControllers:mArray animated:YES];
//    [self presentViewController:tt animated:YES completion:^{
//
//    }];
}

/**
*  测试copy和mutableCopy
*/
- (void)testForMutableCopy
{
    NSString* string = @"ABC";
    NSString* copyString = [string copy];
    NSMutableString* mCopyString = [string mutableCopy];
    string = @"DEF";
    NSLog(@" string: %@ , copy: %@ ,mcopy: %@  ", string, copyString, mCopyString);

    NSMutableString* mString = [NSMutableString stringWithFormat:@"mutableString"];
    NSMutableString* copyMString = [mString mutableCopy];
    NSString* copyStringm = [mString copy];
    mString = [NSMutableString stringWithFormat:@"changeMutableString"];
    NSLog(@" mstring:%@  , copy:%@ , mcopy:%@ ", mString, copyMString, copyStringm);

    //只有不可变对象的copy是指针拷贝（浅复制），其他情况都是内容拷贝（深复制）。
    id immutableObject, mutableObject;
    [immutableObject copy]; // 浅复制
    [immutableObject mutableCopy]; //单层深复制
    [mutableObject copy]; //单层深复制
    [mutableObject mutableCopy]; //单层深复制

    //@property()中copy的修饰，是指不管传过来的是可变的还是不可变的对象，本身都会持有一份对象不可变的副本
}

/**
*  测试KVO
*/
- (void)testForKVO
{
    Student* student = [[Student alloc] init];
    student.age = 18;
    student.sex = YES;
    student.name = @"jason";
    student.location = @"location";
   
    NSLog(@" property location: %@  %@ ", [student class],[Student class]);
    NSArray* allStudent = @[ student ];
    // 归档模型对象
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* path = [documentPath stringByAppendingPathComponent:@"student.plist"];
    BOOL success = [NSKeyedArchiver archiveRootObject:allStudent toFile:path];

    // 从文件中读取模型对象
    NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    //    NSLog(@" Student name= %@, age= %d ,sex =%d ",stu.name ,stu.age ,stu.sex);
    NSLog(@" array = %@ %d ", array, success);
    [student mutableArrayValueForKey:@""];
    //对象添加KVO
    [student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

//    student.name = @"code";
    [student setValue:@"code" forKey:@"name"];

    //student dealloc前一定要执行remove
    [student removeObserver:self forKeyPath:@"name"];
    
    
    msg = [[Message alloc] init];
    [msg sh_addObserver:self forKey:@"text" block:^(id observer, NSString *key, id newValue, id oldValue) {
        NSLog(@" new  %@  oldx : %@",newValue, oldValue);
    }];
    [self performSelector:@selector(changeText) withObject:nil afterDelay:2.f];
}

- (void)changeText{
    msg.text = @"hello";
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    NSLog(@" observeObj:%@  change:%@ ", object, change);
}
- (void)change
{
    [UIView animateWithDuration:0.0001 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.transform = CGAffineTransformMakeRotation(angleValue * (M_PI / 180.0f));
    }
        completion:^(BOOL finished) {
            angleValue += 1;
            yellow.angle += 1;
            [self change];
        }];
}
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    NSLog(@" offSet %@   inset %@", NSStringFromCGPoint(scrollView.contentOffset), NSStringFromUIEdgeInsets(scrollView.contentInset));
    
    NSString *string = @"as" ;
    @synchronized (string) {
        string = @"asd";
        NSLog(@" i am string ");
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    float y = offset.y + bounds.size.height ;
    float h = size.height;
    if (y > h - 1) {
        NSLog(@" refresh... ");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (id)shareObject
{

    externConstString = @"asdd";
    staticString = @"sad";
    constString2 = @"mmmm";
    NSLog(@"extern %@ const %@ const2 %@  static %@", externConstString, constString, constString2, staticString);
    //    constString =@"asd";
    return nil;
}

- (void)testForURLSession
{
    // NSURLSession  Data  upload  download
    NSURL* url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        //        NSLog(@" session response : %@ ",response);
    }];
    [task resume];

    NSData* data = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionUploadTask* uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){

    }];
    [uploadTask resume];

    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL* location, NSURLResponse* response, NSError* error) {
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSURL* documentsURL = [NSURL fileURLWithPath:documentsPath];
        NSURL* newFilePath = [documentsURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
        [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFilePath error:nil];
    }];
    [downloadTask resume];
}

- (void)testForGCDSemaphore{
    dispatch_semaphore_t semaphor = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2500000.0f * NSEC_PER_SEC);
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@" task 1");
        dispatch_semaphore_signal(semaphor);   //信号量加1
    });
    dispatch_group_async(group, queue, ^{
        sleep(1);
        NSLog(@" task 2");
        dispatch_semaphore_signal(semaphor);
    });
    dispatch_group_async(group, queue, ^{
        sleep(3);
        NSLog(@" task 3");
        dispatch_semaphore_signal(semaphor);
    });
    dispatch_semaphore_wait(semaphor, DISPATCH_TIME_NOW);
    NSLog(@" go on ");
    dispatch_group_notify(group, queue, ^{
        NSLog(@" wait ");
        dispatch_semaphore_wait(semaphor, DISPATCH_TIME_NOW);   //如果信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1，如果desema的值为0，那么这个函数就阻塞当前线程等待timeout
        dispatch_semaphore_wait(semaphor, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphor, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphor, DISPATCH_TIME_FOREVER);
        NSLog(@" finish 3 ");
        dispatch_semaphore_wait(semaphor, time);
        NSLog(@" all done");
    });
}

@end















