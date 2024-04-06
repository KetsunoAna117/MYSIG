//
//  ProfileView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appDataStore: AppDataStore
        
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                    .padding(.bottom, 16)
                if let currentActiveUser = appDataStore.currentActiveUser {
                    HStack{
                        Image("ravi-img")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .cornerRadius(50)
                        
                        
                        VStack(alignment: .leading, content: {
                            Text(currentActiveUser.name)
                                .font(.title2)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            Text("ADA Cohort \(currentActiveUser.cohort) - Session \(currentActiveUser.session)")
                                .font(.footnote)
                                .foregroundColor(Color(red: 1, green: 0.675, blue: 0.36))
                            
                            Spacer()
                            
                            HStack{
                                Image(systemName: "envelope")
                                Text(currentActiveUser.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            HStack{
                                Image(systemName: "phone")
                                Text(currentActiveUser.phoneNumber)
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
                        NavigationLink{
                            EditProfileView(editedUser: currentActiveUser, cohortString: String(currentActiveUser.cohort))
                            
                        } label: {
                            Text("Edit Profile")
                            
                        }
                        
                        NavigationLink{
                            JoinedSIGView()
                        } label: {
                            Text("View Subscribed SIG")
                        }
                        
                        NavigationLink{
                            PastEventView()
                        } label: {
                            Text("View Past Events")
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
                } else{
                    Text("No User Logged in")
                }
                
            }
            .navigationTitle("Member Information")
        }
        .navigationTitle("Member Information")
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppDataStore())
}
