//
//  SIGDetails.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct SIGDetails: View {
    @EnvironmentObject private var appDataStore: AppDataStore
    var selectedSIG: SIG
    
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("\(selectedSIG.name.capitalized)")
                        .font(.title)
                    .fontWeight(.bold)
                    Text("\(selectedSIG.desc)")
                        .font(.subheadline)
                    
                    HStack {
                        
                    }
                }
            }
            .padding(.horizontal, 16)

        
            Divider()
                .frame(height: 1)
            Button(action: {
                // Join SIG
            }, label: {
                Text("Subscribe notification")
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
            })
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)
        }
        .navigationTitle("SIG Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        SIGDetails(selectedSIG: AppDataStore().sigs[0])
            .environmentObject(AppDataStore())
    }
}
