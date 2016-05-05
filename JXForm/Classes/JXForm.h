//
//  JXForm.h
//  Pods
//

#import <UIKit/UIKit.h>

@class JXForm;

@protocol JXFormDelegate <NSObject>

@required
-(NSInteger)numberOfRowsInForm:(JXForm*)form;
-(NSInteger)numberOfColumnsInForm:(JXForm*)form;
-(CGFloat)form:(JXForm*)form heightForRow:(NSInteger)row;
-(CGFloat)form:(JXForm*)form widthForColumn:(NSInteger)column;

@optional
-(CGFloat)borderWidthForForm:(JXForm*)form;
-(CGFloat)internalLineWidthForForm:(JXForm*)form;
-(CGColorRef)borderColorForForm:(JXForm*)form;
-(CGColorRef)internalLineColorForForm:(JXForm*)form;
-(CGFloat)paddingLeftForForm:(JXForm*)form;
-(CGFloat)paddingTopForForm:(JXForm*)form;
//-(CGFloat)paddingRightForForm:(JXForm*)form;
//-(CGFloat)paddingBottomForForm:(JXForm*)form;

@end

@protocol JXFormDataSource <NSObject>

@required
-(UIView*)form:(JXForm*)form contentViewForRow:(NSInteger)row column:(NSInteger)column;

@end

@interface JXForm : UIView

@property (nonatomic,weak) id<JXFormDelegate> delegate;
@property (nonatomic,weak) id<JXFormDataSource> dataSource;

-(instancetype)initWithFrame:(CGRect)frame;

-(UIView*)cellAtRow:(NSInteger)row column:(NSInteger)column;

@end
