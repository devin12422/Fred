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
    var post:CodableWrapper<Post>
    var body: some View {
        VStack{
            NavigationLink{
                PostDetailView( post: post)
            }label: {
                VStack(alignment: .leading) {
                    UserView(user:post.author)
                    
                    Text(post.wrapped.title).font(.title3).fontWeight(.bold)
                    Text(post.wrapped.description).font(.subheadline).foregroundColor(.gray).padding(.bottom, 8)
                    
                }.padding().background(Color.white).cornerRadius(10)
            }
            
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:CodableWrapper<Post>(wrapped:Post(),author:User()))
    }
}
