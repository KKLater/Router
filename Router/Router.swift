//
//  SwiftyRouter.swift
//  SwiftyRouterDemo
//
//  Created by 罗树新 on 2018/11/25.
//  Copyright © 2018 罗树新. All rights reserved.
//

import UIKit

public typealias  RouterParameter = [String: Any]
public typealias  RouterScheme = [String: Any]

public protocol RouterPathable {
    var any: AnyClass { get }
    var parameters: RouterParameter? { get }
}

public protocol RouterSchemeable {
    var schemes: RouterScheme? { get }
}

public protocol Routable {
    static func initWithParameters(_ params: RouterParameter?) -> UIViewController;
}


public class Router: NSObject {
    
    public static let `default` = Router()
    
    public var urls: RouterSchemeable?
    
    public override init() {
        super.init()
    }
    
    open class func viewController(with path: RouterPathable, parametersConfiguration: (() -> [String: AnyObject])? = nil) -> UIViewController? {
        return Router.default.viewController(with: path, parametersConfiguration: parametersConfiguration)
    }
    
    open class func viewController(with url: String, parametersConfiguration: (() -> [String: AnyObject])? = nil) -> UIViewController? {
        return Router.default.viewController(with: url, parametersConfiguration: parametersConfiguration)
    }
        
    private func viewController(with path: RouterPathable, parametersConfiguration: (() -> [String: AnyObject])? = nil) -> UIViewController? {
        if let moduleClass = path.any as? Routable.Type {
            var pathParameters = path.parameters
            if let parameters = parametersConfiguration?() {
                parameters.forEach { (key, value) in
                    pathParameters?.updateValue(value, forKey: key)
                }
            }
            let vc = moduleClass.initWithParameters(pathParameters)
            return vc
        }
        return nil
    }
    
    private func viewController(with url: String, parametersConfiguration: (() -> [String: AnyObject])? = nil) -> UIViewController? {
        if self.urls == nil {
            return nil
        }
        if !url.contains("://") {
            return nil
        }
        let urls = url.components(separatedBy: "://")
        if urls.count == 0 {
            return nil
        }
        var parameters: [String: AnyObject] = [String: AnyObject]()
        if urls.count > 1 {
            let parameterString = urls[1]
            let parametersStrs = parameterString.components(separatedBy: "&")
            for parameterStr in parametersStrs {
                let keyValues = parameterStr.components(separatedBy: "=")
                var key: String?
                var value: String?
                if keyValues.count > 0 {
                    key = keyValues[0]
                    if keyValues.count > 1 {
                        value = keyValues[1]
                    } else {
                        value = nil
                    }
                    if let k = key {
                        parameters[k] = value as AnyObject
                    }
                }
            }
        }
        
        if let blockParameters = parametersConfiguration?() {
            blockParameters.forEach { (key, value) in
                parameters.updateValue(value, forKey: key)
            }
        }
        if var scheme = urls.first {
            scheme = scheme + "://"
            if let schemes = self.urls?.schemes, schemes.count > 0 {
                if let moduleClass = schemes[scheme] as? Routable.Type {
                    let vc = moduleClass.initWithParameters(parameters)
                    return vc
                }
            }
        }
        return nil
    }
    
    
    private func scheme(for urlString: String) -> String? {
        if !urlString.contains("://") {
            return nil
        }
        let urls = urlString.components(separatedBy: "://")
        if urls.count == 0 {
            return nil
        }
        
        if var scheme = urls.first {
            scheme = scheme + "://"
            return scheme
        }
        return nil
    }
}
