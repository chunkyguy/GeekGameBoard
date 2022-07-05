//
// Created by Sidharth Juyal on 04/07/2022.
// Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
// 

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
  NSArray *_games;
}

@property (nonatomic, retain) GameViewController *gameVwCtrl;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kCell"];
  [_tableView setDataSource:self];
  [_tableView setDelegate:self];

  _games = [[NSArray alloc] initWithObjects:
            @"TicTacToeGame",
            @"KlondikeGame",
            @"CheckersGame",
            @"HexchequerGame",
            @"GoGame",
            nil];
}

- (void)dealloc {
  [_games release];
  [_tableView release];
  [super dealloc];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_games count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCell"];
  NSString *game = [_games objectAtIndex:[indexPath row]];
  NSString *title = [[game componentsSeparatedByString:@"Game"]firstObject];
  [[cell textLabel] setText:title];
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  self.gameVwCtrl = [GameViewController viewControllerWithGameNamed:[_games objectAtIndex:[indexPath row]]];
  [[self navigationController] pushViewController:_gameVwCtrl animated:YES];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
