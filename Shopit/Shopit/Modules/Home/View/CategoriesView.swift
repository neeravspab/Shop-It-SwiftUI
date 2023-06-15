//
//  CategoriesView.swift
//  Shopit
//
//  Created by niravkumar patel on 4/14/23.
//

import SwiftUI

struct Categories: View {
    
    let name:String
    let isactive:Bool
    
    /// Banner List Design
    var body: some View {
        
        ZStack {
            if isactive {
                Capsule(style: .circular)
                    .frame(width: 90.0,height: 35.0)
                    .foregroundColor(Color("AppDark"))
            }
            
            Text(" \(name) ")
                .fontWeight(.semibold)
                .font(.system(size: 17.0))
                .foregroundColor(isactive ? Color(.systemBackground) : Color("AppDark"))
                .frame(width: 90.0,height: 35.0)
        }
    }
}
