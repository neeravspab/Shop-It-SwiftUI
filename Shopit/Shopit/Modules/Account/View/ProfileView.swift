//
//  ProfileView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/28/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var islogout = false
    @ObservedObject var accountViewModel = AccountViewModel()
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {

                Image("person")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .position(y: 80)
                    .frame(width: 160, height: 160)
                    .padding()
                    .shadow(color: Color(.label).opacity(0.3), radius: 10.0, x: 0.0, y: 0.0)
                
                        VStack (alignment: .leading) {
                            
                            Group {
                                ProfileDetail(title: "First Name", value: accountViewModel.userDetail["fname"] ?? "")
                                ProfileDetail(title: "Last Name", value: accountViewModel.userDetail["lname"] ?? "")
                                ProfileDetail(title: "Email", value: accountViewModel.userDetail["email"] ?? "")
                                ProfileDetail(title: "Phone Number", value: accountViewModel.userDetail["phone"] ?? "")
                                ProfileDetail(title: "Country", value: accountViewModel.userDetail["country"] ?? "")
                                ProfileDetail(title: "State", value: accountViewModel.userDetail["state"] ?? "")
                                ProfileDetail(title: "City", value: accountViewModel.userDetail["city"] ?? "")
                                ProfileDetail(title: "Address", value: accountViewModel.userDetail["address"] ?? "")
                                
//                                ProfileDetail(title: "First Name", value: UserDefaults.standard.object(forKey: "fname") as! String)
//                                ProfileDetail(title: "Last Name", value: UserDefaults.standard.object(forKey: "lname") as! String)
//                                ProfileDetail(title: "Email", value: UserDefaults.standard.object(forKey: "email") as! String)
//                                ProfileDetail(title: "Phone Number", value: UserDefaults.standard.object(forKey: "phone") as! String)
//                                ProfileDetail(title: "Country", value: UserDefaults.standard.object(forKey: "country") as! String)
//                                ProfileDetail(title: "State", value: UserDefaults.standard.object(forKey: "state") as! String)
//                                ProfileDetail(title: "City", value: UserDefaults.standard.object(forKey: "city") as! String)
//                                ProfileDetail(title: "Address", value: UserDefaults.standard.object(forKey: "address") as! String)
                            }
                            
                            .padding(.leading)
                            
                            Button {
                                UserDefaults.standard.set(false, forKey: "isLogin")
                                
                                UserDefaults.standard.synchronize()
                                resetDefaults()
                                self.islogout = true
                            } label: {
                                Text("Log Out")
                                    .font(.title)
                                    .padding()
                            }
                            .frame(width: UIScreen.main.bounds.width-20,height: 50)
                            .foregroundColor(Color(.systemBackground))
                            .background(Color("AppDark"))
                            .cornerRadius(20.0)
                            .padding()
                            .padding(.trailing)
                            .fullScreenCover(isPresented: $islogout) {
                                LoginView()
                            }
                        }
                        .padding(.leading)
                     
                        .background(Color(.systemGray5))
                        .frame(maxWidth: .infinity)
                        .cornerRadius(40.0)
           
            }
            .background(Color(.systemGray5))
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Profile")
        }
    }
    
    func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}

struct ProfileDetail: View {
    let title:String
    let value:String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
              .font(.headline)
            
            Text(value)
                .font(.subheadline)
                .font(.system(size: 15.0))
        }

        .padding(.bottom)
    }
}
