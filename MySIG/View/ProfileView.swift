//
//  ProfileView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                    .padding(.bottom, 16)
                
                HStack{
                    Image("ravi-img")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .cornerRadius(50)
                    
                    
                    VStack(alignment: .leading, content: {
                        Text("Ravi")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Text("ADA Cohort 7 - Session 1")
                            .font(.body)
                            .foregroundColor(Color(red: 1, green: 0.675, blue: 0.36))
                        
                        Spacer()
                        
                        HStack{
                            Image(systemName: "envelope")
                            Text("RafiAhmad.@apple. com")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Image(systemName: "phone")
                            Text("+628761291809")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    })
                    .padding(.leading, 20)
                    .frame(height: 100)
                }
                .padding(.leading, -18)
                .padding(.bottom, 10)
                
                
                List {
                    NavigationLink(destination: EditProfileView().navigationBarBackButtonHidden()) {
                        Section {
                            Text("Edit Profile")
                        }
                    }
                    NavigationLink(destination: JoinedSIGView().navigationBarBackButtonHidden()) {
                        Section {
                            Text("View Subscribed SIG")
                        }
                    }
                    NavigationLink(destination: PastEventView().navigationBarBackButtonHidden()) {
                        Section {
                            Text("View Past Events")
                        }
                    }
                }
                .listStyle(.plain)
                .background(Color.white)
                
                Spacer()
                
                NavigationLink(destination: LoginView().navigationBarBackButtonHidden()){
                    
                    Text("Log out")
                        .font(.headline)
                        .foregroundColor(Color(red: 1, green: 0.675, blue: 0.36))
                        .padding()
                        .frame(width: 329, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 1, green: 0.675, blue: 0.36), lineWidth: 2)
                        )
                        .cornerRadius(10)
                        .padding(.top, 111)
                    
                }
                
            }
            .navigationTitle("Member Information")
            
            
        }
    }
}



#Preview {
    ProfileView()
        .environmentObject(AppDataStore())
}
