//
//  SearchView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    
    private var arrCategoryList = ["Stationery","Laptop","Phones","Clothes","Shoes","Furniture","Sports"]
    
    @State private var selectedIndexforCategory = 0
    @ObservedObject private var searchViewModel = SearchViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack (alignment: .leading) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<arrCategoryList.count, id: \.self ) { i in
                            Categories(name: arrCategoryList[i], isactive: (i == selectedIndexforCategory))
                                .onTapGesture {
                                    selectedIndexforCategory = i
                                  //  searchText = arrCategoryList[i]
                                    // Move to Search Screen
                                    searchViewModel.arrCategoryProducts.removeAll()
                                    searchViewModel.fetchDataCategoryWise(category: arrCategoryList[i])

                                }
                        }
                    }.padding(.leading,10)
                }

                Spacer()
                
                ScrollView(.vertical,showsIndicators: false) {
                    VStack {
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)) {
                            
                            ForEach(searchViewModel.filterproducts) { iteam in
                                
                              //  let data = searchViewModel.filterproducts[iteam]
//                                SearchProductView(image: KFImage(URL(string: "\(iteam.image)")),
//                                                title: iteam.title,
//                                                price: iteam.price,
//                                                size: 140)
                                
                                NavigationLink(destination: ProductDetailView(productmodel: iteam)) {
                                    SearchProductView(image: KFImage(URL(string: "\(iteam.image)")),
                                                    title: iteam.title,
                                                    price: iteam.price,
                                                    size: 140)
                                }
                               // .navigationBarHidden(true)                                
                            }
                            .padding(.bottom,5)
                        }
                    }
                    .shadow(color: Color(.systemGray4), radius: 5.0,x: 0,y: 0)
                }.padding(.horizontal)
                
            } //End VStack...
            .navigationTitle("Search")
        } // End navigationView...
        .searchable(text: $searchViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchViewModel.searchText, perform: { newValue in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if newValue == searchViewModel.searchText && searchViewModel.searchText != "" {
                    searchViewModel.filterdata()
                }
            }
            if searchViewModel.searchText == "" {
                // reset all data..
                
                withAnimation(.linear) {searchViewModel.filterproducts = searchViewModel.arrCategoryProducts}
            }
        })
        .onAppear {
            selectedIndexforCategory = 0
//            searchViewModel.arrCategoryProducts.removeAll()
            searchViewModel.fetchDataCategoryWise(category: arrCategoryList[selectedIndexforCategory])
        }
    }
}
