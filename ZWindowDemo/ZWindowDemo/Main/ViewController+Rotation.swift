//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit




private let swizzling: (UIViewController.Type) -> () = { viewController in
    
    let originalSelector = #selector(getter: UIViewController.supportedInterfaceOrientations)
    let swizzledSelector = #selector(getter: UIViewController.za_supportedInterfaceOrientations)
    
    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)
    
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}


private let swizzling2: (UIViewController.Type) -> () = { viewController in
    
    let originalSelector = #selector(viewController.viewWillAppear(_:))
    let swizzledSelector = #selector(viewController.proj_viewWillAppear(animated:))
    
    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)
    
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
    
}


extension UIViewController {
    
    static func classInit () {
//        swizzling(self)
        swizzling2(self)
    }
    
    @objc func proj_viewWillAppear(animated: Bool) {
        self.proj_viewWillAppear(animated: animated)

//        let viewControllerName = NSStringFromClass(type(of: self))
//        print("viewWillAppear: \(viewControllerName)")
    }
    
    @objc var za_supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        let viewControllerName = NSStringFromClass(type(of: self))
//        print("za_supportedInterfaceOrientations: \(viewControllerName)")
        let mask = UXDeivce.sharedInstance.ZASetupInterfaceOrientationMask()
        return mask
    }
    
}
