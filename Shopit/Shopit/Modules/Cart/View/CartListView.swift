//
//  CartListView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/18/23.
//

import SwiftUI
import Kingfisher

struct CartListView: View {

    @State var iteam:CartListModel
    @ObservedObject private var cartViewModel = CartViewModel()
    
    var body: some View {
        
        HStack(spacing: 15) {
            
            KFImage(URL(string: "\(iteam.image)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .cornerRadius(15.0)
            
            VStack(alignment: .leading, spacing: 10.0) {
                
                Text("\(iteam.title)")
                    .fontWeight(.semibold)
                    .font(.title2)
                
                Text("\(iteam.description)")
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.title3)
                    .lineLimit(2)
                
                HStack {
                    Text("$"+iteam.price)
                        .font(.system(size: 12.0))
                        .fontWeight(.regular)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        
                        if iteam.qty > 1 {
                            iteam.qty -= 1
                            cartViewModel.updateQuentity(cartid: iteam.cartid, qty: "\(iteam.qty)") { result in
                                switch result {
                                case .dataloaded:
                                    print("success")
                                case .datafail:
                                    print("faild")
                                }
                            }
                        } else {
                            cartViewModel.removeFromCart(cartid: iteam.cartid) { result in
                                switch result {
                                case .dataloaded:
                                    print("Deleted Succesfully")
                                case .datafail:
                                    print("Faild to remove from cart")
                                }
                            }
                        }
                        
                    } label: {
                        Circle()
                            .foregroundColor(Color("AppDark"))
                            .frame(width: 30.0,height: 30.0)
                            .overlay {
                                Image(systemName: "minus")
                                    .foregroundColor(Color(.systemBackground))
                            }
                    }
                    
                    Text("\(iteam.qty)")
                        .foregroundColor(Color(.label))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.all,7)
                    
                    
                    Button {
                        iteam.qty  = iteam.qty + 1
                        cartViewModel.updateQuentity(cartid: iteam.cartid, qty: "\(iteam.qty)") { result in
                            switch result {
                            case .dataloaded:
                                print("success")
                            case .datafail:
                                print("faild")
                            }
                        }
                        
                    } label: {
                        
                        Circle()
                            .foregroundColor(Color("AppDark"))
                            .frame(width: 30.0,height: 30.0)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundColor(Color(.systemBackground))
                            }
                    }
                }
                
            }
            .foregroundColor(Color(.label))
            .padding()
        }
    }
}

//struct QuentityView: View {
//
//    @State var quantity:Int
//    @State var price:Double
//
//    var body: some View {
//        VStack (alignment: .leading) {
//
//            Text("Quantity")
//                .fontWeight(.semibold)
//                .font(.title3)
//
//            HStack {
//
//                Button {
//                    if quantity != 1 {
//                        quantity -= 1
//
//                    }
//                } label: {
//                    Circle()
//                        .foregroundColor(Color("AppDark"))
//                        .frame(width: 30.0,height: 30.0)
//                        .overlay {
//                            Image(systemName: "minus")
//                                .foregroundColor(Color(.systemBackground))
//                        }
//                }
//
//                Text("\(quantity)")
//                    .foregroundColor(Color(.label))
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .padding(.all,7)
//
//                Button {
//                    quantity = quantity + 1
//
//                } label: {
//
//                    Circle()
//                        .foregroundColor(Color("AppDark"))
//                        .frame(width: 30.0,height: 30.0)
//                        .overlay {
//                            Image(systemName: "plus")
//                                .foregroundColor(Color(.systemBackground))
//                        }
//                }
//            }
//        }.padding()
//    }
//}
