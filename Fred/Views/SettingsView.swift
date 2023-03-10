//
//  SettingsView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/3/23.
//

import SwiftUI
import FirebaseAuth
struct SettingsView: View {
    @State var user:User = getCurrentUser()
    @Binding var logged:Bool
    var body: some View {
        VStack{
        Text(user.email)
            VStack{
                Text("Username")
                TextField("Username",text: $user.username).onSubmit{
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = user.username
            changeRequest?.commitChanges { error in
                if error != nil{
                    print(error?.localizedDescription)
                }
            }
        }}
            Button{
                try? Auth.auth().signOut()
                logged = false
                
            }label:{Text("sign out")}
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(logged:Binding.constant(false))
    }
}
