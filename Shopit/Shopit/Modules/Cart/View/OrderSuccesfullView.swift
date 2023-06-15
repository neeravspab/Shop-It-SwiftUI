//
//  OrderSuccesfullView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/19/23.
//

import SwiftUI

struct OrderSuccesfullView: View {
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                GifImage("success")
                    .frame(width: 200, height: 200)
                
                Text("Order Successfully Placed")
                    .font(.title)
                    .fontWeight(.semibold)
                Button {
                    Router.shared.selectedTab = 0
                } label: {
                    Text("Shop it")
                        .foregroundColor(Color(uiColor: .systemBackground))
                        .fontWeight(.semibold)
                        .padding()
                        .cornerRadius(10.0)
                }
                .frame(width: 300,height: 25)
                .padding()
                .background(Color(uiColor: .label))
                .cornerRadius(8)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: EmptyView() )
        }
    }
}

struct OrderSuccesfullView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSuccesfullView()
    }
}
