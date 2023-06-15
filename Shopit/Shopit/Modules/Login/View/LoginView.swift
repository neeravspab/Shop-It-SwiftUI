//
//  LoginView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/11/23.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = false
    @State private var isAlertShow = false
    @State private var alertDetail: LoginAlertDetail?
    
    var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        if UserDefaults.standard.bool(forKey: "isLogin") == true {
            TabBarView()
        } else {
            
            NavigationView {
                VStack(spacing: 10) {
                    Image("applogo")
                        .resizable()
                        .frame(width: 300.0, height: 300.0)
                        .edgesIgnoringSafeArea(.top)
                        .padding(.top, 100.0)
                    
                    Spacer()
                    
                    TextField("Enter Email", text: $email)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    SecureField("Enter Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    
                    VStack {
                        
                        Button("Login") {
                            
                            if validateFields() {
                                login()
                            }
                        }
                        .font(.system(size: 25.0))
                        .foregroundColor(.white)
                        .frame(width: 300,height: 50)
                        .background(Color(red: 32/255, green: 79/255, blue: 139/255))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 5.0)
                        .fullScreenCover(isPresented: $isLogin) { TabBarView() }
                        .alert("Alert",
                               isPresented: $isAlertShow, presenting: alertDetail, actions: { detail in
                            Button("OK", action: {})
                        }, message: { detail in
                            Text("\(detail.message)")
                        })

                        Button {
                            print("Sign in With Apple")
                        } label: {
                            Text("Sign in With Apple")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: .systemBackground))
                                .padding(.trailing)
                        }
                        
                        .frame(width: 300,height: 50)
                        .background(Color(uiColor: .label))
                        .cornerRadius(10)
                        .padding(.bottom, 5.0)
                        
                        Button {
                            print("Sign in with Google")
                        } label: {
                            Image("btn_google_light_normal_ios")
                                .padding(.leading, 10)
                            
                            Text("Sign in with Google")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: .systemGray))
                                .padding(.trailing)
                        }
                        .frame(width: 300,height: 50)
                        .background(Color(uiColor: .white))
                        .buttonBorderShape(.capsule)
                        .cornerRadius(10)
                    }
                    
                    HStack {
                        Text("New around here?")
                            .font(.system(size: 15.0))
                        
                        NavigationLink(destination: SignUpView(), label: {
                            Text("Click here")
                        }).navigationTitle("")
                            .foregroundColor(Color(red: 32/255, green: 79/255, blue: 139/255))
                    }
                }
                .padding()
                .background(Color(uiColor: .systemGray5))
                
            }
            .onAppear(perform: {
                print("\(UserDefaults.standard.bool(forKey: "isLogin"))")
            })
        }
    }
    
    private func login() {
      //  print("Email \(email) Password: \(password)")
        if email != "" && password != "" {
            loginViewModel.CheckuserLogin(email: email, password: password, complition: { result in
                
                switch result {
                case .dataloaded:
                    print("data Loaded")
                    self.isLogin = true
                    
                case .datafail:
                    print("Data failed")
                    alertDetail = LoginAlertDetail(message: "Your cradential are incorract. Please try it again.", id: 4)
                    isAlertShow = true

                    self.isLogin = false
                }
            })
            //print(self.isLogin)
        } else {
            self.isLogin = false
            UserDefaults.standard.set(false, forKey: "isLogin")
            print("Email and Password fild is empty.")
        }
    }
    
    func validateFields()->Bool{
        
        if email == "" {
            alertDetail = LoginAlertDetail(message: "Please Enter your Email", id: 1)
            isAlertShow = true
            return false
        }
        
        else if !isValidEmail(email) {
            alertDetail = LoginAlertDetail(message: "Your email is not in correct formate", id: 2)
            isAlertShow = true
            return false
        }
        
        
        else if password == "" {
            alertDetail = LoginAlertDetail(message: "Please Enter your Password", id: 3)
            isAlertShow = true
            return false
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginAlertDetail {
    
    let message: String
    let id: Int
}
