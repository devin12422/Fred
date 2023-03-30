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
    @State var post:Post = Post()
    @State var posted = false
    var body: some View {
        VStack{
            Text("Enter a Title for the post")
            TextField("Name",text: $post.title)
            Text("Please make a description for the post")
            TextField("Description",text: $post.description)
            HStack{
                Button{
                    if(post.isComplete()){
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
                        
                    }
                }label:{Text("Post")}
            }
        }
        .alert(isPresented: $posted) {
            Alert(title: Text("Success"), message: Text("Your post has been created."),dismissButton: .default(Text("Ok")){
                post = Post()
            })
        }
    }
}
           
struct PostCreateView_Previews: PreviewProvider {
    static var previews: some View {
        PostCreateView()
    }
}
