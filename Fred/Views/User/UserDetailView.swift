//
//  UserDetailView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/22/23.
//

import SwiftUI
//enum UserViewState: String, CaseIterable, Identifiable {
//    case description, recipes, following
//    var id: Self { self }
//}

struct UserDetailView: View {
    var user:User
    //@State private var view_state:UserViewState = .description
    var body: some View {
        VStack{
//            UserView(user: user)
//            Picker("", selection: $view_state) {
//                ForEach(UserViewState.allCases) { state in
//                    Text(view_state.rawValue.capitalized)
//                }
//            }.pickerStyle(.wheel)
            Text("Details")
        }
        .task {
        }
            
        
    }
    
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user:User())
    }
}
