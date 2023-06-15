//
//  AccountViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import Foundation

class AccountViewModel: ObservableObject {
    
    @Published var userDetail = [String:String]()
    
    init() {
            getUserDetail()
    }
    
    func getUserDetail() {

        userDetail = UserDefaults.standard.object(forKey: "userdetail") as? [String:String] ?? [:]

    }
}
