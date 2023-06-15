//
//  CartView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/28/23.
//

import SwiftUI
import Kingfisher

struct CartView: View {
    
    @ObservedObject private var cartViewModel = CartViewModel()

    var body: some View {
        
        NavigationView {
            
            VStack {

                ScrollView(.vertical,showsIndicators: false) {
                    LazyVStack {
                        
                        ForEach(cartViewModel.arrCartProductList) { iteam in
                            
                            CartListView(iteam: iteam)
                        }
                    }
                    .background(Color(.systemBackground))
                    .padding()
                }
                
                VStack {
                    
                    HStack {
                        Text("Total Price")
                            .font(.title2)
                        Spacer()
                        Text(cartViewModel.calculateTotalPrice())
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .padding([.top,.horizontal,.bottom])
                } //Bottom VStack Ends
            } //main VStack Ends..
            .navigationTitle("Cart")
            .navigationBarItems(trailing: NavigationLink(destination: CheckoutView().navigationTitle("Check Out"), label: {
                Text("Check Out")
            })
            )
        }
    }
}

//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
