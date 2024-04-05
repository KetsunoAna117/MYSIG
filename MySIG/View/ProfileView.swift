//
//  ProfileView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appDataStore: AppDataStore
    var user: User
//    @State private var isEditingProfile = false // Added state variable to track editing status
        
    
    var body: some View {
        NavigationStack {
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
                        Text(user.name)
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Text("ADA Cohort \(user.cohort) - Session \(user.session)")
                            .font(.footnote)
                            .foregroundColor(Color(red: 1, green: 0.675, blue: 0.36))
                        
                        Spacer()
                        
                        HStack{
                            Image(systemName: "envelope")
                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        HStack{
                            Image(systemName: "phone")
                            Text(user.phoneNumber)
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
                        EditProfileView(user: user, editedUser: user, cohortString: "7")
                        
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
                
            }
            .navigationTitle("Member Information")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var user = User(id: 1,
                           email: "Johndoe@mail.id",
                           password: "abc",
                           name: "John Doe",
                           phoneNumber: "+6287831353012",
                           cohort: 7,
                           session: "Morning",
                           joinedSigId: [],
                           bookedEventId: [1, 2],
                           notificationId: [1])

    static var previews: some View {
        ProfileView(user: user)
            .environmentObject(AppDataStore())
    }
}

//#Preview {
//    ProfileView(user: user)
//        .environmentObject(AppDataStore())
//}
