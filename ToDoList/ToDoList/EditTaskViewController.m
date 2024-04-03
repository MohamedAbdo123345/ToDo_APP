#import "EditTaskViewController.h"
#import "Tasks.h"
#import "FirstScreen.h"

@interface EditTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editName;
@property (weak, nonatomic) IBOutlet UITextField *editDescraption;
@property (weak, nonatomic) IBOutlet UIDatePicker *editTime;


@property (weak, nonatomic) IBOutlet UISegmentedControl *editPeriorty;
@property (weak, nonatomic) IBOutlet UISegmentedControl *editStats;



@property NSUserDefaults *ud;
@property NSData *storedArray;
@property NSArray<Tasks*> *todoArray;
@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editTime.minimumDate = [NSDate date];
    
    _ud = [NSUserDefaults standardUserDefaults];
}

    - (IBAction)addTask:(id)sender {
        Tasks *task = [Tasks new];
        if(![[_editName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]){
            task.name = _editName.text;
            task.desc = _editDescraption.text;
            task.prio = (int)_editPeriorty.selectedSegmentIndex;
            task.status = (int)_editStats.selectedSegmentIndex;
            task.taskDate = [NSDate date];
            _storedArray = [_ud objectForKey:@"tasks"];
            _todoArray = (NSArray*) [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[Tasks class] fromData:_storedArray error:nil];
            NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_todoArray];
            [tempArr addObject:task];
            _todoArray = [NSArray arrayWithArray:tempArr];
            
            NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:_todoArray requiringSecureCoding:YES error:nil];
            
            [_ud setObject:storeData forKey:@"tasks"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"Fill Data" message:@"Please enter a task name" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            
            [cont addAction:ok];
            [self presentViewController:cont animated:YES completion:nil];
        }

    }
- (void)viewWillAppear:(BOOL)animated{
    [_editStats removeSegmentAtIndex:2 animated:YES];
    [_editStats removeSegmentAtIndex:1 animated:YES];
}


- (IBAction)editTime2:(id)sender {
}
@end
