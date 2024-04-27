//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    var appeared: Bool = false
    lazy var showCallButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show Call", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleButtonDidTap(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleButtonDidTap2(button:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.view.alpha = 0.2
        self.view.addSubview(showCallButton)
        showCallButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showCallButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            showCallButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            showCallButton.widthAnchor.constraint(equalToConstant: 100),
            showCallButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        self.view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: showCallButton.bottomAnchor, constant: 100),
            dismissButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dismissButton.widthAnchor.constraint(equalToConstant: 100),
            dismissButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        testLabel.text = "this is content of label zzfwe fwe fw wef ww we .we. fwe w. ew. "
        testLabel.numberOfLines = 2
        self.view.addSubview(testLabel)
        
    }
    
    
    @objc private func handleButtonDidTap(button: UIButton) {
        CallService.shared.startCall()
    }

    @objc private func handleButtonDidTap2(button: UIButton) {
        dismiss(animated: true) {
            //
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        appeared = true
        if #available(iOS 16.0, *) {
            self.setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            // Fallback on earlier versions
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if self.appeared {
            return .all
        }
        
        return .portrait
    }
    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .portrait
//    }
}
