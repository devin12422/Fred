//
//  PostView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 2/27/23.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
struct PostCreateView: View {
    @State var post:Post = Post()
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

struct PostView: View {
    var post:Post
    var body: some View {
        VStack{
            Text(post.title)
            Text(post.author.username)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post:Post())
    }
}
struct PostDetailView: View {
    var post:Post
    var body: some View {
        VStack{
            Text(post.title)
            Text(post.author.username)
            Text(post.description)
            List(post.instructions){instruction in
                Text(instruction.string)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post())
    }
}
struct PostListView: View {
    @State var posts:[Post] = [];
        
    var body: some View {
        VStack{
            Text("Posts")
            NavigationView{
                List(posts){post in

                    NavigationLink{
                        PostDetailView(post: post)
                    }label:{
                        PostView(post: post)
                    }
            }
                
            }
        }.task{
            
            Storage.storage().reference().child("posts").list(maxResults:16){(result,error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    let decoder = JSONDecoder()

                for prefix in result!.prefixes {
                    print(prefix.fullPath)
                    prefix.list(maxResults:64){(result,error) in
                        for item in result!.items {
                            item.getData(maxSize: Int64.max){
                                (result,error)in
                                if let error = error {
                                    print(error.localizedDescription)
                                }else{
                                    let p = try? decoder.decode(Post.self, from: result!);
                                    posts.append(p!)


                                }

                            }
                    }
                    // The prefixes under storageReference.
                    // You may call listAll(completion:) recursively on them.
                  }
                for item in result!.items {
                    item.getData(maxSize: Int64.max){(result,error)in
                        if let error = error {
                            print(error.localizedDescription)
                        }else{
                            let p = try? decoder.decode(Post.self, from: result!);
                            posts.append(p!)


                        }

                    }
                    // The items under storageReference.
                }}
                }
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}
