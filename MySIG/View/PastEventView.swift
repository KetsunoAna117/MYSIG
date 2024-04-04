//
//  PastEventView.swift
//  MySIG
//
//  Created by Tania Cresentia on 03/04/24.
//

import SwiftUI

struct PastEventView: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Text("Past Events")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack{
                    NavigationLink(destination: ProfileView().navigationBarBackButtonHidden()){
                        Image(systemName: "chevron.left")
                        
                        Text("Back")
                    }
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .foregroundColor(.orange)
                
                
            }
            Divider()
            Text("Test")
            Spacer()
        }
    }
}

#Preview {
    PastEventView()
}
