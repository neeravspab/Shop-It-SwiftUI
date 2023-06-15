//
//  LoginViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/7/23.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    
    private let db = Firestore.firestore()

    
    func CheckuserLogin(email: String, password: String, complition: @escaping (_ : Event) -> Void) {
        
        DispatchQueue.main.async {
            self.db.collection("Users")
                .whereField("email", isEqualTo: email)
                .whereField("password", isEqualTo: password)
                .getDocuments { querysnapShot, error in
                    if let err = error {
                        print("something went wrong \(err)")
                        complition(.datafail)
                        return
                    }
                    
                    if ((querysnapShot?.documents.isEmpty) != nil) {
                        complition(.datafail)
                    }
                    for document in querysnapShot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        UserDefaults.standard.set(document.data(), forKey: "userdetail")
                        UserDefaults.standard.set(document.documentID, forKey: "userid")
                        UserDefaults.standard.set(true, forKey: "isLogin")
                        complition(.dataloaded)
                    }
                }
        }
    }
}
