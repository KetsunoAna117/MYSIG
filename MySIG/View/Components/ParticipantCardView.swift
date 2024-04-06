//
//  RegisteredParticipantsView.swift
//  MySIG
//
//  Created by Tania Cresentia on 06/04/24.
//

import SwiftUI

struct ParticipantCardView: View {
    var userData: User
    
    var body: some View {
        HStack{
            Image("\(userData.picture)")
                .resizable()
                .frame(width: 100, height: 70)
                .aspectRatio(contentMode: .fit)
                
            VStack(alignment: .leading, content: {
                Text("\(userData.name)")
                Text("\(userData.phoneNumber)")
                    .font(.caption)
            })
            Spacer()
            Text("Role")
                .padding(.trailing, 20)
        }
        .padding(1)
        .frame(width: 340, height: 70)
        .border(Color.gray, width: 0.5)
    }
}

#Preview {
    ParticipantCardView(userData: AppDataStore().users[0])
        .environmentObject(AppDataStore())
}
