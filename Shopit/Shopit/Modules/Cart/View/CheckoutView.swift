//
//  CheckoutView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/19/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject private var cartViewModel = CartViewModel()
    @ObservedObject var accountViewModel = AccountViewModel()
    @State private var isOrderPlaced = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                ScrollView {
                    
                    VStack {
                        
                        VStack(spacing: 5) {
                            
                            HStack {
                                Text("Price")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                Text(cartViewModel.calculatePrice())
                            }
                            
                            HStack {
                                Text("TAX")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                Text(cartViewModel.calculateTaxPrice())
                            }
                            
                            HStack {
                                Text("Total Price")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                Text(cartViewModel.calculateTotalPrice())
                            }
                        }
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(10)
                        
                        VStack (alignment: .leading, spacing: 5) {
                            
                            HStack {
                                Text("Shipping Address")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            
                            Text("\(accountViewModel.userDetail["address"] ?? ""), \(accountViewModel.userDetail["city"] ?? ""), \(accountViewModel.userDetail["state"] ?? ""), \(accountViewModel.userDetail["country"] ?? "")")
                                .font(.title3)
                                .fontWeight(.light)
                        }
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(10)
                      
                    }
                    .padding()
                }
                
                VStack {
                    
                    NavigationLink(destination: OrderSuccesfullView().navigationBarBackButtonHidden(true), isActive: $isOrderPlaced) {
                        Button {
                            cartViewModel.placeOrder { result in
                                switch result {
                                case .dataloaded:
                                    print("Apple pay Order Successfull...")
                                    cartViewModel.emptyCartItems()
                                    isOrderPlaced = true
                                case .datafail:
                                    print("faild")
                                    isOrderPlaced = false
                                }
                            }
                        } label: {
                            HStack {
                                
                                Text("Buy with")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(uiColor: .label))

                                Image(systemName: "apple.logo")
                                    .tint(Color(uiColor: .label))
                                
                                Text("Pay")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(uiColor: .label))
                            }
                        }
                        .frame(width: 300,height: 25)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                    }
                    .navigationBarHidden(true)

                  //  .fullScreenCover(isPresented: $isOrderPlaced) { OrderSuccesfullView() }

                    NavigationLink(destination: OrderSuccesfullView().navigationBarBackButtonHidden(true), isActive: $isOrderPlaced) {
                        Button {
                            cartViewModel.placeOrder { result in
                                switch result {
                                case .dataloaded:
                                    print("Order Successfull...")
                                    cartViewModel.emptyCartItems()
                                    isOrderPlaced = true
                                case .datafail:
                                    print("faild")
                                    isOrderPlaced = false
                                }
                            }
                        } label: {
                            Text("Pay \(cartViewModel.calculateTotalPrice())")
                                .foregroundColor(Color("AppDark"))
                                .fontWeight(.semibold)
                                .padding()
                            
                                .background(Color(.systemBackground))
                                .cornerRadius(10.0)
                        }
                        .frame(width: 300,height: 25)
                        .padding()
                        .background(Color(uiColor: .systemBackground))
                        .cornerRadius(8)
                    }
                    .navigationBarHidden(true)
                }
                .padding(.bottom)
            }
            .background(Color(uiColor: .systemGray5))
            .padding(.bottom)
            
           // .navigationBarTitleDisplayMode(.large)
        }
    }
}
//
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}
