//
//  UserView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/22/23.
//

import SwiftUI

struct UserView: View {
    var user:User
    @EnvironmentObject var view_stack:ViewStack
    var body: some View {
        Button{
            view_stack.stack.append(ViewLayer(layer:[ViewState(name:"Reviews",image:UIImage(systemName: "star.fill")!,view:PostCreateView()),ViewState(name:"About",image:UIImage(data:user.image)!,view:UserDetailView(user: user)),ViewState(name:"Posts",image:UIImage(systemName: "tray.full")!,view:PostCreateView())]))
        }label:{HStack {
            Image(uiImage:UIImage(data:user.image)!).resizable().frame(width: 40, height: 40).clipShape(Circle())
            Text(user.username).font(.subheadline) .fontWeight(.bold)
            
        }.padding(.bottom, 8)}
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user:User())
    }
}
