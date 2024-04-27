//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class UXDeivce: NSObject {
    
    public  static let sharedInstance = UXDeivce()
    
    private override init() { }
    
    var lauchAppUIInterfaceOrientation: UIInterfaceOrientation = .portrait
    var lauchAppUIInterfaceOrientationMask: UIInterfaceOrientationMask = .all
    
    public func setupZAInterfaceOrientation() {
        var orientation = UIApplication.shared.statusBarOrientation
        
        var orientationMask: UIInterfaceOrientationMask
        
        switch orientation {
        case .portrait, .portraitUpsideDown:
            orientationMask = [.portrait, .portraitUpsideDown]
        case .landscapeLeft, .landscapeRight:
            orientationMask = [.landscapeLeft, .landscapeRight]
        default:
            orientationMask = [.portrait, .portraitUpsideDown]
        }
        
        lauchAppUIInterfaceOrientation = orientation
        lauchAppUIInterfaceOrientationMask = orientationMask
    }
    
    public func ZASetupInterfaceOrientation() -> UIInterfaceOrientation {
        return lauchAppUIInterfaceOrientation
    }
    
    public func ZASetupInterfaceOrientationMask() -> UIInterfaceOrientationMask {
        return lauchAppUIInterfaceOrientationMask
    }
    
    public class func za_interfaceOrientation() -> UIInterfaceOrientation {
        guard let windowScene = self.za_topVisibleWindow()?.windowScene else {
            print("Bug orientation")
            return .portrait
        }
        
        print("Current orientation \(windowScene.interfaceOrientation)")
        
        return windowScene.interfaceOrientation
    }
    
    public class func za_topVisibleWindow () -> UIWindow? {
        let windows = UIApplication.shared.windows
        var res: UIWindow?
        for window in windows.reversed() {
            if let pre = res {
                if (window.windowLevel > pre.windowLevel) && !window.isHidden {
                    res = window
                }
            }
        }
        
        return res
    }
}
