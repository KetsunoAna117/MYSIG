//
//  CustomTextField.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 11/04/24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var saveTo: String
    let title: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .frame(width: 100, alignment: .leading)

            Spacer()

            TextField(title, text: $saveTo, axis: .vertical)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.secondary)
                .autocorrectionDisabled(true)
        }
        
    }
}

#Preview {
    CustomTextField(saveTo: .constant(""), title: "Event Description")
}
