//
//  Router.swift
//  Shopit
//
//  Created by niravkumar patel on 4/19/23.
//

import Foundation


class Router: ObservableObject {
    
    public static let shared = Router()
    
    @Published var selectedTab = 0
}
