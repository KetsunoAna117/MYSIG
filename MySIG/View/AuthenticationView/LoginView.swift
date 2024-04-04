//
//  LoginView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    
    @State var email = ""
    @State var password = ""
    @State var isLoggedIn = false
    @State var alertIsPresented = false
    
    var body: some View {
        VStack {
            Image("SIG-icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 400, height:195)
            
            VStack {
                HStack {
                    Text("Email")
                    
                    Spacer()
                }
                
                TextField("jdoe24 @bsd.idserve.net", text: $email)
                Divider()
                    .background(.black)
                
                Spacer()
                
                HStack {
                    Text("Password")
                    
                    Spacer()
                }
                Spacer()
                
                PasswordField.init(placeholder: "", text: $password)
                Divider()
                    .background(Color.black)
                
                HStack{
                    Spacer()
                    Text("Recover Password")
                        .font(.caption)
                        .foregroundColor(Color(red:0.54, green:0.33, blue:0.44))
                }
                
                Button(action: {
                    if let user: User = Utils().validateUser(email: String(email), password: String(password), appStoreData: appDataStore){
                        appDataStore.currentActiveUser = user
                        isLoggedIn = true
                    } else {
                        alertIsPresented = true
                    }
                }, label: {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 329, height: 50)
                        .background(Color(red: 1, green: 0.675, blue: 0.36))
                        .cornerRadius(10)
                        .padding(.top, 111)
                })
            }
            .padding(EdgeInsets(top: 100, leading: 45, bottom: 0, trailing: 45))
            .frame(height: 400)
            
            if(isLoggedIn == true){
                if let user = appDataStore.currentActiveUser {
                    Text("User \(user.name) successfully logged in")
                }
            }
            
            Spacer()
        }
        .alert(Text("Error!"), isPresented: $alertIsPresented) {
            Button("OK", role: .cancel) {
                alertIsPresented = false
            }
        } message: {
            Text("Invalid user credenials, Please try again!")
        }
        .navigationDestination(isPresented: $isLoggedIn) {
            ContentView()
        }
        
    }
}

#Preview {
    LoginView()
        .environmentObject(AppDataStore())
}
