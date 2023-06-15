//
//  HomeView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/22/23.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @ObservedObject private var homeViewModel = HomeViewModel()
    @ObservedObject private var searchViewModel = SearchViewModel()

    @State private var selectedIndexforCategory = 0
    private var arrCategoryList = ["Stationery","Laptop","Phones","Clothes","Shoes","Furniture","Sports"]

    var body: some View {
        
        NavigationView {
            
            ZStack {
                Color(.systemGray5)
                    .edgesIgnoringSafeArea(.top)
                
                ScrollView(showsIndicators: false) {
                    VStack (alignment: .leading) {
                        
                        TabView {
                            
                            ForEach(0..<homeViewModel.arrimageList.count, id: \.self) { iteam in
                                
                                // AsyncImage(url: URL(string: "\(homeViewModel.arrimageList[iteam])"))
                                //  Image("\(homeViewModel.arrimageList[iteam])")
                                KFImage(URL(string: "\(homeViewModel.arrimageList[iteam])"))
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(12)
                                //.aspectRatio(contentMode: .fill)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 15)
                            }
                        }
                        
                        .frame(width: UIScreen.main.bounds.width,height: 250)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        
                        // Popular Product List
                        Text("Popular")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .padding(.leading,15)
                        
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                
                                ForEach(homeViewModel.arrProductList) { data in
                                    
                                    NavigationLink(destination: ProductDetailView(productmodel: data)) {
                                        ProductListView(image: KFImage(URL(string: "\(data.image)")),
                                                        title: data.title,
                                                        rating: data.rating,
                                                        price: data.price,
                                                        size: 180)
                                    }
                                    .navigationBarHidden(true)
                                }.padding(.leading)
                            }
                            .shadow(color: Color(.systemGray4), radius: 5.0,x: 0,y: 0)
                        }
                        //.padding(.leading)
                        
                        // Top Picks

                        Text("Top Picks")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .padding(.leading,15)
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                ForEach(homeViewModel.arrProductList) { data in
                                    NavigationLink(destination: ProductDetailView(productmodel: data)) {
                                        ProductListView(image: KFImage(URL(string: "\(data.image)")),
                                                        title: data.title,
                                                        rating: data.rating,
                                                        price: data.price,
                                                        size: 160)
                                    }
                                    .navigationBarHidden(true)
                                }.padding(.leading)
                            }
                            .shadow(color: Color(.systemGray4), radius: 5.0,x: 0,y: 0)
                        }
                        
                        // Best Buy

                        Text("Best Buy")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .padding(.leading,15)
                        
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                //                                ForEach(0..<homeViewModel.arrProductList.count, id: \.self) { iteam in
                                ForEach(homeViewModel.arrProductList) { data in
                                    //                                    let data = homeViewModel.arrProductList[iteam]
                                    NavigationLink(destination: ProductDetailView(productmodel: data)) {
                                        BestbuyListView(image: KFImage(URL(string: "\(data.image)")),
                                                        title: data.title,
                                                        price: data.price,
                                                        size: 140)
                                    }
                                    .navigationBarHidden(true)
                                }.padding(.leading)
                            }
                            .shadow(color: Color(.systemGray4), radius: 5.0,x: 0,y: 0)
                        }
                        // .padding(.leading)
                        .padding(.bottom)
                        
                    }/// VStack Ends
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                }
            }/// ZStack Ends
        } /// NaviationView Ends
        .onAppear {
            homeViewModel.arrProductList.shuffle()
        }
    }
    
}
