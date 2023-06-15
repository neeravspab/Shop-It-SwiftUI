//
//  BestbuyListView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import SwiftUI
import Kingfisher

struct BestbuyListView: View {
    
    let image:KFImage
    let title:String
    let price:String
    let size:CGFloat
    
    /// Popular and to pics Porduct design
    var body: some View {
        VStack(alignment: .leading) {
            
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .cornerRadius(20.0)
            
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 13))
            
            HStack (spacing: 15) {
                
                Image(systemName: "star.fill")
                    .foregroundColor(Color(.systemYellow))
                    .frame(width: 1, height: 1)
                    .padding(.leading,10)
                
                Spacer()
                Text("$"+price)
                    .font(.system(size: 13.0))
                    .fontWeight(.semibold)
            }
        }
        .foregroundColor(Color(.label))
        .frame(width: size)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}

