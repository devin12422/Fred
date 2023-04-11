//
//  PostDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI


struct PostDetailView: View {
    var comments: [Comment]
    let post:PostWrapper
    var body: some View {
        VStack{
            Text(post.post.title)
            NavigationLink{
                UserDetailView(user: post.author)
            }label:{
                UserView(user:post.author)
            }
            NavigationLink(destination: CommentSectionView(commentsection: comments))
                {
                Text("Comments")
                }
            ScrollView(.horizontal){
                HStack{
                    ForEach(post.post.tags){tag in
                        Text(String(describing:tag))
                    }
                }
            }
            Text(post.post.description)
            
            List(post.post.instructions){instruction in
                Text(instruction.string)
        Spacer()
        
                }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(comments:[], post: PostWrapper(post: Post(), author: User()))
    }
}
