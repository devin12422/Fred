//
//  UserDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/22/23.
//

import SwiftUI

struct UserDetailView: View {
    var user:User
    var body: some View {
        VStack{
            UserView(user: user)
            Text("Details")
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user:User())
    }
}
