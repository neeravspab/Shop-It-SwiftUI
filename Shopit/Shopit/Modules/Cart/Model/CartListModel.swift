//
//  CartListModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/18/23.
//

import Foundation

struct CartListModel: Identifiable {
    
    let id = UUID().uuidString
    let image: String
    let title: String
    let price: String
    let rating: String
    let documentid: String
    let category: String
    let description: String
    var qty: Int
    let cartid:String
}
