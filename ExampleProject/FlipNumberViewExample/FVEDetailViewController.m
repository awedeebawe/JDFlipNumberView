//
//  FVEDetailViewController.m
//  FlipNumberViewExample
//
//  Created by Markus Emrich on 07.08.12.
//  Copyright (c) 2012 markusemrich. All rights reserved.
//

#import "JDFlipNumberView.h"
#import "JDGroupedFlipNumberView.h"
#import "JDDateCountdownFlipView.h"

#import "FVEDetailViewController.h"

@interface FVEDetailViewController ()
@property (nonatomic) NSIndexPath *indexPath;
- (void)showSingleDigit;
- (void)showMultipleDigits;
- (void)showDateCountdown;
@end

@implementation FVEDetailViewController

- (id)initWithIndexPath:(NSIndexPath*)indexPath
{
    self = [super init];
    if (self) {
        _indexPath = indexPath;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    if (self.indexPath.section == 1 || self.indexPath.row == 1) {
        [self showMultipleDigits];
    } else if (self.indexPath.row == 0) {
        [self showSingleDigit];
    } else {
        [self showDateCountdown];
    }

    // info label
    CGRect frame = CGRectInset(self.view.bounds, 10, 10);
    frame.size.height = 20;
    frame.origin.y = self.view.frame.size.height - frame.size.height - 10;
    UILabel *label = [[UILabel alloc] initWithFrame: frame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    label.font = [UIFont boldCustomFontOfSize:13];
    label.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    label.shadowColor = [UIColor colorWithWhite:0 alpha:0.2];
    label.shadowOffset = CGSizeMake(-1, -1);
    label.backgroundColor = [UIColor clearColor];
    label.text = @"Tap anywhere to change the value!";
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview: label];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)]];
}

- (void)showSingleDigit;
{
    JDFlipNumberView *flipView = [[JDFlipNumberView alloc] init];
    flipView.tag = 99;
    flipView.animationDuration = 1.0;
    flipView.value = arc4random() % 10;
    [self.view addSubview: flipView];
}

- (void)showMultipleDigits;
{
//    JDGroupedFlipNumberView *flipView = [[JDGroupedFlipNumberView alloc] initWithFlipNumberViewCount: 5];
//    flipView.intValue = 24;
//    flipView.tag = 99;
//    [self.view addSubview: flipView];
//    
//    if (self.indexPath.section == 0) {
//        flipView.maximumValue = 24;
//        [flipView animateDownWithTimeInterval: 1.0];
//    } else {
//        [flipView animateToValue: 9250 withDuration: 3.0];
//    }
}

- (void)showDateCountdown;
{
//    // countdown to silvester
//    NSDateComponents *currentComps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat: @"dd.MM.yy HH:mm"];
//    NSDate *date = [dateFormatter dateFromString: [NSString stringWithFormat: @"01.01.%d 00:00", currentComps.year+1]];
//    
//    JDDateCountdownFlipView *flipView = [[JDDateCountdownFlipView alloc] initWithTargetDate: date];
//    [self.view addSubview: flipView];
//    [flipView setDebugValues];
//    
//    // add info labels
//    NSInteger posx = 20;
//    for (NSInteger i=0; i<4; i++) {
//        CGRect frame = CGRectMake(posx, 20, 200, 200);
//        UILabel *label = [[UILabel alloc] initWithFrame: frame];
//        label.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:12];
//        label.textColor = [UIColor whiteColor];
//        label.backgroundColor = [UIColor darkGrayColor];
//        label.text = (i==0) ? @"days" : (i==1) ? @"hours" : (i==2) ? @"minutes" : @"seconds";
//        [label sizeToFit];
//        label.frame = CGRectInset(label.frame, -4, -4);
//        label.textAlignment = UITextAlignmentCenter;
//        [self.view addSubview: label];
//        
//        posx += label.frame.size.width + 10;
//    }
}

- (void)viewTapped:(UITapGestureRecognizer*)recognizer
{
    JDFlipNumberView *flipView = (JDFlipNumberView*)[self.view viewWithTag: 99];

    NSInteger randomNumber = arc4random()%8 - 4;
    if (randomNumber == 0) randomNumber = 1;
    NSInteger newValue = flipView.value+randomNumber;
    [flipView setValue:newValue withAnimationType:JDFlipAnimationTypeTopDown];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    JDFlipNumberView *flipView = (JDFlipNumberView*)[self.view viewWithTag: 99];
    if (!flipView) {
        return;
    }
    
    flipView.frame = CGRectInset(self.view.bounds, 40, 40);
    flipView.center = CGPointMake(floor(self.view.frame.size.width/2),
                                  floor((self.view.frame.size.height/2)*0.9));
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutSubviews];
}

@end
