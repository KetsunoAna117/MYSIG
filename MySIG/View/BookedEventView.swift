//
//  BookedEventView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import SwiftUI

struct BookedEventView: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    @State private var showNotification = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, content: {
                HStack {
                    Spacer()
                    Button(action: {
                        showNotification.toggle()
                    }, label: {
                        if(appDataStore.currentActiveUser?.notificationId.isEmpty == true){
                            Image(systemName: "bell")
                        }
                        else{
                            Image(systemName: "bell.badge")
                        }
                    })
                }
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Divider()
                    .padding(.top, -10)
                
                VStack(alignment: .leading, content: {
                    if let currentActiveUser = appDataStore.currentActiveUser {
                        ForEach(currentActiveUser.bookedEventId, id: \.self) { event in
                            Text("event: \(event)")
                        }
                    }
                })
            })
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BookedEventView()
        .environmentObject(AppDataStore())
}
