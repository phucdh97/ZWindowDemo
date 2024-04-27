//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class ExtraWindow: UIWindow {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ExtraWindow init \(self)")
    }
    
    deinit {
        print("ExtraWindow Deinit: \(self)")
    }
    
    override var frame: CGRect {
        didSet {
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    override func makeKey() {
        print("ExtraWindow makeKey ")
        super.makeKey()
    }
    
    override func makeKeyAndVisible() {
        print("ExtraWindow makeKeyAndVisible")
        super.makeKeyAndVisible()
    }

    override func resignKey() {
        print("ExtraWindow resignKey")
        super.resignKey()
    }
    
    override func becomeKey() {
        print("ExtraWindow becomeKey")
        super.becomeKey()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
//        print("Call hit view: \(hitView)")
        if hitView == self.rootViewController?.view {
            return nil
        }
        
        return hitView
    }
    
    override var debugDescription: String {
        return "Call Window"
    }
}
