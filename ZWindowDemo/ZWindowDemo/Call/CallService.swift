//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class CallService: NSObject {
    public static let shared = CallService()
    
    var callVC: CallViewController?
    
    public func startCall() {
        let vc = CallViewController()
        print("Init callview \(vc)")
        vc.showCallView()
        vc.delegate = self
        callVC = vc
    }
    
    private func releaseCallView() {
        print("Release callview \(callVC)")
        callVC = nil
    }
}

extension CallService: CallViewControllerDelegate {
    func didDismissCallView() {
        releaseCallView()
    }
}
