//
//  SearchViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import Foundation
import Firebase
import SwiftUI

class SearchViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    @Published var searchText = ""
    @Published var arrCategoryProducts: [ProductModel] = []
    @Published var filterproducts:[ProductModel] = []
    
    func fetchDataCategoryWise( category: String) {
        
        print("Category: \(category)")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.db.collection("Products")
                .whereField("category", isEqualTo: category)
                .getDocuments { querysnapShot, error in
                    if let err = error {
                        print("something went wrong \(err)")
                        return
                    }
                    
                    for document in querysnapShot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        let data:ProductModel = ProductModel(image: "\(document.get("image") ?? "")",
                                                                   title: "\(document.get("pname") ?? "")",
                                                                   price: "\(document.get("price") ?? "")",
                                                                   rating: "\(document.get("rating") ?? "")",
                                                                   documentid: "\(document.documentID)",
                                                                   category: "\(document.get("category") ?? "")",
                                                                   description: "\(document.get("description") ?? "")",
                                                                   qty: "\(document.get("qty") ?? "")")
                        
                        self.arrCategoryProducts.append(data)
                    }
                    self.filterproducts = self.arrCategoryProducts
                }
        })
    }
    
    func filterdata() {
        
        withAnimation(.linear) {
            
            self.filterproducts = self.arrCategoryProducts.filter {
                return $0.title.lowercased().contains(self.searchText.lowercased())
            }
        }
    }
}

