//
//  EditProfileView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI
import Combine


struct EditProfileView: View {
    var user: User
    @State var editedUser: User
    @State var cohortString: String

    var body: some View {
        NavigationStack {
            VStack {
                Image("ravi-img")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(50)
                
                List {
                    HStack {
                        Text("Name")
                        TextField("Ravi", text: $editedUser.name)
                    }
                    
                    HStack {
                        Text("Cohort")
                        TextField("7", text: $cohortString)
                    }
                    
                    HStack {
                        Text("Session")
                        TextField("1", text: $editedUser.session)
                    }
                    
                    HStack {
                        Text("Email")
                        TextField("RafiAhmad@mail.id", text: $editedUser.email)
                    }
                    
                    HStack {
                        Text("Phone")
                        TextField("+62 9870392812", text: $editedUser.phoneNumber)
                    }
                }
                .listStyle(.plain)
                
                NavigationLink{
                    ProfileView(user: editedUser).navigationBarBackButtonHidden().navigationBarTitleDisplayMode(.large)
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 329, height: 50)
                        .background(Color(red: 1, green: 0.675, blue: 0.36))
                        .cornerRadius(10)
                        .padding(.top, 11)
                }
                
//                NavigationLink(destination: ProfileView(user: editedUser).navigationBarBackButtonHidden()) {
//                    Text("Save")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(width: 329, height: 50)
//                        .background(Color(red: 1, green: 0.675, blue: 0.36))
//                        .cornerRadius(10)
//                        .padding(.top, 11)
//                }
            }
            .onAppear {
                self.editedUser = user
                self.cohortString = String(user.cohort)
            }
            .onReceive(Just(editedUser)) { _ in
                // Update the user object in the model with the changes made in the editedUser state variable
            }
            .onReceive(Just(cohortString)) { value in
                if let newCohort = Int(value) {
                    editedUser.cohort = newCohort
                }
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(user: User(id: 1,
                                   email: "johndoe@example.com",
                                   password: "password123",
                                   name: "John Doe",
                                   phoneNumber: "+1234567890",
                                   cohort: 1,
                                   session: "Morning",
                                   joinedSigId: [],
                                   bookedEventId: [],
                                   notificationId: []),
                        editedUser: User(id: 1,
                                         email: "johndoe@example.com",
                                         password: "password123",
                                         name: "John Doe",
                                         phoneNumber: "+1234567890",
                                         cohort: 1,
                                         session: "Morning",
                                         joinedSigId: [],
                                         bookedEventId: [],
                                         notificationId: []), cohortString: "7")
    }
}
