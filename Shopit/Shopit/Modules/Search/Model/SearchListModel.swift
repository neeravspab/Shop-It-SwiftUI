//
//  SearchListModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import Foundation

struct SearchListModel: Identifiable {
    
    let id = UUID().uuidString
    let image: String
    let title: String
    let price: String
    let rating: String
    let documentid: String
    let category: String
    let description: String
    let qty: String
}

