//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI

struct PostDetailView: View {
    let post:CodableWrapper<Post>
    var body: some View {
        VStack{
            Text(post.wrapped.title)
            NavigationLink{
                UserDetailView(user: post.author)
            }label:{
                UserView(user:post.author)
            }
            HStack{
                Image(systemName: "star.fill")
                Image(systemName: post.wrapped.rating >= 2 ? "star.fill" : "star")
                Image(systemName: post.wrapped.rating >= 3 ? "star.fill" : "star")
                Image(systemName: post.wrapped.rating >= 4 ? "star.fill" : "star")
                Image(systemName: post.wrapped.rating >= 5 ? "star.fill" : "star")
            }
            
            ScrollView(.horizontal){
                HStack{ForEach(post.wrapped.tags.shuffled(),id:\.self.tag){tag in
                    Text(tag.tag)
                }
                }}
            Text(post.wrapped.description)
            
            List(post.wrapped.instructions){instruction in
                Text(instruction.string)
                Spacer()
                
            }
            NavigationLink(destination: CommentSectionView(post: post)){
                Text("Comments")
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: CodableWrapper<Post>(wrapped: Post(), author: User()))
    }
}
