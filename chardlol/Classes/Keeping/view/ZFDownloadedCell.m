//
//  ZFDownloadedCell.m
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

#import "ZFDownloadedCell.h"

@implementation ZFDownloadedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"file"];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *filenameLab = [[UILabel alloc] init];
        [self.contentView addSubview:filenameLab];
        self.fileNameLabel = filenameLab;
        
        UILabel *sizeLab = [[UILabel alloc] init];
        [self.contentView addSubview:sizeLab];
        self.sizeLabel = sizeLab;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(10, 10, 30, 30);
    
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat nameY = (self.contentView.frame.size.height - 20) * 0.5;
    CGFloat nameW = self.contentView.frame.size.width - 60 - 30;
    self.fileNameLabel.frame = CGRectMake(nameX, nameY, nameW, 20);
    
    CGFloat sizeX = self.contentView.frame.size.width - 80 - 10;
    CGFloat sizeY = CGRectGetMaxY(self.fileNameLabel.frame) + 10;
    self.sizeLabel.frame = CGRectMake(sizeX, sizeY, 80, 20);
}

- (void)setFileInfo:(ZFFileModel *)fileInfo
{
    _fileInfo = fileInfo;
    NSString *totalSize = [ZFCommonHelper getFileSizeString:fileInfo.fileSize];
    self.fileNameLabel.text = fileInfo.fileName;
    self.sizeLabel.text = totalSize;
}

@end
