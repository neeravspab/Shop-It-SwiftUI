//
//  SignUpView.swift
//  Shopit
//
//  Created by niravkumar patel on 3/11/23.
//

import SwiftUI

struct SignUpView: View {
    
    // Properties
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var confirmEmail = ""
    @State private var phoneNumber = ""
    @State private var country = ""
    @State private var state = ""
    @State private var city = ""
    @State private var address = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var isAlertShow = false
    @State private var isSignUp = false
    @State private var alertDetail: SignupAlertDetail?

    var signupViewModel = SignUpViewModel()
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            TextFildView(title: "First Name", hint: "Enter First Name", value: $firstName)
            TextFildView(title: "Last Name", hint: "Enter Last Name", value: $lastName)
            TextFildView(title: "Email", hint: "Enter Email", value: $email)
            TextFildView(title: "Confirm Email", hint: "Enter Confirm Email", value: $confirmEmail)
            TextFildView(title: "Phone Number", hint: "Enter Phone Number", value: $phoneNumber)
            
            Group {
                TextFildView(title: "Country", hint: "Enter Country", value: $country)
                TextFildView(title: "State", hint: "Enter State", value: $state)
                TextFildView(title: "City", hint: "Enter City", value: $city)
                TextFildView(title: "Address", hint: "Enter Address", value: $address)
                SecureTextFildView(title: "Password", hint: "Enter Password", value: $password)
                SecureTextFildView(title: "Confirm Password", hint: "Enter Confirm Password", value: $confirmPassword)
            }
            
            Button("Register") {
                print("Register Tappded.")
                print("\(firstName), \(lastName), \(email), \(confirmEmail), \(phoneNumber), \(country), \(state), \(city), \(address), \(password), \(confirmPassword)")
                
                /// Validation....
                if validateFields() {
                    signupViewModel.addUser(userdetail: UserLoginModel(fname: "\(firstName)", lname: "\(lastName)", email: "\(email)", phone: "\(phoneNumber)", country: "\(country)", state: "\(state)", city: " \(city)", address: "\(address)", password: "\(password)")) { result in
                        switch result {
                        case .dataloaded:
                            print("data saved.")
                            
                            alertDetail = SignupAlertDetail(message: "Sign Up Successfull", id: 16)
                                isAlertShow = true
                              //  /// Move Back to Login Screen...
                        case .datafail:
                            print("data not saved.")
                            alertDetail = SignupAlertDetail(message: "Something Went Wrong. Please try it again later", id: 15)
                            isAlertShow = true
                        }
                    }
                }
            }
           
            .font(.system(size: 25.0))
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width-20,height: 50)
            .background(Color(red: 32/255, green: 79/255, blue: 139/255))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top,10.0)
            .padding(.bottom, 5.0)
            .alert("Alert",
                   isPresented: $isAlertShow, presenting: alertDetail, actions: { detail in
                Button("OK", action: {
                    if alertDetail?.id == 16 {
                        isSignUp = true
                    }
                })
            }, message: { detail in
                Text("\(detail.message)")
            })
            
            .fullScreenCover(isPresented: $isSignUp) { LoginView() }
        }
        .padding()
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Sign Up")
    }
    
    func validateFields()->Bool{
        
        if firstName == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your FirstName", id: 1)
            isAlertShow = true
            return false
        }
        
        else if lastName == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your LastName", id: 2)
            isAlertShow = true
            return false
        }
        
        else if email == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Email", id: 3)
            isAlertShow = true
            return false
        }
        
        else if !isValidEmail(email) {
            alertDetail = SignupAlertDetail(message: "Your email is not in correct formate", id: 4)
            isAlertShow = true
            return false
        }
        
        else if confirmEmail == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter Confirm Email", id: 5)
            isAlertShow = true
            return false
        }
        
        else if email != confirmEmail {
            alertDetail = SignupAlertDetail(message: "Email not matached. Please reenter it.", id: 6)
            isAlertShow = true
            return false
        }
        
        else if phoneNumber == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Phone Number", id: 7)
            isAlertShow = true
            return false
        }
        
        else if country == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Country Name", id: 8)
            isAlertShow = true
            return false
        }
        
        else if state == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your State Name", id: 9)
            isAlertShow = true
            return false
        }
        
        else if city == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your City Name", id: 10)
            isAlertShow = true
            return false
        }
        
        else if address == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Address", id: 11)
            isAlertShow = true
            return false
        }
        
        else if password == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Password", id: 12)
            isAlertShow = true
            return false
        }
        
        else if confirmPassword == "" {
            alertDetail = SignupAlertDetail(message: "Please Enter your Confirm Password", id: 13)
            isAlertShow = true
            return false
        }

        else if password != confirmPassword {
            alertDetail = SignupAlertDetail(message: "Password not matched. Please reenter it.", id: 14)
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
}

struct TextFildView: View {
    let title: String
    let hint: String
    let value: Binding<String>
    
    var body: some View {
        VStack (alignment: .leading,spacing: 5.0) {
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            TextField(hint, text: value)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.bottom, 8.0)
    }
}

struct SecureTextFildView: View {
    let title: String
    let hint: String
    let value: Binding<String>
    
    var body: some View {
        VStack (alignment: .leading,spacing: 5.0) {
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
            
            SecureField(hint, text: value)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding(.bottom, 8.0)
    }
}

struct SignupAlertDetail {
    
    let message: String
    let id: Int
}
