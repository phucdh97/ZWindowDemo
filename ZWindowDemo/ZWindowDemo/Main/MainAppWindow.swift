//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class MainAppWindow: UIWindow {
    
    override func makeKey() {
        print("MainAppWindow makeKey ")
        super.makeKey()
    }
    
    override func makeKeyAndVisible() {
        print("MainAppWindow makeKeyAndVisible")
        super.makeKeyAndVisible()
    }

    override func resignKey() {
        print("MainAppWindow resignKey")
        super.resignKey()
    }
    
    override func becomeKey() {
        print("MainAppWindow becomeKey")
        super.becomeKey()
    }
    
    
    override var debugDescription: String {
        return "Main App Window"
    }
    
}
