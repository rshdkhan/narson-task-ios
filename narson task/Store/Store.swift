//
//  Store.swift
//  narson task
//
//  Created by Napster on 31/08/2019.
//  Copyright © 2019 Napster. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase


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
    private var db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    func getItems<T: IDAO>(path: String, type: T.Type, completion: @escaping([T]?, Error?) -> ()) {
        db.collection(path).addSnapshotListener { (snapshot, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let documents = snapshot?.documents {
                var items: [T] = []
                
                do {
                    for doc in documents {
                        let object = try FirebaseDecoder().decode(type, from: doc.data())
                        items.append(object)
                    }
                    completion(items, nil)
                } catch {
                    completion(nil,NSError(domain: "", code: 147, userInfo: [NSLocalizedDescriptionKey:"Can not convert object to IDAO"]) )
                }
            }
        }
    }
}


