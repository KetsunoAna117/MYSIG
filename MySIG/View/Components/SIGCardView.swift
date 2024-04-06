//
//  SIGCardView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 05/04/24.
//

import SwiftUI

struct SIGCardView: View {
    @EnvironmentObject private var appStoreData: AppDataStore
    var sigData: SIG
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 90)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 1)
            
            HStack {
                Image("\(sigData.name)")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .aspectRatio(contentMode: .fill)
                VStack (alignment: .leading) {
                    Text("\(sigData.name)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: "person")
                        if let user = Utils().getUserFromSIG(sigData: sigData, appStoreData: appStoreData) {
                            Text("\(user.name)")
                                .font(.footnote)
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
                .padding(.leading, 10)
                
                Spacer()
                
                let eventTotal = Utils().calculateOnGoingSigEvent(sig: sigData)
                
                if(eventTotal > 0){
                    ZStack(alignment: .center) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 50, height: 30)
                            .background(Constants.Red)
                            .cornerRadius(10)
                        
                        HStack {
                            Text("\(eventTotal)")
                                .foregroundStyle(Color.white)
                                .font(.footnote)
                            Image(systemName: "calendar.badge.exclamationmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(Color.white)
                        }
                        .padding()
                    }
                }
                
            }
        }
    }
}

#Preview {
    SIGCardView(sigData: AppDataStore().sigs[0])
        .environmentObject(AppDataStore())
}
