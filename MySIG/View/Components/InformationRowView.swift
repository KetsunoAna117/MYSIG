//
//  InformationRowView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct InformationRowView: View {
    let informationIcon: String?
    let informationType: String
    let informationData: String
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                if let icon = informationIcon {
                    Image(systemName: icon)
                        .resizable()
                        .clipped()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                Text("\(informationType)")
                    .font(.body)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Text("\(informationData)")
                .font(.footnote)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 200, alignment: .trailing)
        }
        .listRowInsets(EdgeInsets())
    }
}

#Preview {
    InformationRowView(
        informationIcon: "mappin",
        informationType: "Location",
        informationData: "Apple Developer Academy, Collab Room 2")
}
