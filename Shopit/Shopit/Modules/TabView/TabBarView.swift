//
//  TabView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/22/23.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        TabView(selection: $router.selectedTab) {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)

            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }.tag(2)
            
         //   AccountView()
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(3)
        }
    }
}
