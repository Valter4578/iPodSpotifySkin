//
//  AuthPlugin.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 17.11.2023.
//

import Foundation
import Moya

class TokenSource {
    var token: String?
    init() { }
}

struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard
            let token = tokenClosure() 
        else { return request }
        
        var request = request
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        return request
    }
}
