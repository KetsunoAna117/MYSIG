////
////  halamanCobaCobaCode.swift
////  MySIG
////
////  Created by Tania Cresentia on 04/04/24.
////
//
//import SwiftUI
//
//struct halamanCobaCobaCode: View {
//    @EnvironmentObject var appDataStore: AppDataStore
//    @State var editedUser: User
//    @State var cohortString: String
//    @State private var dataSaved = false
//    @State private var showSuccessMessage = false
//    
//    var body: some View {
//        NavigationStack {
//            if let currentActiveUser = appDataStore.currentActiveUser {
//                VStack{
//                    Image("ravi-img")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 100, height: 100)
//                        .cornerRadius(50)
//                    
//                    List {
//                        HStack {
//                            Text("Name")
//                            TextField("Ravi", text: $editedUser.name)
//                        }
//                        
//                        HStack {
//                            Text("Cohort")
//                            TextField("7", text: $cohortString)
//                        }
//                        
//                        HStack {
//                            Text("Session")
//                            TextField("1", text: $editedUser.session)
//                        }
//                        
//                        HStack {
//                            Text("Email")
//                            TextField("RafiAhmad@mail.id", text: $editedUser.email)
//                        }
//                        
//                        HStack {
//                            Text("Phone")
//                            TextField("+62 9870392812", text: $editedUser.phoneNumber)
//                        }
//                    }
//                    .listStyle(.plain)
//                    
//                    if dataSaved {
//                        Button {
//                            // Save the data here
//                            // ...
//                            // Set the dataSaved variable to false
//                            dataSaved = false
//                            // Publish a notification to trigger the onReceive modifier
//                            NotificationCenter.default.post(name: Notification.Name("UserUpdated"), object: nil)
//                        } label: {
//                            Text("Save")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(width: 329, height: 50)
//                                .background(Color(red: 1, green: 0.675, blue: 0.36))
//                                .cornerRadius(10)
//                                .padding(.top, 11)
//                        }
//                    } else {
//                        Button {
//                            // Save the data here
//                            // ...
//                            // Set the dataSaved variable to true
//                            dataSaved = true
//                        } label: {
//                            Text("Save")
//                                .font(.headline)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(width: 329, height: 50)
//                                .background(Color(red: 1, green: 0.675, blue: 0.36))
//                                .cornerRadius(10)
//                                .padding(.top, 11)
//                        }
//                    }
//                    
//                        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UserUpdated"))) { _ in
//                            // Update the user object in the model with the changes made in the editedUser state variable
//                            appDataStore.currentActiveUser = editedUser
//                            // Show the success message
//                            showSuccessMessage = true
//                        }
//                }
//                .onAppear {
//                    editedUser = currentActiveUser
//                    cohortString = String(currentActiveUser.cohort)
//                }
//            } else {
//                Text("No Logged In User")
//                    .navigationTitle("Edit Profile")
//                    .navigationBarTitleDisplayMode(.inline)
//            }
//        }.alert(isPresented: $showSuccessMessage) {
//            Alert(title: Text("Success"), message: Text("Your profile has been successfully saved."), dismissButton: .default(Text("OK")))
//        }
//    }
//    
//}
//
//#Preview {
//    halamanCobaCobaCode(editedUser : User(id: 9, email: "", password: "", name: "", phoneNumber: "", cohort: 7, session: "", joinedSigId: [0], bookedEventId: [0], notificationId: [0]), cohortString: "")
//        .environmentObject(AppDataStore())
//}
