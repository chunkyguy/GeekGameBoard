//
// Created by Sidharth Juyal on 04/07/2022.
// Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
// 

#import "GameViewController.h"
#import "BoardUIView.h"
#import "Game.h"
#import "Player.h"
#import "QuartzUtils.h"
#import "GGBUtils.h"

@interface GameViewController () {
  BoardUIView *_contentView;
  UILabel *_headline;
  NSString *_gameName;
  BOOL _isLayout;
}
@property (nonatomic, retain) BoardUIView *contentView;
@property (nonatomic, retain) UILabel *headline;
@end

@implementation GameViewController

- (void)dealloc
{
  [_gameName release];
  [_contentView release];
  [_headline release];
  [super dealloc];
}

+ (instancetype)viewControllerWithGameNamed: (NSString*)gameClassName; {
  return [[[GameViewController alloc] initWithWithGameNamed:gameClassName]autorelease];
}

- (instancetype)initWithWithGameNamed: (NSString*)gameClassName; {
  self = [super initWithNibName:nil bundle:nil];
  if (self != nil) {
    _gameName = [gameClassName copy];
    _isLayout = NO;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setTitle:@"Loading ..."];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if (!_isLayout) {
    [self layoutSubviews];
    _isLayout = YES;
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  // Start game:
  [self startGameNamed: _gameName];
  [self setTitle:[[[self.contentView game] class] displayName]];
}

- (void)layoutSubviews {
  self.view.layer.backgroundColor = GetCGPatternNamed(@"Background.png");

  // Set up content view
  UIEdgeInsets insets = self.view.safeAreaInsets;
  CGRect sys, content, rHeadline, rContent;
  CGRectDivide([self.view frame], &sys, &content, insets.top, CGRectMinYEdge);
  CGRectDivide(content, &rHeadline, &rContent, 35, CGRectMinYEdge);

  self.contentView = [[[BoardUIView alloc] initWithFrame: rContent] autorelease];
  [self.view addSubview: _contentView];

  self.headline = [[[UILabel alloc] initWithFrame: rHeadline] autorelease];
  _headline.backgroundColor = nil;
  _headline.opaque = NO;
  _headline.textAlignment = NSTextAlignmentCenter;
  _headline.font = [UIFont boldSystemFontOfSize: 20];
  //_headline.minimumFontSize = 14;
  _headline.adjustsFontSizeToFitWidth = YES;
  [self.view addSubview: _headline];
}

- (void) startGameNamed: (NSString*)gameClassName
{
  Game *game = _contentView.game;
  [game removeObserver: self  forKeyPath: @"currentPlayer"];
  [game removeObserver: self forKeyPath: @"winner"];

  if( gameClassName == nil )
    gameClassName = [[game class] description];

  [_contentView startGameNamed: gameClassName];

  game = _contentView.game;
  [game addObserver: self
         forKeyPath: @"currentPlayer"
            options: NSKeyValueObservingOptionInitial
            context: NULL];
  [game addObserver: self
         forKeyPath: @"winner"
            options: 0
            context: NULL];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
  Game *game = _contentView.game;
  if( object == game ) {
    Player *p = game.winner;
    NSString *msg;
    if( p ) {
      PlaySound(@"Sosumi");
      msg = [NSString stringWithFormat:@"%@ wins!", p.name];
    } else {
      p = game.currentPlayer;
      msg = [NSString stringWithFormat:@"Your turn, %@", p.name];
    }
    _headline.text = msg;

    if( game.winner ) {
      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!"
                                                                     message:msg
                                                              preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
        // Start new game:
        [self startGameNamed: nil];
      }];
      [alert addAction:defaultAction];
      [self presentViewController:alert animated:YES completion:nil];
    }
  }
}

@end
