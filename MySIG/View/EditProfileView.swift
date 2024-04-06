//
//  EditProfileView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI
import Combine


struct EditProfileView: View {
    @EnvironmentObject var appDataStore: AppDataStore
    @State var editedUser: User
    @State var cohortString: String
    @State var showAlert = false
    @State var navigationLinkIsActive = false
    
    var body: some View {
        NavigationStack {
            if let currentActiveUser = appDataStore.currentActiveUser {
                VStack{
                    Image("ravi-img")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                    
                    List {
                        HStack {
                            Text("Name      ")
                            TextField("Name", text: $editedUser.name)
                        }
                        
                        HStack {
                            Text("Cohort     ")
                            TextField("Cohort", text: $cohortString)
                        }
                        
                        HStack {
                            Text("Session    ")
                            TextField("Session", text: $editedUser.session)
                        }
                        
                        HStack {
                            Text("Email        ")
                            TextField("email", text: $editedUser.email)
                        }
                        
                        HStack {
                            Text("Phone      ")
                            TextField("phone", text: $editedUser.phoneNumber)
                        }
                    }
                    .listStyle(.plain)
                    
                    Button(action: {
                        //                        appDataStore.currentActiveUser = editedUser
                        if let cohort = Int(cohortString) {
                            editedUser.cohort = cohort
                        }
                        appDataStore.currentActiveUser = editedUser
                        showAlert = true
                        navigationLinkIsActive = true
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 329, height: 50)
                            .background(Color(red: 1, green: 0.675, blue: 0.36))
                            .cornerRadius(10)
                            .padding(.top, 11)
                    })
                    
//                    NavigationLink(
//                        destination: ProfileView().navigationBarBackButtonHidden().navigationBarTitleDisplayMode(.large),
//                        isActive: $navigationLinkIsActive,
//                        label: {
//                            EmptyView()
//                        }
//                    )
//                    .hidden()
                    
//                    NavigationLink{
//                        ProfileView().navigationBarBackButtonHidden().navigationBarTitleDisplayMode(.large)
//                    } label: {
//                        Text("Save")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(width: 329, height: 50)
//                            .background(Color(red: 1, green: 0.675, blue: 0.36))
//                            .cornerRadius(10)
//                            .padding(.top, 11)
//                    }
                }
                .onAppear {
                    editedUser = currentActiveUser
                    cohortString = String(currentActiveUser.cohort)
                }
                .navigationTitle("Edit Profile")
                .navigationBarTitleDisplayMode(.inline)
                
                
            } else {
                Text("No Logged In User")
                    .navigationTitle("Edit Profile")
                    .navigationBarTitleDisplayMode(.inline)
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("Profile updated successfully"), dismissButton: .default(Text("OK")))
        }
        //        .navigationDestination(isPresented: $navigationLinkIsActive) {
        //            ProfileView().navigationBarBackButtonHidden()
        //        }
    }
}

#Preview {
    EditProfileView(editedUser : User(id: 9, email: "", password: "", name: "", phoneNumber: "", cohort: 7, session: "", joinedSigId: [0], bookedEventId: [0], notificationId: [0]), cohortString: "")
        .environmentObject(AppDataStore())
}
