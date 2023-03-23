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

    @State var post:Post
    @State var posted = false
    var body: some View {
        VStack{
            TextField("Name",text: $post.title)
            TextField("Description",text: $post.description)
            HStack{
                Button{
                    guard let uid = Auth.auth().currentUser?.uid else{return}
                    let encoder = JSONEncoder();
                    let encoded = try? encoder.encode(post);

                    Storage.storage().reference().child("posts/\(uid)/\(post.uuid)").putData(encoded!){
                        _, error in
                        if error == nil{
                            posted = true
                        }else{
                            print(error!.localizedDescription)
                        }
                    }
                }label:{Text("Post")}
            }
        }.alert(isPresented: $posted) {
            Alert(title:Text("Posted"), message: Text("You posted"),dismissButton: .default(Text("Ok")){
                post = Post(user:post.author)
            })
        }

    }
}

struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView(post:Post(uid:""))
    }
}
