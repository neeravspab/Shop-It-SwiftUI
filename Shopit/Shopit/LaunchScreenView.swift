//
//  LaunchScreenView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/28/23.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State private var isload = false
    
    var body: some View {

        VStack {
            if isload == true {
                LoginView()
            } else {
                Image("applogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("\(UserDefaults.standard.bool(forKey: "isLogin"))")
                self.isload = true
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
