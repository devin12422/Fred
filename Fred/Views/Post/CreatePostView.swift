//
//  CreatePostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
struct PostCreateView: View {
    @State var post:Post = Post(user: getCurrentUser())
    var body: some View {
        VStack{
            TextField("Name",text: $post.title)
            TextField("Description",text: $post.description)
            HStack{
                Button{
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    let encoder = JSONEncoder();
                    let encoded = try? encoder.encode(post);

                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)").putData(encoded!);
                }label:{Text("Post")}
            }
        }
    }
}

struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView()
    }
}
