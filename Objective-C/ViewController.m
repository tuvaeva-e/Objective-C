
#import "Robot.h"
#import "ViewController.h"

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSData *data = [self.userDefaults objectForKey:@"robot"];
    Robot *robot = [NSKeyedUnarchiver unarchivedObjectOfClass:[Robot class]
                                                     fromData:data
                                                        error:NULL];
    self.textView.text = [NSString stringWithFormat:@"%@", robot];
    [self clearUserDefaults];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // создаём робота и кладём его в UserDefaults
    Robot *robot = [[Robot alloc] init:@"Robot" x:1 y:2];
    NSError *error;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:robot
                                         requiringSecureCoding:NO
                                                         error:&error];
    [self.userDefaults setObject:data forKey:@"robot"];

    // записываем файл
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *url = [fileManager URLsForDirectory:NSDocumentDirectory
                                     inDomains:NSUserDomainMask]
                     .firstObject;
		    NSURL *newFolderUrl = [url URLByAppendingPathComponent:@"Новая папка"];
    NSURL *testData = [newFolderUrl
        URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",
                                                               robot.name]];
    NSData *file = [NSKeyedArchiver archivedDataWithRootObject:robot
                                         requiringSecureCoding:NO
                                                         error:&error];
    if ([fileManager createDirectoryAtURL:newFolderUrl
              withIntermediateDirectories:YES
                               attributes:nil
                                    error:nil])
    {
        [fileManager createFileAtPath:testData.path
                             contents:file
                           attributes:nil];
    }

    // читаем файл
    if ([fileManager fileExistsAtPath:testData.path])
    {
        NSData *dataFromFile = [fileManager contentsAtPath:testData.path];
        Robot *robotRead =
            [NSKeyedUnarchiver unarchivedObjectOfClass:[Robot class]
                                              fromData:dataFromFile
                                                 error:&error];
        NSLog(@"%@", robotRead);
        NSLog(@"%@", error);
        self.textViewForFile.text = [NSString stringWithFormat:@"%@", robot];
        [fileManager removeItemAtPath:testData.path error:nil];
    }
}

- (void)clearUserDefaults
{
    NSDictionary *dict = [self.userDefaults dictionaryRepresentation];
    for (id key in dict)
    {
        [self.userDefaults removeObjectForKey:key];
    }
    [self.userDefaults synchronize];
}

@end