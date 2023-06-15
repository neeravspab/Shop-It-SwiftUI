//
//  SearchProductView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import SwiftUI
import Kingfisher

struct SearchProductView: View {
    
    let image:KFImage
    let title:String
    let price:String
    let size:CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .cornerRadius(20.0)
            
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 12.0))
            
            Text("$"+price)
                .font(.system(size: 12.0))
                .fontWeight(.regular)
        }
        .foregroundColor(Color(.label))
        .frame(width: size)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}
