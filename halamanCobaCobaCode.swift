//
//  halamanCobaCobaCode.swift
//  MySIG
//
//  Created by Tania Cresentia on 04/04/24.
//

import SwiftUI

struct halamanCobaCobaCode: View {
    @State private var showDetail = false

    var body: some View {
        NavigationView {
            VStack {
                Button("Show Detail") {
                    showDetail = true
                }
               .padding()
               .foregroundColor(.white)
               .background(Color.blue)
               .cornerRadius(10)

                Spacer()
            }
            .navigationBarTitle(Text("Items"), displayMode: .inline)
           .navigationBarBackButtonHidden(false)
           .sheet(isPresented: $showDetail) {
                DetailView()
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail view")
           .navigationTitle("Detail")
    }
}
#Preview {
    halamanCobaCobaCode()
}
