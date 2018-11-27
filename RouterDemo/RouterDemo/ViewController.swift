//
//  ViewController.swift
//  SwiftyRouterDemo
//
//  Created by 罗树新 on 2018/11/25.
//  Copyright © 2018 罗树新. All rights reserved.
//

import UIKit
import Router

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func test1(_ sender: UIButton) {
        if let detail = Router.viewController(with: "detail://title=哈哈") {
            present(detail, animated: true, completion: nil)
        }
    }
    
    @IBAction func test2(_ sender: UIButton) {
        if let detail = Router.viewController(with: DetailPathModule.detail(UIColor.red)) {
            present(detail, animated: true, completion: nil)
        }
    }
}

