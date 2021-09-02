//
//  Alamofire.swift
//  WantHelp
//
//  Created by Булат on 02.09.2021.
//

import Foundation
import Alamofire

class Alamofire {
    
    static let shared = Alamofire()
    let decoder = JSONDecoder()
    func dowonloadDataFromFirebase() {
        let request = AF.request("https://networking-56bfe-default-rtdb.firebaseio.com/.json")
        request.responseJSON { (data) in
            print("Request \(data)")
        }
        request.responseDecodable(of: [CategoryRoot].self) { (response) in
            guard let model = response.value else { return }
            print("Model \(model)")
        }
    }
}
