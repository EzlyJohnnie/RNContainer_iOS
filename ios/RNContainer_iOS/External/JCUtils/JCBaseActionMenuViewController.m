//
//  JCBaseActionMenuViewController.m
//
//  Created by Johnnie on 19/12/17.
//

#import "JCBaseActionMenuViewController.h"
#import "UIView+JCUtils.h"
#import "JCUtils.h"

@interface JCBaseActionMenuViewController ()

@property UIView *contentView;
@property CGFloat origianlBottomConst;

@property (assign, nonatomic) BOOL hasDismissed;

@end





@implementation JCBaseActionMenuViewController

- (instancetype)init{
    if(self = [super init]){
        [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    _contentView = [self getContentView];
    [self setupView];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self viewDidRotate];
    }];
}

- (void)viewDidRotate{
    [self updateLayout];
}

- (void)updateLayout{
    if([JCUtils isIPhoneX]){
        CGFloat left = 0, right = 0;
        if([JCUtils isLandscapeLeft]){
            left += [JCUtils safeMarginForIPhoneX];
        }
        else if([JCUtils isLandscapeRight]){
            right += [JCUtils safeMarginForIPhoneX];
        }
        _const_contentViewLeft.constant = left;
        _const_contentViewRight.constant = right;
    }
}

- (UINavigationController *)displayedNavigationController{
    return self.navigationController;
}

- (UINavigationItem *)displayedNavigationItem{
    return self.navigationItem;
}

/**
 * should override by child
 * return: contentView
 **/
- (UIView *)getContentView{
    return nil;
}

- (BOOL)hasBackgroundImage{
    return NO;
}

- (void)setupView{
    [self updateLayout];
    if([JCUtils isIPhoneX]){
        _const_viewHeight.constant += [self bottomSafeMarginForIphoneX];
        _const_contentViewBottom.constant -= [self bottomSafeMarginForIphoneX];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.0];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *emptyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapConsumer)];
    [_contentView addGestureRecognizer:emptyTap];
    
    if(_contentView && [self allowDragToDismiss]){
        [self addDragListener];
    }
}

- (BOOL)allowDragToDismiss{
    return YES;
}

- (CGFloat)bottomSafeMarginForIphoneX{
    return [JCUtils safeMarginForIPhoneX];
}

- (void)addDragListener{
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onContentViewDragged:)];
    [panGR setMaximumNumberOfTouches:1];
    [panGR setMinimumNumberOfTouches:1];
    panGR.delegate = self;
    [_contentView addGestureRecognizer:panGR];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [[_contentView gestureRecognizers] containsObject:gestureRecognizer]) {
        return [self shouldBeginContentViewDarg:(UIPanGestureRecognizer *)gestureRecognizer];
    }
    return YES;
}

- (BOOL)shouldBeginContentViewDarg:(UIPanGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (void)onContentViewDragged:(UIPanGestureRecognizer *)sender {
    if(!_hasDismissed){
        UIView *draggableView = [self getDraggableView];
        CGPoint offset = [sender translationInView:self.view];
        float newY = draggableView.jc_y + offset.y;
        float contentViewOriginalY = self.view.jc_height - draggableView.jc_height;
        if(newY < contentViewOriginalY){
            newY = contentViewOriginalY;
        }
        float dargRatio = ((newY - contentViewOriginalY) / contentViewOriginalY);
        
        if(sender.state == UIGestureRecognizerStateChanged){
            CGFloat alpha = 0.5 - dargRatio * 0.5;
            if(alpha > 0.5){
                alpha = 0.5;
            }
            
            [draggableView jc_setY:newY];
            self.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:alpha];
            
            [sender setTranslation:CGPointMake(0, 0) inView:self.view];
        }
        else if(sender.state == UIGestureRecognizerStateEnded){
            if(newY > self.view.jc_height - draggableView.jc_height / 2){
                [self dismiss];
            }
            else{
                [UIView animateWithDuration:0.3 * dargRatio animations:^{
                    self.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.5];
                    [draggableView jc_setY:contentViewOriginalY];
                }];
            }
        }
    }
}


/**
 @return the view who will move when drag Recognized
 */
- (UIView *)getDraggableView{
    return _contentView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _origianlBottomConst = _const_contentViewBottom.constant;
    
    _const_contentViewBottom.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.5];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self contentViewDidAppear];
    }];
}

/**
 * should override in child if need
 **/
- (void)contentViewDidAppear{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapConsumer{
    //consume tap event to avoid dismiss self. do nothing
}

- (void)dismiss{
    _hasDismissed = YES;
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion: (void (^ __nullable)(void))completion {
    _const_contentViewBottom.constant = _origianlBottomConst;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}
@end
