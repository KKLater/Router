//
//  DetailViewController.swift
//  SwiftyRouterDemo
//
//  Created by 罗树新 on 2018/11/25.
//  Copyright © 2018 罗树新. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var viewColor: UIColor?
    var newTitle: String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = viewColor ?? UIColor.blue
        title = newTitle ?? "详情"
        
        print("title = \(title!)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}
