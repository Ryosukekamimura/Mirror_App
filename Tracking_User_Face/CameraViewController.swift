//
//  CameraViewController.swift
//  Tracking_User_Face
//
//  Created by 神村亮佑 on 2020/08/31.
//  Copyright © 2020 神村亮佑. All rights reserved.
//

import UIKit
import SwiftUI

final class CameraViewController: UIViewController {
    let cameraController = CameraController()
    var previewView: UIView!
    
    override func viewDidLoad() {
        previewView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        previewView.contentMode = UIView.ContentMode.scaleAspectFit
        
        view.addSubview(previewView)
        
        cameraController.prepare{ (error) in
            if let error = error{
                print(error)
                
            }
            
            try? self.cameraController.displayPreview(on: self.previewView)
        }
    }
}


extension CameraViewController : UIViewControllerRepresentable {
    
    
    public typealias UIViewControllerType = CameraViewController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CameraViewController>) -> CameraViewController {
        return CameraViewController()
    }
    
    public func updateUIViewController(_ uiViewController: CameraViewController, context: UIViewControllerRepresentableContext<CameraViewController>) {
        
    }
}


struct CameraViewController_Previews: PreviewProvider {
    static var previews: some View{
        Text("Hello World!")
    }
}
