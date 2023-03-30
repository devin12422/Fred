//
//  PostListView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import SwiftUI
import FirebaseStorage
import FirebaseAuth
enum FeedState{
    case Loading
    case Loaded
    case Error
}
struct PostListView: View {
    @State var posts:[PostWrapper] = [];
    @State var feed_state:FeedState = .Loading
    @State var page_token:String = ""
    var body: some View {
        VStack{
            switch feed_state {
            case .Error:
                Text("An unknown error occurred")
            default:
                NavigationView{
                    List(posts){post in
                        NavigationLink{
                            PostDetailView(post: post)
                        }label:{
                            PostView(post: post)
                        }
                    }
                }
            }
        }.task{
            if(feed_state == .Loading){
                getPosts()
            }
        }
    }
    func getPosts(){
            print("fetching posts")
            Storage.storage().reference().child("posts").list(maxResults:8,pageToken: page_token,completion:{(result,error) in
                if let error = error {
                    print(error.localizedDescription)
                    feed_state = .Error
                }else{
                    if result?.pageToken != .none{
                        page_token = (result?.pageToken!)!
                    }
                    let decoder = JSONDecoder()
                    print("decoding posts")
                    for pfx in result!.prefixes {
                        print(pfx.name)
                        User.get(uid:pfx.name){user in
                            pfx.list(maxResults:4){(result,error) in
                                for item in result!.items {
                                    item.getData(maxSize: Int64.max){
                                        (result,error)in
                                        if let error = error {
                                            print(error.localizedDescription)
                                            feed_state = .Error
                                        }else{
                                            guard let p = try? decoder.decode(Post.self, from: result!)
                                            else{
                                                print("error decoding post");
                                                feed_state = .Error
                                                return;
                                            }
                                            posts.append(PostWrapper(post:p,author: user))
                                        }
                                    }
                                }
                            }
                        }
                    
                    }
                    feed_state = .Loaded
                    
                }
            })
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView()
    }
}

