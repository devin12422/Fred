//
//  UserView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/22/23.
//

import SwiftUI

struct UserView: View {
    var user:User
    var body: some View {
        HStack {
            Image(uiImage:UIImage(data:user.image)!).resizable().frame(width: 40, height: 40).clipShape(Circle())
            Text(user.username).font(.subheadline) .fontWeight(.bold)
                             
        }.padding(.bottom, 8)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:User())
    }
}
