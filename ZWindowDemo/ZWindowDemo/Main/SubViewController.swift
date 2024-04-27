//
//  CallService.swift
//  ZWindowDemo
//
//  Created by Do Huu Phuc on 27/4/24.
//

import UIKit

class SubViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        label.text = "Text in this label"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
