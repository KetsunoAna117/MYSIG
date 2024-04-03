//
//  EditProfileView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        NavigationView{
            
            VStack{
//                Text("Edit Profile")
                Divider()
                
                Image("ravi-img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    .cornerRadius(50)
                
                List{
                    HStack{
                        Text("Name")
                        Text("Ravi")
                    }
                    
                    HStack{
                        Text("Cohort")
                        Text("Ravi")
                    }
                    HStack{
                        Text("Session")
                        Text("Ravi")
                    }
                    HStack{
                        Text("Email")
                        Text("Ravi")
                    }
                    HStack{
                        Text("Phone")
                        Text("Ravi")
                    }
                    
                }
                .listStyle(GroupedListStyle())
                
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
        .navigationTitle("Edit Profile")
    }
}

#Preview {
    EditProfileView()
}
