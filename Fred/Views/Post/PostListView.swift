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
enum MenuState:String, CaseIterable, Identifiable{
    var id: Self { self }

    case Feed
    case Mine
    case Search
}
struct PostListView: View {
    @State var posts:[Post] = [];
    @State var menu_state:MenuState = .Mine
    @State var search:String = ""
    @State var commentsection: [Comment] = [];

    var body: some View {
        VStack{
//            HStack{
//                Picker("Menu",selection:$menu_state){
//                    ForEach(MenuState.allCases) { state in
//                        Text(state.rawValue.capitalized)
//                    }
//                }.frame(maxWidth: 50).pickerStyle(.wheel)
//                switch menu_state {
//                case .Feed: Text("bruhd")
//                    
//                case .Mine:
//                    Text("bruh")
//                case .Search:
//                    TextField("Search",text:$search)
//                }
//            }
            NavigationView{
                List(posts)
    {post in
                    NavigationLink{
                        PostDetailView(post: post, comments: commentsection)
    
    
                    }label:{
                        PostView(post: post)
                    
                        
                    }
                    
            }
                
                
            }
        }.task{
            posts.removeAll()
            print("fetching posts")
            Storage.storage().reference().child("posts").list(maxResults:16){(result,error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    let decoder = JSONDecoder()
                print("decoding posts")
                for pfx in result!.prefixes {

                    User.get(uid:pfx.name){
                        user in
                        pfx.list(maxResults:64){(result,error) in
                            for item in result!.items {
                                item.getData(maxSize: Int64.max){
                                    (result,error)in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    }else{
                                        guard let p = try? decoder.decode(Post.self, from: result!)
                                        else{
                                            print("error");
                                            return;
                                        }
                                        p.author = user
                                        posts.append(p)
                                        print("decoded post")
                                    }

                            }
                        }
                        }
                    }
                    
                    }
                    
                }
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(commentsection: [Comment]())
    }
}

