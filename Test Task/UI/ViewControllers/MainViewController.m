//
//  ViewController.m
//  Test Task
//
//  Created by viera on 8/8/16.
//  Copyright © 2016 vydeveloping. All rights reserved.
//

#import "MainViewController.h"
#import "UIViewController+BackgroundWithGradient.h"

@interface MainViewController () <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *availableGameWorlds;

@end

@implementation MainViewController

#pragma mark - Memory management

#pragma mark - View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareBackgroundColor];
    [self prepareInterface];
}

#pragma mark - Action Handlers

#pragma mark - Public
- (void)setAvailableWorlds:(NSArray*)availableServices
{
    self.availableGameWorlds = availableServices;
}

#pragma mark - Private
- (void)prepareInterface
{
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
}

#pragma mark - Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.availableGameWorlds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    NSDictionary *world = self.availableGameWorlds[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = world[@"name"];
    
    return cell;
}

@end
