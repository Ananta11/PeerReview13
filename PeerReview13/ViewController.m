//
//  ViewController.m
//  PeerReview13
//
//  Created by Ananta Shahane on 19/12/17.
//  Copyright © 2017 Ananta Shahane. All rights reserved.
//


#import "ViewController.h"
#include "AVFoundation/AVAudioPlayer.h"
#include "AudioToolbox/AudioToolBox.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *Effect1;
@property (weak, nonatomic) IBOutlet UIButton *Effect2;
@property (weak, nonatomic) IBOutlet UIButton *Effect3;
@property (weak, nonatomic) IBOutlet UIButton *Effect4;
@property (weak, nonatomic) IBOutlet UIButton *SongPlay;
@property (weak, nonatomic) IBOutlet UIButton *SongPause;

@property (assign, nonatomic) SystemSoundID Sound1;
@property (assign, nonatomic) SystemSoundID Sound2;
@property (assign, nonatomic) SystemSoundID Sound3;
@property (assign, nonatomic) SystemSoundID Sound4;

@property (assign, nonatomic) BOOL Sound1Good;
@property (assign, nonatomic) BOOL Sound2Good;
@property (assign, nonatomic) BOOL Sound3Good;
@property (assign, nonatomic) BOOL Sound4Good;

@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Effect1.layer.cornerRadius = 22;
    self.Effect1.clipsToBounds = YES;
    
    self.Effect2.layer.cornerRadius = 22;
    self.Effect2.clipsToBounds = YES;
    
    self.Effect3.layer.cornerRadius = 22;
    self.Effect3.clipsToBounds = YES;
    
    self.Effect4.layer.cornerRadius = 22;
    self.Effect4.clipsToBounds = YES;
    
    self.Effect1.layer.cornerRadius = 22;
    self.Effect1.clipsToBounds = YES;
    
    self.SongPlay.layer.cornerRadius = 22;
    self.SongPlay.clipsToBounds = YES;
    
    self.SongPause.layer.cornerRadius = 22;
    self.SongPause.clipsToBounds = YES;
    
    NSURL *URL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@".aiff"]];
    NSURL *URL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@".aiff"]];
    NSURL *URL3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"3" ofType:@".aiff"]];
    NSURL *URL4 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"4" ofType:@".aiff"]];
    NSURL *Song = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Animals" ofType:@"m4a"]];
    OSStatus StatusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) URL1, &_Sound1);
    
    if(StatusReport == kAudioServicesNoError)
    {
        self.Sound1Good = YES;
    }
    else
    {
        self.Sound1Good = NO;
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"Sound Error" message:@"Effect 1 not found in bumdle." preferredStyle: UIAlertControllerStyleAlert];
        [self presentViewController:Alert animated:YES completion:nil];
        self.Effect1.enabled = NO;
    }
    
    StatusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) URL2, &_Sound2);
    
    if(StatusReport == kAudioServicesNoError)
    {
        self.Sound2Good = YES;
    }
    else
    {
        self.Sound2Good = NO;
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"Sound Error" message:@"Effect 2 not found in bumdle." preferredStyle: UIAlertControllerStyleAlert];
        [self presentViewController:Alert animated:YES completion:nil];
        self.Effect2.enabled = NO;
    }

    StatusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) URL3, &_Sound3);
    
    if(StatusReport == kAudioServicesNoError)
    {
        self.Sound3Good = YES;
    }
    else
    {
        self.Sound3Good = NO;
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"Sound Error" message:@"Effect 3 not found in bumdle." preferredStyle: UIAlertControllerStyleAlert];
        [self presentViewController:Alert animated:YES completion:nil];
        self.Effect3.enabled = NO;
    }

    StatusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) URL4, &_Sound4);
    
    if(StatusReport == kAudioServicesNoError)
    {
        self.Sound4Good = YES;
    }
    else
    {
        self.Sound4Good = NO;
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"Sound Error" message:@"Effect 4 not found in bumdle." preferredStyle: UIAlertControllerStyleAlert];
        [self presentViewController:Alert animated:YES completion:nil];
        self.Effect4.enabled = NO;
    }

    NSError *Error = nil;
    self.player =[[AVAudioPlayer alloc] initWithContentsOfURL:Song error:&Error];
    if(!self.player)
    {
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"Song Error" message:@"\"Animals\" by \"Martin Garlix\" not found." preferredStyle: UIAlertControllerStyleAlert];
        [self presentViewController:Alert animated:YES completion:nil];
    }
}

- (IBAction)PlayEffect1:(id)sender {
    AudioServicesPlaySystemSound(self.Sound1);
}

- (IBAction)PlayEffect2:(id)sender {
    AudioServicesPlaySystemSound(self.Sound2);
}

- (IBAction)PlayEffect3:(id)sender {
    AudioServicesPlaySystemSound(self.Sound3);
}

- (IBAction)PlayEffect4:(id)sender {
    AudioServicesPlaySystemSound(self.Sound4);
}

- (IBAction)PlaySongButton:(id)sender {
    [self.player play];
}

- (IBAction)PauseSongButton:(id)sender {
    [self.player stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    if(self.Sound1Good)
    {
        AudioServicesDisposeSystemSoundID(self.Sound1);
    }
    if(self.Sound2Good)
    {
        AudioServicesDisposeSystemSoundID(self.Sound2);
    }
    if(self.Sound3Good)
    {
        AudioServicesDisposeSystemSoundID(self.Sound3);
    }
    if(self.Sound4Good)
    {
        AudioServicesDisposeSystemSoundID(self.Sound4);
    }
}

@end
