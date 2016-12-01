//
//  ViewController.swift
//  SwiftQRCode
//
//  Created by 董建新 on 2016/12/1.
//  Copyright © 2016年 longtime. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }


    func setupUI()  {
        
        //  输入设备
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        input = try? AVCaptureDeviceInput(device: device)
        
        //  输出设备
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue:DispatchQueue.main)
        
        //  会话
        session = AVCaptureSession()
        session?.addInput(input)
        session?.addOutput(output)
        //  必须在输出设备添加到会话后，设置输出设备算法为二维码算法
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode];
        
        //  创建预览图层
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = view.frame
        
        //  开启会话
        session?.startRunning()
        
        
    }

    
    //  代理方法的实现。已经输出元数后调用
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        
        print(metadataObjects.description)
        
        /*
         [<AVMetadataMachineReadableCodeObject: 0x17002ae40, type="org.iso.QRCode", bounds={ 0.3,0.2 0.4x0.7 }>corners { 0.4,0.9 0.8,0.9 0.7,0.2 0.3,0.2 }, time 36532528906208, stringValue "http://weixin.qq.com/r/c--44HDENS1KrTSD96ph"]
         
         */
        
        
        //  当完成扫描后，将session进行关闭
        session?.stopRunning()
        
    }
    
    
    
    // MARK: - 属性
    var input: AVCaptureInput?
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    
    
    

}

