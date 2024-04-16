//
//  MatchedProfileView.swift
//  MySIG
//
//  Created by Tania Cresentia on 15/04/24.
//

import SwiftUI

struct MatchedProfileView: View {
    @EnvironmentObject var appDataStore: AppDataStore
    @Namespace var namespace
    @State var isProfileExpanded = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                    .padding(.bottom, 16)
                
                if !isProfileExpanded {
                    collapsedProfileView
                } else {
                    expandedProfileView
                }
                if let currentActiveUser = appDataStore.currentActiveUser{
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
                } else{
                    Text("No User Logged in")
                }
                
            }
            .navigationTitle("Member Information")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var collapsedProfileView: some View {
        HStack {
            profileImage
                .matchedGeometryEffect(id: "picture", in: namespace)
                .frame(width: 60, height: 60)

            VStack(alignment: .leading) {
                Text(appDataStore.currentActiveUser!.name)
                    .matchedGeometryEffect(id: "name", in: namespace)
                    .font(.title).bold()

                Text("ADA Cohort 7 - Session Morning")
                    .matchedGeometryEffect(id: "cohort", in: namespace)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding()
    }

    var expandedProfileView: some View {
        VStack {
            profileImage
                .matchedGeometryEffect(id: "picture", in: namespace)
                .frame(width: 130, height: 130)

            VStack {
                Text("John Doe")
                    .matchedGeometryEffect(id: "name", in: namespace)
                    .font(.title).bold()
                
                Text("ADA Cohort 7 - Session Morning")
                    .matchedGeometryEffect(id: "cohort", in: namespace)
                    .foregroundColor(Color(red: 1, green: 0.675, blue: 0.36))
                
                HStack{
                    Image(systemName: "envelope")
                    Text("jdoe@bsd.idserve.net")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                HStack{
                    Image(systemName: "phone")
                    Text("+62 891 2912 0821")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
            }
        }
        .padding()
    }

    var profileImage: some View {
        Image("john-doe")
            .resizable()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fill)
            .onTapGesture {
                withAnimation{
                    isProfileExpanded.toggle()
                }
            }
    }

}

#Preview {
    MatchedProfileView()
        .environmentObject(AppDataStore())
}
