//
//  CartViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/18/23.
//

import Foundation
import Firebase

class CartViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    private var userid = "\(UserDefaults.standard.object(forKey: "userid") ?? "")"
    @Published var arrCartProductList = [CartListModel]()
    
    init() {
        getCartProducts()
    }
    
    func getCartProducts() {
        
        print(self.userid)
        DispatchQueue.main.async {
            self.db.collection("Users").document(self.userid).collection("Cart")
                .addSnapshotListener  { querySnapshot, error in
                    
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(error!)")
                        return
                    }
                    
                    self.arrCartProductList = documents.map { (queryDocumentSnapshot) -> CartListModel in
                        let data = queryDocumentSnapshot.data()
                        let cartletdata = CartListModel(image: "\(data["image"] ?? "")",
                                                        title: "\(data["pname"] ?? "")",
                                                        price: "\(data["price"] ?? "")",
                                                        rating: "\(data["rating"] ?? "")",
                                                        documentid: "\(data["productid"] ?? "")",
                                                        category: "\(data["category"] ?? "")",
                                                        description: "\(data["description"] ?? "")",
                                                        qty: Int("\(data["qty"] ?? "")") ?? 1,
                                                        cartid: "\(data["cartid"] ?? "")")
                        return cartletdata
                    }
                }
        }
    }
    
    func updateQuentity(cartid: String, qty: String, complition: @escaping (_ : Event) -> Void) {

        DispatchQueue.main.async { [self] in
            let ref = db.collection("Users").document(userid).collection("Cart").document(cartid)
            ref.updateData([
                "qty": qty
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                    complition(.datafail)
                } else {
                    print("Document successfully updated")
                    complition(.dataloaded)
                }
            }
        }
    }
    
    func removeFromCart(cartid: String, complition: @escaping (_ : Event) -> Void) {

        DispatchQueue.main.async { [self] in
            
            db.collection("Users").document(userid).collection("Cart").document(cartid).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    
    func placeOrder(complition: @escaping (_ : Event) -> Void) {
        
        arrCartProductList.forEach { item in
            
            /// Add to Order Table
            DispatchQueue.main.async { [self] in

                let ref = db.collection("Users").document(userid).collection("Order").document()
                
                let data = ["description": item.description,
                            "image": item.image,
                            "pname": item.title,
                            "price": item.price,
                            "qty": item.qty,
                            "rating": item.rating,
                            "productid": item.documentid,
                            "orderid": ref.documentID
                ] as [String : Any]
                
                ref.setData(data) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        complition(.datafail)
                    } else {
                        print("order placing in progress...")
                        complition(.dataloaded)
                    }
                }
            }
        }
    }
    
    /// Remove From Cart Table
    /// 
    func emptyCartItems() {
        
        arrCartProductList.forEach { item in
            
            self.removeFromCart(cartid: item.cartid) { result in
                switch result {
                case .dataloaded:
                    print("Item removed from cart")
                case .datafail:
                    print("Item not removed from cart")
                }
            }
        }
    }
    
    func calculatePrice() -> String{
        
        var price:Float = 0
        
        arrCartProductList.forEach { item in
            price += Float(item.qty) * (Float(item.price) ?? 0.00)
        }
        
        return String(format: "$ %.2f", price)

    }
    
    func calculateTaxPrice() -> String {
        
        var price:Float = 0
        let textPercent = 0.07
        var textPrice:Float = 0
        
        /// Get all products Price
        arrCartProductList.forEach { item in
            price += Float(item.qty) * (Float(item.price) ?? 0.00)
        }
        
        /// Get TextPrice and Price
        textPrice = price * Float(textPercent)

        return String(format: "$ %.2f", textPrice)
    }
    
    func calculateTotalPrice() -> String {
        
        var price:Float = 0
        let textPercent = 0.07
        var textPrice:Float = 0
        var totalprice: Float = 0
        
        /// Get all products Price
        arrCartProductList.forEach { item in
            price += Float(item.qty) * (Float(item.price) ?? 0.00)
        }
        /// Get TextPrice and Price
        textPrice = price * Float(textPercent)

        
        /// Add TextPrice and Price for Total Price

        totalprice = price + textPrice    // 110
        return String(format: "$ %.2f", totalprice)
    }
}
