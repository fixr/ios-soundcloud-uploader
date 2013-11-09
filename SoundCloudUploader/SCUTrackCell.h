//
//  SCUTrackCell.h
//  SoundCloudUploader
//
//  Created by Freddie Peña on 03/12/13.
//  Copyright (c) 2013 fixem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCUTrackCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *duration;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *playIndicator;

@end
