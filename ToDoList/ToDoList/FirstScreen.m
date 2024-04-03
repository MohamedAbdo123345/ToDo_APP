//
//  FirstScreen.m
//  ToDoList
//
//  Created by mohamed on 02/04/2024.
//

#import "FirstScreen.h"
#import "EditTaskViewController.h"
#import "Dateils.h"
#import "Tasks.h"

@interface FirstScreen ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *search;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searched;
@property NSUserDefaults *ud;
@property NSData *storedData;
@property NSArray<Tasks*> *todosList;
@property NSArray<Tasks*> *temp;
@property NSMutableArray<Tasks*> *searchList;
@property bool searching;



@end

@implementation FirstScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _ud = [NSUserDefaults standardUserDefaults];
    _search.delegate = self;
    _search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchList = [NSMutableArray new];
    _searching = NO;


}

- (void)viewWillAppear:(BOOL)animated{
    _storedData = [_ud objectForKey:@"tasks"];
    
   
    _todosList = (NSArray*) [NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[Tasks class] fromData:_storedData error:nil];
    _temp = [self filterToTodoArray:_todosList];

    [_tableView reloadData];
}
//- (void)loadTasksFromUserDefaults {
//    NSUserDefaults *standardUserDefaults = [NSU÷serDefaults standardUserDefaults];
//    NSData *tasksData = [standardUserDefaults objectForKey:@"tasksArray"];
//    if (tasksData) {
//        self.listData = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
//    } else {
//        self.listData = [NSMutableArray array];
//    }
    // Use self.tasksArray to populate your UI or perform other operations
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    _searching=YES;
    for (Tasks *todo in _temp) {
        if([todo.name containsString:[searchText lowercaseString]]){
            if(![_searchList containsObject:todo]){
                [_searchList addObject:todo];}
        }else{
            [_searchList removeObject:todo];
        }
    }
    [_tableView reloadData];
}

-(NSArray<Tasks*>*)filterToTodoArray:(NSArray<Tasks*>*) todos{
    NSMutableArray *arr = [NSMutableArray new];
    for (Tasks *todo in _todosList) {
        if (todo.status == 0) {
            [arr addObject:todo];
        }
        
    }
    return arr;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count;
    if (_searching && ![_search.text isEqual:@""]) {
        count= _searchList.count;
    } else {
        count = _temp.count;
    }
    return count;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"Delete Cell" message:@"Do you want to delete this cell" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *del = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:self->_todosList];
            [arr removeObjectAtIndex:[self->_todosList indexOfObject:[self->_temp objectAtIndex:indexPath.row]]];
            self->_todosList = [NSArray arrayWithArray:arr];
            self->_temp = [self filterToTodoArray:self->_todosList];
            NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:self->_todosList requiringSecureCoding:YES error:nil];
            
            [self->_ud setObject:archiveData forKey:@"tasks"];
            
            [self->_tableView reloadData];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [cont addAction:del];
    [cont addAction:cancel];
    
    [self presentViewController:cont animated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TodoCell"];
    NSString *imageName;
    
    if(_searching && ![_search.text isEqual:@""]){
        
        cell.textLabel.text = _searchList[indexPath.row].name;
        cell.detailTextLabel.text = _searchList[indexPath.row].desc;
        switch (_searchList[indexPath.row].prio) {
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
    }else{
        _searching=NO;
        [_searchList removeAllObjects];
        cell.textLabel.text = _temp[indexPath.row].name;
        cell.detailTextLabel.text = _temp[indexPath.row].desc;
        switch (_temp[indexPath.row].prio) {
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
    }
    cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Dateils *dateils = [self.storyboard instantiateViewControllerWithIdentifier:@"gofor"];
    //navigate to details
    Tasks *t = _temp[indexPath.row] ;

    [dateils setToTaska:t :(int)[_todosList indexOfObject:t]];
    [dateils setScreenIndex:0];
    [self.navigationController pushViewController:dateils animated:YES];

}

- (IBAction)addTask:(id)sender {
    //navigate to add task
    EditTaskViewController * task = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    [self.navigationController pushViewController:task animated:YES];
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//    NSData *tasksData = [standardUserDefaults objectForKey:@"tasksArray"];
//    if (tasksData) {
//        NSArray<Tasks *> *tasksArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:tasksData error:nil];
//        if (tasksArray) {
//            self.listData = [NSMutableArray arrayWithArray:tasksArray];
//        }
//    }
//
//    [self.tableView reloadData];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

