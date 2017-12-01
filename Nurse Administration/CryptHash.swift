//
//  Ecryption.swift
//  Nurse Administration
//
//  Created by Cavalier Revolt on 11/29/17.
//  Copyright © 2017 Cavalier Revolt. All rights reserved.
//
import Foundation

class CryptHash {

    func hash(string: String?) -> String? {
        guard let data = string?.data(using: String.Encoding.utf8) else { return nil }
        
        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    
}
