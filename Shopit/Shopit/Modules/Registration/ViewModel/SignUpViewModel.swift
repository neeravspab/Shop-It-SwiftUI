//
//  SignUpViewModel.swift
//  Shopit
//
//  Created by niravkumar patel on 4/11/23.
//

import Foundation
import Firebase
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    func addUser(userdetail: UserLoginModel, complition: @escaping (_ : Event) -> Void) {

        DispatchQueue.main.async {

            var ref: DocumentReference? = nil
            ref = self.db.collection("Users").addDocument(data: [
                "fname":userdetail.fname ?? "",
                "lname":userdetail.lname ?? "",
                "email":userdetail.email ?? "",
                "phone":userdetail.phone ?? "",
                "country":userdetail.country ?? "",
                "state":userdetail.state ?? "",
                "city":userdetail.city ?? "",
                "address":userdetail.address ?? "",
                "password":userdetail.password ?? "",
                
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    complition(.datafail)
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    
                    complition(.dataloaded)
                }
            }
        }
    }
}
