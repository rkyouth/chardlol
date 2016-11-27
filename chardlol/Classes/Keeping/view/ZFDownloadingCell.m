//
//  ZFDownloadingCell.m
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ZFDownloadingCell.h"

@interface ZFDownloadingCell ()

@end

@implementation ZFDownloadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *fileNameLabel = [[UILabel alloc] init];
        fileNameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:fileNameLabel];
        self.fileNameLabel = fileNameLabel;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        [self.contentView addSubview:progressView];
        self.progress = progressView;
        
        UILabel *sizeLabel = [[UILabel alloc] init];
        sizeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:sizeLabel];
        self.progressLabel = sizeLabel;
        
        UILabel *speedLabel = [[UILabel alloc] init];
        speedLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:speedLabel];
        self.speedLabel = speedLabel;
        
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(clickDownload:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"menu_play"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"menu_pause"] forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        self.downloadBtn = btn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat fileNameLabW = self.contentView.frame.size.width - 80;
    self.fileNameLabel.frame = CGRectMake(10, 10, fileNameLabW, 20);
    
    CGFloat progressY = CGRectGetMaxY(self.fileNameLabel.frame) + 10;
    self.progress.frame = CGRectMake(10, progressY, fileNameLabW, 2);
    
    CGFloat sizeY = CGRectGetMaxY(self.progress.frame) + 10;
    self.progressLabel.frame = CGRectMake(10, sizeY, fileNameLabW * 0.6, 20);
    
    CGFloat speedX = CGRectGetMaxX(self.progressLabel.frame);
    CGFloat speedW = fileNameLabW * 0.4;
    self.speedLabel.frame = CGRectMake(speedX, sizeY, speedW, 20);
    
    CGFloat btnX = CGRectGetMaxX(self.progress.frame) + 10;
    CGFloat btnY = (self.contentView.frame.size.height - 50) * 0.5;
    self.downloadBtn.frame = CGRectMake(btnX, btnY, 50, 50);
}

/**
 *  暂停、下载
 *
 *  @param sender UIButton
 */
- (void)clickDownload:(UIButton *)sender
{
    // 执行操作过程中应该禁止该按键的响应 否则会引起异常
    sender.userInteractionEnabled = NO;
    ZFFileModel *downFile = self.fileInfo;
    ZFDownloadManager *filedownmanage = [ZFDownloadManager sharedDownloadManager];
    if(downFile.downloadState == ZFDownloading) { //文件正在下载，点击之后暂停下载 有可能进入等待状态
        self.downloadBtn.selected = YES;
        [filedownmanage stopRequest:self.request];
    } else {
         self.downloadBtn.selected = NO;
        [filedownmanage resumeRequest:self.request];
    }
    
    // 暂停意味着这个Cell里的ASIHttprequest已被释放，要及时更新table的数据，使最新的ASIHttpreqst控制Cell
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
    sender.userInteractionEnabled = YES;
}

- (void)setFileInfo:(ZFFileModel *)fileInfo
{
    _fileInfo = fileInfo;
    self.fileNameLabel.text = fileInfo.fileName;
    // 服务器可能响应的慢，拿不到视频总长度 && 不是下载状态
    if ([fileInfo.fileSize longLongValue] == 0 && !(fileInfo.downloadState == ZFDownloading)) {
        self.progressLabel.text = @"";
        if (fileInfo.downloadState == ZFStopDownload) {
            self.speedLabel.text = @"已暂停";
        } else if (fileInfo.downloadState == ZFWillDownload) {
            self.downloadBtn.selected = YES;
            self.speedLabel.text = @"等待下载";
        }
        self.progress.progress = 0.0;
        return;
    }
    NSString *currentSize = [ZFCommonHelper getFileSizeString:fileInfo.fileReceivedSize];
    NSString *totalSize = [ZFCommonHelper getFileSizeString:fileInfo.fileSize];
    // 下载进度
    float progress = (float)[fileInfo.fileReceivedSize longLongValue] / [fileInfo.fileSize longLongValue];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%@ / %@ (%.2f%%)",currentSize, totalSize, progress*100];
    
    self.progress.progress = progress;
    
    NSString *spped = [NSString stringWithFormat:@"%@/S",[ZFCommonHelper getFileSizeString:[NSString stringWithFormat:@"%lu",[ASIHTTPRequest averageBandwidthUsedPerSecond]]]];
    self.speedLabel.text = spped;
    
    if (fileInfo.downloadState == ZFDownloading) { //文件正在下载
        self.downloadBtn.selected = NO;
    } else if (fileInfo.downloadState == ZFStopDownload&&!fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"已暂停";
    }else if (fileInfo.downloadState == ZFWillDownload&&!fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"等待下载";
    } else if (fileInfo.error) {
        self.downloadBtn.selected = YES;
        self.speedLabel.text = @"错误";
    }
}

@end
