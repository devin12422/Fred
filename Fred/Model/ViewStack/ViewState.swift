//
//  ViewState.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

import Foundation
import SwiftUI
class ViewState:Identifiable,Hashable,ObservableObject{
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        lhs.uuid == rhs.uuid
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    var name:String
    var image:Image
    @Published var view:AnyMyView
    var uuid = UUID()
    init<V:View>(name:String,image:UIImage,view:V) {
        self.name = name
        self.image = Image(uiImage: image)
        self.view = AnyMyView(view)
    }
}
