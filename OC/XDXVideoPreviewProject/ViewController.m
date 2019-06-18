//
//  ViewController.m
//  XDXVideoPreviewProject
//
//  Created by 小东邪 on 2019/6/3.
//  Copyright © 2019 小东邪. All rights reserved.
//

#import "ViewController.h"
#import "XDXCameraModel.h"
#import "XDXCameraHandler.h"
#import "XDXPreviewView.h"

@interface ViewController ()<XDXCameraHandlerDelegate>

@property (nonatomic, strong) XDXCameraHandler              *cameraHandler;
@property (nonatomic, strong) XDXPreviewView                *previewView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureCamera];
    [self configurePreview];
    AVCaptureVideoPreviewLayer
}

- (void)configurePreview {
    self.previewView = [[XDXPreviewView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.previewView];
}

- (void)configureCamera {
    XDXCameraModel *model = [[XDXCameraModel alloc] initWithPreviewView:self.view
                                                                 preset:AVCaptureSessionPreset1280x720
                                                              frameRate:30
                                                       resolutionHeight:720
                                                            videoFormat:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange
                                                              torchMode:AVCaptureTorchModeOff
                                                              focusMode:AVCaptureFocusModeContinuousAutoFocus
                                                           exposureMode:AVCaptureExposureModeContinuousAutoExposure
                                                              flashMode:AVCaptureFlashModeAuto
                                                       whiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance
                                                               position:AVCaptureDevicePositionBack
                                                           videoGravity:AVLayerVideoGravityResizeAspect
                                                       videoOrientation:AVCaptureVideoOrientationLandscapeRight
                                             isEnableVideoStabilization:YES];
    
    XDXCameraHandler *handler   = [[XDXCameraHandler alloc] init];
    self.cameraHandler          = handler;
    handler.delegate            = self;
    [handler configureCameraWithModel:model];
    [handler startRunning];
}

#pragma mark - Delegate
- (void)xdxCaptureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVPixelBufferRef pixBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self.previewView displayPixelBuffer:pixBuffer];
}

@end
