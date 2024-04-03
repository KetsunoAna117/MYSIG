//
//  LoginView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
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
                
                PasswordField.init(placeholder: "", text: "")
                Divider()
                    .background(Color.black)
                
                Button(action: {
                            // Add login logic here
                        }, label: {
                            Text("Log In")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 329, height: 50)
                                .background(Color(red: 1, green: 0.675, blue: 0.36))
                                .cornerRadius(10)
                                .padding(.top, 111)
                        }
                        )
            }
            .padding(EdgeInsets(top: 100, leading: 45, bottom: 0, trailing: 45))
            .frame(height: 400)
            
            Spacer()
        }
        
    }
}

#Preview {
    LoginView()
}
