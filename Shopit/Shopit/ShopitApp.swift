//
//  ShopitApp.swift
//  Shopit
//
//  Created by niravkumar patel on 2/10/23.
//

import SwiftUI
import Firebase

@main
struct ShopitApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
           LaunchScreenView()
                .environmentObject(Router.shared)
        }
    }
}
