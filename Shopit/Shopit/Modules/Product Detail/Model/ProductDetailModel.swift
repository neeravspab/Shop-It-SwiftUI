//
//  ProductDetailModel.swift
//  Shopit
//
//  Created by niravkumar patel on 3/30/23.
//

import Foundation

struct ProductModel: Identifiable {
    
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

struct Productlistmodel {
    
    let image: String
    let title: String
    let price: String
    let rating: Int
    let id: Int
    let category: String
    let description: String

}

