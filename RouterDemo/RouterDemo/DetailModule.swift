//
//  DetailModule.swift
//  SwiftyRouterDemo
//
//  Created by 罗树新 on 2018/11/25.
//  Copyright © 2018 罗树新. All rights reserved.
//

import UIKit
import Router

enum DetailPathModule: RouterPathable {
    case detailNoParameters
    case detail(UIColor)
    
    var parameters: RouterParameter? {
        switch self {
        case .detail(let color):
            return ["viewColor": color]
        case .detailNoParameters:
            return nil
        }
    }
    
    
    var any: AnyClass {
        switch self {
        case .detail:
            return DetailViewController.self
        case .detailNoParameters:
            return DetailViewController.self
        }
    }
}

struct RouterUrls: RouterSchemeable {
    var schemes: RouterScheme? {
        var schemesConfig = RouterScheme()
        schemesConfig["detail://"] = DetailViewController.self
        return schemesConfig
    }
}


extension DetailViewController: Routable {
    static func initWithParameters(_ params: RouterParameter?) -> UIViewController {
        let detail: DetailViewController = DetailViewController()
        if let color = params?["viewColor"] as? UIColor {
            detail.viewColor = color
        }
        if let title = params?["title"] as? String {
            detail.newTitle = title
        }
        return detail
    }
}

