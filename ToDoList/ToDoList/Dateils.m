//
//  Dateils.m
//  ToDoList
//
//  Created by mohamed on 03/04/2024.
//

#import "Dateils.h"
#import "Tasks.h"
#import "ProgressTable.h"

@interface Dateils ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak
           , nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;

@property (weak, nonatomic) IBOutlet UIImageView *priorityIcon;

@property NSUserDefaults *defaults;
@property NSData *savedData;
@property NSArray *todos;
@property int screen;



@property Tasks *todo;
@property int index;



@end

@implementation Dateils

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaults = [NSUserDefaults standardUserDefaults];
    _savedData = [_defaults objectForKey:@"tasks"];
    
    NSError *err;
    _todos = (NSArray*) [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[Tasks class] fromData:_savedData error:&err];
    
}
- (IBAction)addToProgress:(id)sender {
    if(![[_nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]){
        Tasks *todo = [Tasks new];
        todo.name = _nameField.text;
        todo.desc = _descriptionField.text;
        todo.prio= (int)_priority.selectedSegmentIndex;
        todo.status = (int)_status.selectedSegmentIndex;
        todo.taskDate = [NSDate date];
        bool x = [todo isSameAs:_todo];
        if(!x){
            UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"Edit Confirmation" message:@"Are you sure you want to edit the task?" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:self->_todos];
                [arr replaceObjectAtIndex:self->_index withObject:todo];
                self->_todos = [NSArray arrayWithArray:arr];
                
                NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self->_todos requiringSecureCoding:YES error:nil];
                
                [self->_defaults setObject:archiveData forKey:@"todoslist"];
                
               
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
            
            [cont addAction:yes];
            [cont addAction:no];
            [self presentViewController:cont animated:YES completion:nil];
        }else{
            UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"No Change" message:@"No edit has been done!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            
            [cont addAction:ok];
            [self presentViewController:cont animated:YES completion:nil];
        }
    }else{
        UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"Name error" message:@"Please supply a name for the todo" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [cont addAction:ok];
        [self presentViewController:cont animated:YES completion:nil];
    }
}
   
-(void)setFields:(Tasks*) t{
    _nameField.text = t.name;
    _descriptionField.text = t.desc;
    [_priority setSelectedSegmentIndex:t.prio];
    [_status setSelectedSegmentIndex:t.status];
    [_date setDate:t.taskDate];
    _date.minimumDate = NSDate.now;
    NSString *imageName;
    switch (t.prio) {
        case 0:
            imageName = @"high priority";
            break;
        case 1:
            imageName = @"medium priority";
            break;
        case 2:
            imageName = @"low priority";
            break;
            
        default:
            break;
    }
    [_priorityIcon setImage:[UIImage imageNamed:imageName]];
}
- (void)setToTaska:(nonnull Tasks *)t : (int)index{
    _todo = t;
    _index = index;
}

-(void)setScreenIndex:(int)index{
    _screen = index;
}

- (void)viewWillAppear:(BOOL)animated{
    [self setFields:_todo];
    switch (_screen) {
        case 0:

            break;
        case 1:
            [_status setEnabled:NO forSegmentAtIndex:0];
            break;
        case 2:
           // [_theButton setHidden:YES];
            [_nameField setEnabled:NO];
            [_descriptionField setEnabled:NO];
            [_priority setEnabled:NO];
            [_status setEnabled:NO];
            [_date setEnabled:NO];
            
            break;
            
        default:
            break;
    }
    
}


    
    




@end
