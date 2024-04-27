//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit


class ZTextView: UITextView {
    
    override func becomeFirstResponder() -> Bool {
        print("main becomeFirstResponder")
        return super.becomeFirstResponder()
        
    }

}

class MainViewController: UIViewController {

    var nameLabel: UILabel?
    var mainTextView: ZTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let textView = ZTextView()
        textView.backgroundColor = .orange
        textView.font = .systemFont(ofSize: 30)
        textView.text = "Main text"
        self.view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        textView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        mainTextView = textView
        
        let button = UIButton()
        button.setTitle("Show Call", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleTap(button:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        let button2 = UIButton()
        button2.setTitle("Show Sub View", for: .normal)
        button2.backgroundColor = .green
        button2.setTitleColor(.white, for: .normal)
        button2.addTarget(self, action: #selector(handleTap2(button:)), for: .touchUpInside)
        
        self.view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 40).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Main VC didAppear")
        
        if #available(iOS 16.0, *) {
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    
    @objc private func handleTap(button: UIButton) {
        CallService.shared.startCall()
        
    }
    
    @objc private func handleTap2(button: UIButton) {
        let subVC = DetailViewController()
        subVC.modalPresentationStyle = .fullScreen
        present(subVC, animated: true)
    }
//
//    @objc private func handleTap3(button: UIButton) {
//
//        print("main button 3 didtap")
//
//        self.mainTextView.becomeFirstResponder()
//    }
    
    @objc fileprivate func keyboardWillShow(notification: Notification) {
        print("main keyboardWillShow")
    }

    @objc fileprivate func keyboardWillHide(notification: Notification) {
        print("main keyboardWillHide")
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let mask = UXDeivce.sharedInstance.ZASetupInterfaceOrientationMask()
        print("Main view controller support orientation: \(mask.rawValue)")
         return mask
     }

//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
}


