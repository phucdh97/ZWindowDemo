//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit
import QuartzCore
import AVKit

class CallView: UIView {
    
}


protocol CallViewControllerDelegate: AnyObject {
    func didDismissCallView()
}


class CallViewController: UIViewController {
    
    var localWindow: ExtraWindow?
    weak var delegate: CallViewControllerDelegate?
    
    var mask: UIInterfaceOrientationMask = .all
    var callLayout: [NSLayoutConstraint]!
    
    lazy var callView: CallView = {
        let view = CallView()
        return view
    }()
    
    lazy var label: UITextView = {
        let label = UITextView()
        label.backgroundColor = .blue
        label.textColor = .white
        label.text = "Text in this label"
        return label
    }()
    
    lazy var updateData: UIButton = {
        let button = UIButton()
        button.setTitle("Change Config", for: .normal)
        button.addTarget(self, action: #selector(handleUpdateButtonDidTap(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dimiss", for: .normal)
        button.addTarget(self, action: #selector(handleDismiss(button:)), for: .touchUpInside)
        return button
    }()
    
    
    lazy var minimizeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Minimize", for: .normal)
        button.addTarget(self, action: #selector(minimize(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var fullscreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open", for: .normal)
        button.addTarget(self, action: #selector(openCallView(button:)), for: .touchUpInside)
        button.alpha = 0.0
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        view.addSubview(fullscreenButton)
        fullscreenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullscreenButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            fullscreenButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            fullscreenButton.widthAnchor.constraint(equalToConstant: 150),
            fullscreenButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        self.view.addSubview(callView)
        callView.backgroundColor = .systemBlue
        callView.translatesAutoresizingMaskIntoConstraints = false
        let normalLayout = normalLayout()
        callLayout = normalLayout
        NSLayoutConstraint.activate(normalLayout)
//          //For PIP test
//        let vc = ZAVideoCallPiPViewController()
//        vc.parentVC = self
//        pipVC = vc
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.view.frame = self.view.bounds
        
        
        callView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: callView.topAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: callView.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        callView.addSubview(minimizeButton)
        minimizeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minimizeButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            minimizeButton.centerXAnchor.constraint(equalTo: callView.centerXAnchor),
            minimizeButton.widthAnchor.constraint(equalToConstant: 200),
            minimizeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        callView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: minimizeButton.bottomAnchor, constant: 10),
            dismissButton.centerXAnchor.constraint(equalTo: callView.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 200),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        callView.addSubview(updateData)
        updateData.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            updateData.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10),
            updateData.centerXAnchor.constraint(equalTo: callView.centerXAnchor),
            updateData.widthAnchor.constraint(equalToConstant: 200),
            updateData.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        print("Load CallView \(self)")
    }
    
    
    private func normalLayout() -> [NSLayoutConstraint] {
        let layout = [
            callView.topAnchor.constraint(equalTo: self.view.topAnchor),
            callView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            callView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            callView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ]
        
        return layout
    }
    
    private func dismissLayout() -> [NSLayoutConstraint] {
        let layout = [
            callView.topAnchor.constraint(equalTo: self.view.bottomAnchor),
            callView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            callView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            callView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ]
        
        return layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 16.0, *) {
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    
    private func addMyselfToWindow() {
    
        if localWindow == nil {
            localWindow = ExtraWindow(frame: UIScreen.main.bounds)
            localWindow?.rootViewController = self
        }
        localWindow?.isHidden = false
        localWindow?.windowLevel = UIWindow.Level(rawValue: UIWindow.Level.alert.rawValue + 1)
    }
    
    public func showCallView() {
        self.addMyselfToWindow()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return mask
    }
    
    @objc private func handleDismiss(button: UIButton) {
//        mask = UXDeivce.sharedInstance.ZASetupInterfaceOrientationMask()
//        reloadConfig()
        
        self.releaseUI()
        return
        
        let callView = self.callView
//        callView.removeConstraints(callView.constraints)
        
        UIView.animate(withDuration: 1.0) {
            
            NSLayoutConstraint.deactivate(self.callLayout)
            self.callLayout = self.dismissLayout()
            NSLayoutConstraint.activate(self.callLayout)
            
            self.view.layoutIfNeeded()
        } completion: { finish in
            self.releaseUI()
        }
    }
    
    @objc private func handleUpdateButtonDidTap(button: UIButton) {
        if mask == .all {
            mask = UXDeivce.sharedInstance.ZASetupInterfaceOrientationMask()
        } else {
            mask = .all
        }
        
        reloadConfig()
    }
    
    private func reloadConfig() {
        if #available(iOS 16.0, *) {
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            forceToDefaultOrientation()
//            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    
    private func forceToDefaultOrientation () {
        let defaultOrientation = UXDeivce.sharedInstance.ZASetupInterfaceOrientation()
        UIDevice.current.setValue(defaultOrientation.rawValue, forKey: "orientation")
    }
    
    private func releaseUI() {
        
        localWindow?.isHidden = true
        localWindow?.rootViewController = nil
        localWindow = nil
        
        self.delegate?.didDismissCallView()
    }
    
    
    @objc private func minimize(button: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.callView.alpha = 0.0
            self.fullscreenButton.alpha = 1.0
        }
    }
    
    @objc private func openCallView(button: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.callView.alpha = 1.0
            self.fullscreenButton.alpha = 0.0
        }
    }
    
    deinit {
        print("Deinit Call View: \(self)")
    }
}


