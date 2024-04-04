//
//  EditProfileView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct EditProfileView: View {
    @State var name = ""
    @State var cohort = ""
    @State var session = ""
    @State var email = ""
    @State var phone = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                                ZStack {
                                    Text("Edit Profile")
                                        .font(.subheadline)
                                    .fontWeight(.semibold)
                
                                    HStack{
                                        NavigationLink(destination: ProfileView().navigationBarBackButtonHidden()){
                                            Image(systemName: "chevron.left")
                
                                            Text("Back")
                                        }
                
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
                                    .foregroundColor(.orange)
                
                
                                }
                                Divider()
                
                Image("ravi-img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    .cornerRadius(50)
                
                List{
                    HStack{
                        Text("Name")
                        TextField("Ravi", text: $name)
                        
                    }
                    
                    HStack{
                        Text("Cohort")
                        TextField("7", text: $cohort)
                    }
                    HStack{
                        Text("Session")
                        TextField("1", text: $session)
                    }
                    HStack{
                        Text("Email")
                        TextField("RafiAhmad@mail. id", text: $email)
                    }
                    HStack{
                        Text("Phone")
                        TextField("+62 9870392812", text: $phone)
                    }
                    
                }
                .listStyle(.plain)
                
                NavigationLink(destination: ProfileView().navigationBarBackButtonHidden()) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 329, height: 50)
                        .background(Color(red: 1, green: 0.675, blue: 0.36))
                        .cornerRadius(10)
                        .padding(.top, 111)
                }
            }
            
            
            
        }
//        .padding(.top, 20)
//        .navigationTitle("Edit Profile")
//        .navigationBarTitleDisplayMode(.inline)
//        .overlay {
//            VStack{
//                HStack{
//                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden()){
//                        Image(systemName: "chevron.left")
//                        
//                        Text("Back")
//                    }
//                    
//                    Spacer()
//                }
//                .padding(.leading, 10)
//                .foregroundColor(.orange)
//                Divider()
//                Spacer()
//            }
//            .padding(.top, -30)
//        }
    }
}

#Preview {
    EditProfileView()
}
