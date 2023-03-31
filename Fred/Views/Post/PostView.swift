//
//  PostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth

struct PostView: View {
    var post:PostWrapper
    var body: some View {
        VStack(alignment: .leading) {
            UserView(user:post.author)
                                
            Text(post.post.title).font(.title3).fontWeight(.bold)
            Text(post.post.description).font(.subheadline).foregroundColor(.gray).padding(.bottom, 8)
            HStack {
                                 Button {
                                 
                                 } label: {
                                     HStack {
                                         Image(systemName: "heart")
                                         Text("Like")
                                     }
                                 }
                                 Button {
                                 
                                 } label: {
                                     HStack {
                                         Image(systemName: "message")
                                         Text("Comment")
                                     }
                                 }
                             }.padding(.top, 8).foregroundColor(.gray)
                         
                         }.padding().background(Color.white).cornerRadius(10)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:PostWrapper(post:Post(),author:User()))

    }
}
