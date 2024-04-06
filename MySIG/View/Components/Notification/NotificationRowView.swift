//
//  NotificationRowView.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 06/04/24.
//

import SwiftUI

struct NotificationRowView: View {
    let currentNotification: SIGNotification
    
    var dateNotification: String {
        let utils = Utils()
        let defaultDate = Date.now
        
        let dayName = utils.getDayName(from: currentNotification.date ?? defaultDate)
        let day = utils.getDay(from: currentNotification.date ?? defaultDate)
        let month = utils.getMonth(from: currentNotification.date ?? defaultDate)
        let year = utils.getYear(from: currentNotification.date ?? defaultDate)
        
        return "\(dayName), \(day) \(month) \(year) "
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .center) {
                Text("\(currentNotification.title)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(maxWidth: 600, alignment: .leading)
                Spacer()
                Text("\(dateNotification)")
                    .font(.caption)
                    .opacity(0.5)
                    .frame(maxWidth: 100, alignment: .trailing)
            }
            .padding(.bottom, 1)
            Text("\(currentNotification.content)")
                .font(.caption)
        }
    }
}

#Preview {
    NotificationRowView(currentNotification: AppDataStore().notifications[0])
}
