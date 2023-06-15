//
//  UserLoginModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/8/23.
//

import Foundation

struct UserLoginModel: Codable {

    let fname: String?
    let lname: String?
    let email: String?
    let phone: String?
    let country: String?
    let state: String?
    let city: String?
    let address: String?
    let password: String?
}
