//
//  Store.swift
//  narson task
//
//  Created by Napster on 31/08/2019.
//  Copyright © 2019 Napster. All rights reserved.
//

import Foundation


protocol IDAO : Codable {
    var id: String? { get set }
    func parseIntoDictionary() -> [String : Any]?
}


extension IDAO {
    func parseIntoDictionary() -> [String : Any]? {
        do {
            return try JSONSerialization.jsonObject(with: JSONEncoder().encode(self), options: []) as? [String:Any]
        } catch  {
            return nil
        }
    }
}



class Store {
    init() {
        
    }
    
    func getItems<T: IDAO>(completion: @escaping([T]?, Error?) -> ()) {
        
    }
}
