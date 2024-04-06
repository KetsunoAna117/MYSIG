//
//  InformationRowView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct InformationRowView: View {
    let informationType: String
    let informationData: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text("\(informationType)")
                .font(.body)
                .fontWeight(.bold)
            
            Spacer()
            
            Text("\(informationData)")
                .font(.footnote)
        }
        Divider()
    }
}

#Preview {
    InformationRowView(informationType: "Location", 
                       informationData: "Apple Developer Academy, Collab Room 2")
}
