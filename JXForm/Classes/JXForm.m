//
//  JXForm.m
//  Pods
//

#import "JXForm.h"

@implementation JXForm

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if(!self.delegate) return;
    if(![self.delegate respondsToSelector:@selector(numberOfRowsInForm:)]) return;
    if(![self.delegate respondsToSelector:@selector(numberOfColumnsInForm:)]) return;
    if(![self.delegate respondsToSelector:@selector(form:heightForRow:)]) return;
    if(![self.delegate respondsToSelector:@selector(form:widthForColumn:)]) return;
    if(!self.dataSource) return;
    if(![self.dataSource respondsToSelector:@selector(form:contentViewForRow:column:)]) return;
    
    CGPoint formOrigin=[self getFormOriginWithViewOrigin:self.bounds.origin];
    CGPoint cellOrigin=formOrigin;
    for (int i=0; i<[self.delegate numberOfRowsInForm:self]; i++) {
        if (i>0) {
            cellOrigin.y+=[self.delegate form:self heightForRow:i-1];
        }
        for (int j=0; j<[self.delegate numberOfColumnsInForm:self]; j++) {
            if (j>0) {
                cellOrigin.x+=[self.delegate form:self widthForColumn:j-1];
            }
            UIView* contentView=[self.dataSource form:self contentViewForRow:i column:j];
            CGRect frame=contentView.frame;
            frame.origin=cellOrigin;
            contentView.frame=frame;
            [self addSubview:contentView];
        }
        cellOrigin.x=formOrigin.x;
    }
}

- (void)drawRect:(CGRect)rect {
    if(!self.delegate) return;
    if(![self.delegate respondsToSelector:@selector(numberOfRowsInForm:)]) return;
    if(![self.delegate respondsToSelector:@selector(numberOfColumnsInForm:)]) return;
    if(![self.delegate respondsToSelector:@selector(form:heightForRow:)]) return;
    if(![self.delegate respondsToSelector:@selector(form:widthForColumn:)]) return;
    
    NSInteger rowCount=[self.delegate numberOfRowsInForm:self];
    NSInteger columnCount=[self.delegate numberOfColumnsInForm:self];
    CGFloat height=0;
    CGFloat width=0;
    for (int i=0; i<rowCount; i++) {
        CGFloat rowHeight=[self.delegate form:self heightForRow:i];
        height+=rowHeight;
    }
    for (int i=0; i<columnCount; i++) {
        CGFloat columnWidth=[self.delegate form:self widthForColumn:i];
        width+=columnWidth;
    }
    CGPoint origin=[self getFormOriginWithViewOrigin:rect.origin];
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //draw border
    CGFloat borderWidth=[self.delegate respondsToSelector:@selector(borderWidthForForm:)]?[self.delegate borderWidthForForm:self]:1;
    CGColorRef borderColor=[self.delegate respondsToSelector:@selector(borderColorForForm:)]?[self.delegate borderColorForForm:self]:[UIColor blackColor].CGColor;
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGPoint topLeft=CGPointMake(origin.x,origin.y);
    CGPoint topRight=CGPointMake(origin.x+width, origin.y);
    CGPoint bottomRight=CGPointMake(origin.x+width, origin.y+height);
    CGPoint bottomLeft=CGPointMake(origin.x, origin.y+height);
    CGPoint borderLineSegs[8]={topLeft,topRight,topRight,bottomRight,bottomRight,bottomLeft,bottomLeft,topLeft};
    CGContextStrokeLineSegments(context, borderLineSegs, 8);
    
    //draw internal lines
    CGFloat lineWidth=[self.delegate respondsToSelector:@selector(internalLineWidthForForm:)]?[self.delegate internalLineWidthForForm:self]:0.5;
    CGColorRef lineColor=[self.delegate respondsToSelector:@selector(internalLineColorForForm:)]?[self.delegate internalLineColorForForm:self]:[UIColor blackColor].CGColor;
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor);
    CGFloat lineY=origin.y;
    for (int i=0; i<rowCount-1; i++) {
        lineY+=[self.delegate form:self heightForRow:i];
        CGPoint lineSeg[2]={CGPointMake(origin.x,lineY),CGPointMake(origin.x+width, lineY)};
        CGContextStrokeLineSegments(context, lineSeg, 2);
    }
    CGFloat lineX=origin.x;
    for (int i=0; i<columnCount-1; i++) {
        lineX+=[self.delegate form:self widthForColumn:i];
        CGPoint lineSeg[2]={CGPointMake(lineX, origin.y),CGPointMake(lineX, origin.y+height)};
        CGContextStrokeLineSegments(context, lineSeg, 2);
    }
}

-(CGPoint)getFormOriginWithViewOrigin:(CGPoint)viewOrigin
{
    CGPoint origin;
    origin.x=[self.delegate respondsToSelector:@selector(paddingLeftForForm:)]?viewOrigin.x+[self.delegate paddingLeftForForm:self]:viewOrigin.x;
    origin.y=[self.delegate respondsToSelector:@selector(paddingTopForForm:)]?viewOrigin.y+[self.delegate paddingTopForForm:self]:viewOrigin.y;
    return origin;
}

@end
