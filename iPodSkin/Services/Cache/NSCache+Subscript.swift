//
//  NSCache+Subscript.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 25.03.2024.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ url: URL) -> CacheEntryObject? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value
        }
        
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                setObject(entry, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}
