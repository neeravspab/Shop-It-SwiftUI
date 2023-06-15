//
//  ProductViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/13/23.
//

import Foundation
import Firebase

class ProductViewModel: ObservableObject {

    private let db = Firestore.firestore()
    private var userid = "\(UserDefaults.standard.object(forKey: "userid") ?? "")"
    
    //ADD To CART
    
    func addToCart(cartdetail: ProductModel, complition: @escaping (_ : Event) -> Void) {
        
        DispatchQueue.main.async { [self] in

            let ref = db.collection("Users").document(userid).collection("Cart").document()
            
            let data = ["description": cartdetail.description,
                        "image": cartdetail.image,
                        "pname": cartdetail.title,
                        "price": cartdetail.price,
                        "qty": "1",
                        "rating": cartdetail.rating,
                        "productid": cartdetail.documentid,
                        "cartid": ref.documentID
                ]
            
            ref.setData(data) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    complition(.datafail)
                } else {
                    print("Document added with ID: \(ref.documentID)")
                    complition(.dataloaded)
                }
            }
        }
    }
    
    func isProductedAlreadyAddedToCart(productid: String, complition: @escaping (_ : Event) -> Void){
        
        DispatchQueue.main.async { [self] in
            self.db.collection("Users").document(userid).collection("Cart")
                .whereField("productid", isEqualTo: productid)
                .getDocuments { querysnapShot, error in
                    if let err = error {
                        print("something went wrong \(err)")
                        complition(.datafail)
                        return
                    }
                    
                    for document in querysnapShot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        complition(.dataloaded)
                    }
                }
        }
    }
}


