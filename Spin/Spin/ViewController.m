//
//  ViewController.m
//  Spin
//
//  Created by Tuan EM on 5/3/13.
//  Copyright (c) 2013 Tuan EM. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SMCLove.h"

@interface ViewController ()
{
    UIView* _Circle;
    UIView* _Circle1;
    UIView* _Circle2;
    UIButton* Spin;
    CGFloat degree;
    CGFloat degree1;
    CGFloat degree2;
    NSTimer* _timer;
    NSTimer* _timer1;
    NSTimer* _timer2;
    int count;
    int count1;
    int count2;
    float x;
    float y;
    float x1;
    float y1;
    float x2;
    float y2;
    NSMutableArray* _imageArray;
    NSMutableArray* _imageArray1;
    NSMutableArray* _imageArray2;
    int currentValue;
    int currentValue1;
    int currentValue2;

    CGFloat min;
    CGFloat max;
    NSMutableArray* cloves;
    NSMutableArray* cloves1;
    NSMutableArray* cloves2;
    
    NSMutableArray* icon;
    NSMutableArray* icon1;
    NSMutableArray* icon2;

    UITextField* scoresText;
    UILabel* scoresLabel;
    
    NSMutableArray* compare;
    int turn;
    int scorePlayer1;
    int scorePlayer2;
    
    UITextField* score1;
    UITextField* score2;
    UITextField* player ;


}
@property(strong,nonatomic) AVAudioPlayer* playSound;
@property(strong,nonatomic) UIImage* path ;
@end

@implementation ViewController
@synthesize playSound;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _Circle = [[UIView alloc] initWithFrame:self.view.frame];
    _Circle1 = [[UIView alloc] initWithFrame:self.view.frame];
    _Circle2 = [[UIView alloc] initWithFrame:self.view.frame];
    
    _imageArray = [[NSMutableArray alloc] initWithCapacity:8];
    _imageArray1 = [[NSMutableArray alloc] initWithCapacity:8];
    _imageArray2 = [[NSMutableArray alloc] initWithCapacity:8];
    
    currentValue = 0;
    currentValue1 = 0;
    currentValue2 = 0;

    
    degree = 0;
    degree1 = 0;
    degree2 = 0;
    
    turn=1;
    
    CGFloat angleSize = 2*M_PI/8;
    min = M_PI/8;
    max = M_PI/7;
    UIImage* circle = [UIImage imageNamed:@"path"];
    UIImage* circle1 = [UIImage imageNamed:@"path1"];
    UIImage* circle2 = [UIImage imageNamed:@"path2"];
    
    icon = [[NSMutableArray alloc] init];
    icon1 = [[NSMutableArray alloc] init];
    icon2 = [[NSMutableArray alloc] init];
    
    compare = [[NSMutableArray alloc] init];
    for (int i=0; i<8; i++) {
        UIImage* icons = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [compare addObject:icons];
    }
    
    for (int i=0; i<8; i++) {
        UIImage* icons = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [icon addObject:icons];
    }
    
    for (int i=0; i<8; i++) {
        int random = arc4random_uniform(icon.count);

        UIImageView *im = [[UIImageView alloc] initWithImage:circle2];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(_Circle.bounds.size.width/2.0,
                                        _Circle.bounds.size.height/2.0);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = 0.5;
        im.tag = i;
        
        if (im.tag == 0) {
            im.alpha = 1.0;
        }

        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 40, 40)];
        cloveImage.image = icon[random];
        cloveImage.tag = 100 + [compare indexOfObject:icon[random]];
        [im addSubview:cloveImage];
        [icon removeObjectAtIndex:random];
        
        [_imageArray addObject:im];
        [_Circle addSubview:im];
    }

    for (int i=0; i<8; i++) {
        UIImage* icons = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [icon1 addObject:icons];
    }
   
    for (int i=0; i<8; i++) {
        int random = arc4random_uniform(icon1.count);
        UIImageView *im = [[UIImageView alloc] initWithImage:circle1];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(_Circle1.bounds.size.width/2.0,
                                        _Circle1.bounds.size.height/2.0);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = 0.5;
        im.tag = i;
        
        if (im.tag == 0) {
            im.alpha = 1.0;
        }
        
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
        
        cloveImage.image = icon1[random];
        cloveImage.tag = 100 + [compare indexOfObject:icon1[random]];
        [im addSubview:cloveImage];
        [icon1 removeObjectAtIndex:random];

        [_imageArray1 addObject:im];
        [_Circle1 addSubview:im];
    }

    for (int i=0; i<8; i++) {
        UIImage* icons = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
        [icon2 addObject:icons];
    }
    for (int i=0; i<8; i++) {
        int random = arc4random_uniform(icon2.count);
        UIImageView *im = [[UIImageView alloc] initWithImage:circle];
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(_Circle2.bounds.size.width/2.0,
                                        _Circle2.bounds.size.height/2.0);
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
      
        im.alpha = 0.5;
        im.tag = i;
        
        if (im.tag == 0) {
            im.alpha = 1.0;
        }
      
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
        cloveImage.image = icon2[random];
        cloveImage.tag = 100 + [compare indexOfObject:icon2[random]];
        [im addSubview:cloveImage];
        [icon2 removeObjectAtIndex:random];
        
        [_imageArray2 addObject:im];
        [_Circle2 addSubview:im];
    }
    
    cloves = [NSMutableArray arrayWithCapacity:8];
    cloves1 = [NSMutableArray arrayWithCapacity:8];
    cloves2 = [NSMutableArray arrayWithCapacity:8];
    
    [self.view addSubview:_Circle];
    [self.view addSubview:_Circle1];
    [self.view addSubview:_Circle2];
    
    Spin = [[ UIButton alloc] initWithFrame:CGRectMake(150, 30, 30, 30)];
    
    UILabel* player1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 380, 90, 30)];
    UILabel* player2 = [[UILabel alloc] initWithFrame:CGRectMake(230, 380, 90, 30)];
    player1.text = @"Player 1";
    player2.text = @"Player 2";
    player2.backgroundColor = [UIColor clearColor];
    player1.backgroundColor = [UIColor clearColor];
    
    score1 = [[UITextField alloc] initWithFrame:CGRectMake(20, 415, 100, 40)];
    score2 = [[UITextField alloc] initWithFrame:CGRectMake(210, 415, 100, 40)];
    score1.translatesAutoresizingMaskIntoConstraints = NO;
    score1.borderStyle = UITextBorderStyleRoundedRect;
    score1.delegate = self;
    score1.enabled = NO;
    score2.translatesAutoresizingMaskIntoConstraints = NO;
    score2.borderStyle = UITextBorderStyleRoundedRect;
    score2.delegate = self;
    score2.enabled = NO;
    
    player = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 100, 40)];
    player.translatesAutoresizingMaskIntoConstraints = NO;
    player.borderStyle = UITextBorderStyleRoundedRect;
    player.delegate = self;
    player.enabled = NO;
    if (turn%2) {
        player.text = @"Player 2";
    }else{
        player.text = @"Player 1";
    }

    [self.view addSubview:score1];
    [self.view addSubview:score2];
    [self.view addSubview:player1];
    [self.view addSubview:player2];
    [self.view addSubview:player];
    
    [Spin setImage:[UIImage imageNamed:@"spin"] forState:UIControlStateNormal];
    [Spin addTarget:self action:@selector(spin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Spin];
    [self buildClovesEven];
    [self buildClovesEven1];
    [self buildClovesEven2];
    

    
}
-(void) spin{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xoay) userInfo:nil repeats:YES];
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xoay1) userInfo:nil repeats:YES];
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(xoay2) userInfo:nil repeats:YES];
   
    Spin.enabled = NO;
    x = arc4random()%14 +10;
    y = arc4random()%10 +7;
    x1 = arc4random()%8 +4;
    y1 = arc4random()%13 +9;
    x2 = arc4random()%9 +6;
    y2 = arc4random()%15 +12;

    [self begin];
    [self begin1];
    [self begin2];
    
    count = 0;
    count1 = 0;
    count2 = 0;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"begin" ofType:@"mp3"];
    NSData* data = [[NSData alloc] initWithContentsOfFile:path];
    playSound = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [playSound play];
    
}
-(void) xoay{
    count++;
    
    [_Circle setTransform:CGAffineTransformMakeRotation(degree)];
    if (count<40) {
        y=y-0.1;
        degree = degree +  M_PI/y;
    }
    if (count>=40) {
        x=x+2;
        degree = degree + M_PI/x;
        
    }
    if (count>=90) {
        
       [_timer invalidate];
        [self end];
        x=14;
        y=10;
        
    }
    if (count==70) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"end" ofType:@"mp3"];
        NSData* data = [[NSData alloc] initWithContentsOfFile:path];
        playSound = [[AVAudioPlayer alloc] initWithData:data error:nil];
        [playSound play];
    }
}
-(void) xoay1{
    count1++;
    [_Circle1 setTransform:CGAffineTransformMakeRotation(degree1)];
    if (count1<70) {
        y1=y1-0.1;
        degree1 = degree1 -  M_PI/y1;
    }
    if (count1>=70) {
        x1=x1+2;
        degree1 = degree1 - M_PI/x1;
        
    }
    if (count1>=120) {
        
        [_timer1 invalidate];
        Spin.enabled = YES;
        [self end1];
        x1=17;
        y1=8;
        if ([[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]==[[[[_imageArray1 objectAtIndex:currentValue1] subviews] objectAtIndex:0] tag] || [[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]==[[[[_imageArray2 objectAtIndex:currentValue2] subviews] objectAtIndex:0] tag] || [[[[_imageArray2 objectAtIndex:currentValue2] subviews] objectAtIndex:0] tag]==[[[[_imageArray1 objectAtIndex:currentValue1] subviews] objectAtIndex:0] tag]) {
            if (turn % 2) {
                scorePlayer2 = scorePlayer2+200;
                score2.text = [NSString stringWithFormat:@"%i",scorePlayer2];
                NSString* path = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"];
                NSData* data = [[NSData alloc] initWithContentsOfFile:path];
                playSound = [[AVAudioPlayer alloc] initWithData:data error:nil];
                [playSound play];
            }else{
                scorePlayer1 = scorePlayer1+200;
                score1.text = [NSString stringWithFormat:@"%i",scorePlayer1];
                NSString* path = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"];
                NSData* data = [[NSData alloc] initWithContentsOfFile:path];
                playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
                [playSound play];
            }
        }
        if ([[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]==[[[[_imageArray1 objectAtIndex:currentValue1] subviews] objectAtIndex:0] tag] && [[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]==[[[[_imageArray2 objectAtIndex:currentValue2] subviews] objectAtIndex:0] tag]) {
            if (turn % 2) {
                scorePlayer2 = scorePlayer2+300;
                score2.text = [NSString stringWithFormat:@"%i",scorePlayer2];
                UIAlertView* win = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Bạn có thêm 1 lượt quay" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
                [win show];
                NSString* path = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"];
                NSData* data = [[NSData alloc] initWithContentsOfFile:path];
                playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
                [playSound play];

            }else{
                scorePlayer1 = scorePlayer1+300;
                score1.text = [NSString stringWithFormat:@"%i",scorePlayer1];

                UIAlertView* win = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Bạn có thêm 1 lượt quay" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
                [win show];
                NSString* path = [[NSBundle mainBundle] pathForResource:@"tada" ofType:@"mp3"];
                NSData* data = [[NSData alloc] initWithContentsOfFile:path];
                playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
                [playSound play];

            }
            turn=turn++;
        }
        
        if ([[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]!=[[[[_imageArray1 objectAtIndex:currentValue1] subviews] objectAtIndex:0] tag] && [[[[_imageArray objectAtIndex:currentValue] subviews] objectAtIndex:0] tag]!=[[[[_imageArray2 objectAtIndex:currentValue2] subviews] objectAtIndex:0] tag] && [[[[_imageArray2 objectAtIndex:currentValue2] subviews] objectAtIndex:0] tag]!=[[[[_imageArray1 objectAtIndex:currentValue1] subviews] objectAtIndex:0] tag]) {
            NSString* path = [[NSBundle mainBundle] pathForResource:@"oh" ofType:@"mp3"];
            NSData* data = [[NSData alloc] initWithContentsOfFile:path];
            playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
            [playSound play];
        }
        
        if (scorePlayer1>=500) {
            UIAlertView* win = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Người chơi 1 đã dành chiến thắng" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
            [win show];
            NSString* path = [[NSBundle mainBundle] pathForResource:@"winner" ofType:@"mp3"];
            NSData* data = [[NSData alloc] initWithContentsOfFile:path];
            playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
            [playSound play];
            scorePlayer1=0;
            scorePlayer2=0;
            score2.text = [NSString stringWithFormat:@"%i",scorePlayer2];
            score1.text = [NSString stringWithFormat:@"%i",scorePlayer1];
            turn=0;
        }
        if (scorePlayer2>=500) {
            UIAlertView* win = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Người chơi 2 đã dành chiến thắng" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
            [win show];
            NSString* path = [[NSBundle mainBundle] pathForResource:@"winner" ofType:@"mp3"];
            NSData* data = [[NSData alloc] initWithContentsOfFile:path];
            playSound  = [[AVAudioPlayer alloc] initWithData:data error:nil];
            [playSound play];
            scorePlayer1=0;
            scorePlayer2=0;
            score2.text = [NSString stringWithFormat:@"%i",scorePlayer2];
            score1.text = [NSString stringWithFormat:@"%i",scorePlayer1];
            turn=1;
        }
        turn++;
        if (turn%2) {
            player.text = @"Player 2";
        }else{
            player.text = @"Player 1";
        }
    }
}

-(void) xoay2{
    count2++;

    [_Circle2 setTransform:CGAffineTransformMakeRotation(degree2)];
    if (count2<20) {
        y2=y2-0.1;
        degree2 = degree2 -  M_PI/y2;
    }
    if (count2>=20) {
        x2=x2+2;
        degree2 = degree2 - M_PI/x2;
        
    }
    if (count2>=50) {
        [_timer2 invalidate];
        [self end2];
        
        x2=8;
        y2=12;
    }
}

- (void) buildClovesEven {
    
    CGFloat fanWidth = M_PI*2/8;
    CGFloat mid = 0;
    
    for (int i = 0; i < 8; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        
        if (clove.maxValue-fanWidth < - M_PI) {
            
            mid = M_PI;
            clove.midValue = mid;
            clove.minValue = fabsf(clove.maxValue);
            
        }
        
        mid -= fanWidth;
        [cloves addObject:clove];
        
    }
    
}
- (void) buildClovesEven1 {
    
    CGFloat fanWidth = M_PI*2/8;
    CGFloat mid = 0;
    
    for (int i = 0; i < 8; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        
        if (clove.maxValue-fanWidth < - M_PI) {
            
            mid = M_PI;
            clove.midValue = mid;
            clove.minValue = fabsf(clove.maxValue);
            
        }
        
        mid -= fanWidth;
        [cloves1 addObject:clove];
        
    }
    
}
- (void) buildClovesEven2 {
    
    CGFloat fanWidth = M_PI*2/8;
    CGFloat mid = 0;
    
    for (int i = 0; i < 8; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        
        if (clove.maxValue-fanWidth < - M_PI) {
            
            mid = M_PI;
            clove.midValue = mid;
            clove.minValue = fabsf(clove.maxValue);
            
        }
        
        mid -= fanWidth;
        [cloves2 addObject:clove];
        
    }
    
}
-(void) begin {
 
    UIImageView *im = [self getCloveByValue:currentValue];
    im.alpha = 0.5;
    
}
-(void) begin1 {
    
    UIImageView *im = [self getCloveByValue1:currentValue1];
    im.alpha = 0.5;
    
}
-(void) begin2 {
    
    UIImageView *im = [self getCloveByValue2:currentValue2];
    im.alpha = 0.5;
    
}


-(void) end {
    CGFloat radians = atan2f(_Circle.transform.b, _Circle.transform.a);
    
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves) {
        
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            
            if (c.maxValue > radians || c.minValue < radians) {
                
                if (radians > 0) { // we are in the positive quadrant
                    
                    newVal = radians - M_PI;
                    
                } else { // we are in the negative one
                    
                    newVal = M_PI + radians;
                    
                }
                currentValue = c.value;
                
            }
            
        }
        
        else if (radians > c.minValue && radians < c.maxValue) {
            
            newVal = radians - c.midValue;
            currentValue = c.value;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(_Circle.transform, -newVal);
    _Circle.transform = t;
    
    [UIView commitAnimations];
        
    UIImageView *im = [self getCloveByValue:currentValue];
    im.alpha = 1.0;

}
- (UIImageView *) getCloveByValue:(int)value {
    
    UIImageView *res;
    
    NSArray *views = [_Circle subviews];
    
    for (UIImageView *im in views) {
        
        if (im.tag == value)
            res = im;
        
    }
    
    return res;
    
}


-(void) end1 {
    CGFloat radians = atan2f(_Circle1.transform.b, _Circle1.transform.a);
    
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves1) {
        
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            
            if (c.maxValue > radians || c.minValue < radians) {
                
                if (radians > 0) { // we are in the positive quadrant
                    
                    newVal = radians - M_PI;
                    
                } else { // we are in the negative one
                    
                    newVal = M_PI + radians;
                    
                }
                currentValue1 = c.value;
                
            }
            
        }
        
        else if (radians > c.minValue && radians < c.maxValue) {
            
            newVal = radians - c.midValue;
            currentValue1 = c.value;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(_Circle1.transform, -newVal);
    _Circle1.transform = t;
    
    [UIView commitAnimations];
    
    
    UIImageView *im = [self getCloveByValue1:currentValue1];
    im.alpha = 1.0;
    
}

- (UIImageView *) getCloveByValue1:(int)value {
    
    UIImageView *res;
    
    NSArray *views = [_Circle1 subviews];
    
    for (UIImageView *im in views) {
        
        if (im.tag == value)
            res = im;
        
    }
    
    return res;
    
}

-(void) end2 {
    CGFloat radians = atan2f(_Circle2.transform.b, _Circle2.transform.a);
    
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves2) {
        
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            
            if (c.maxValue > radians || c.minValue < radians) {
                
                if (radians > 0) { // we are in the positive quadrant
                    
                    newVal = radians - M_PI;
                    
                } else { // we are in the negative one
                    
                    newVal = M_PI + radians;
                    
                }
                currentValue2 = c.value;
                
            }
            
        }
        
        else if (radians > c.minValue && radians < c.maxValue) {
            
            newVal = radians - c.midValue;
            currentValue2 = c.value;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(_Circle2.transform, -newVal);
    _Circle2.transform = t;
    
    [UIView commitAnimations];
        
    UIImageView *im = [self getCloveByValue2:currentValue2];
    im.alpha = 1.0;
    
}

- (UIImageView *) getCloveByValue2:(int)value {
    
    UIImageView *res;
    
    NSArray *views = [_Circle2 subviews];
    
    for (UIImageView *im in views) {
        
        if (im.tag == value)
            res = im;
        
    }
    
    return res;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
