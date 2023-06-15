//
//  ProductDetailView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/30/23.
//

import SwiftUI
import Kingfisher
struct ProductDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var productViewModel = ProductViewModel()
    @State private var qty = 1
    @State private var isproductAdded = false
    @State private var isAlertShow = false
    @State private var productaddSuccessful = false
    @State private var alertDetail: AlertDetail?
    
    var productmodel: ProductModel!
    
    var body: some View {
        
        ZStack {
            NavigationView {
                
                ScrollView {
                    
                    // Image(productmodel.image)
                    KFImage(URL(string: "\(productmodel.image)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 400)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(alignment: .leading) {
                        
                        Text(productmodel.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .font(.system(size: 30.0))
                            .padding(.trailing)
                            .padding(.leading)
                        
                        HStack {
                            
                            ForEach(0..<Int(productmodel.rating)!, id: \.self) {i in
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(.systemYellow))
                                    .frame(width: 1, height: 1)
                                    .padding(.leading,10)
                            }
                            
                            ForEach(0..<5-Int(productmodel.rating)!, id: \.self) {i in
                                Image(systemName: "star")
                                    .foregroundColor(Color(.systemYellow))
                                    .frame(width: 1, height: 1)
                                    .padding(.leading,10)
                            }
                            
                            Text("\(productmodel.rating)")
                                .padding(.leading)
                            
                        }.padding(.leading)
                        
                        VStack(alignment: .leading) {
                            Text("Price")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.bottom,3)
                            
                            Text("$\(productmodel.price)")
                        }.padding(.leading)
                        
                        
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                        
                        Text(productmodel.description)
                        
                            .padding(.leading)
                            .padding(.trailing)
                        
                        Spacer()
                    }
                    
                    .padding(.top,30)
                    .background(Color(.systemGray5))
                    .cornerRadius(40.0)
                    .offset(y: -50.0)
                    .shadow(color: Color(.label).opacity(0.2), radius: 10.0, y: -40.0)
                    
                    Totalprice(price: productmodel.price, action: {
                        
                        if !isproductAdded {
                            self.productViewModel.addToCart(cartdetail: productmodel) { result in
                                switch result {
                                case .dataloaded:
                                    print(" Product Added To Cart Succesfully...")
                                    alertDetail = AlertDetail(message: " Product Added To Cart Succesfully...", id: 1)
                                    isAlertShow = true
                                case .datafail:
                                    print("Faild To Add Into Cart")
                                    alertDetail = AlertDetail(message: "Faild To Add Into Cart", id: 2)
                                    
                                    isAlertShow = false
                                }
                            }
                        } else {
                            print("This Product is Already Added Into Cart.")
                            alertDetail = AlertDetail(message: "This Product is Already Added Into Cart.", id: 3)
                            isAlertShow = true
                        }
                    })
                    .alert("Shopit",
                           isPresented: $isAlertShow, presenting: alertDetail, actions: { detail in
                        Button("OK", action: {})
                    }, message: { detail in
                        Text("\(detail.message)")
                    })
                }
                .background(Color(.systemGray5))
                .edgesIgnoringSafeArea(.top)
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Backbutton(action: { presentationMode.wrappedValue.dismiss() } )
            )
        }
        .onAppear {
            productViewModel.isProductedAlreadyAddedToCart(productid: productmodel.documentid) { result in
                switch result {
                case .dataloaded:
                    self.isproductAdded = true
                case .datafail:
                    self.isproductAdded = false
                }
            }
        }
    }
}

//struct ProductDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductDetailView()
//    }
//}

struct Backbutton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .padding(.all,12)
                .foregroundColor(Color(.label))
                .background(Color(.systemBackground))
                .cornerRadius(8.0)
        }
    }
}

struct Totalprice: View {
    let price: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            // String(format: "Angle: %.2f", angle)
            
            Text("$\(price)")
                .font(.title)
                .foregroundColor(Color(.systemGray5))
            
            Spacer()
            
            Button(action: action) {
                
                Text("Add to Cart")
                    .foregroundColor(Color("AppDark"))
                    .fontWeight(.semibold)
                    .padding()
                
                    .background(Color(.systemBackground))
                    .cornerRadius(10.0)
            }
        }
        .padding()
        .padding(.horizontal)
        .background(Color("AppDark"))
    }
}

struct AlertDetail {
    
    let message: String
    let id: Int
}
