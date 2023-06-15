//
//  HomeViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/12/23.
//

import Foundation
import Firebase

class HomeViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published var arrimageList: [String] = []
    @Published var arrProductList: [ProductModel] = []
    
    init() {
        getbannerList()
        getProducts()
    }
    
    /// Get Banner List
    private func getbannerList() {
        
        DispatchQueue.main.async {
            self.db.collection("Banners")
                .getDocuments { querysnapShot, error in
                    if let err = error {
                        print("something went wrong \(err)")
                        return
                    }
                    
                    for document in querysnapShot!.documents {
                        self.arrimageList.append("\(document.get("image") ?? "")")
                    }
                }
        }
    }
    
    /// Get Product List

    private func getProducts() {
        
        DispatchQueue.main.async {
            self.db.collection("Products")
                .getDocuments { querysnapShot, error in
                    if let err = error {
                        print("something went wrong \(err)")
                        return
                    }
                    
                    /// Get all document snapshot from cloud and add it to array
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
                        
                        self.arrProductList.append(data)
                    }
                }
        }
    }
}
