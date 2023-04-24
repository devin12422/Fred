//
//  ViewStack.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 3/29/23.
//

import Foundation
import SwiftUI

class ViewStack:ObservableObject,Identifiable{
    @Published var stack:[ViewLayer]
    init(first_layer:ViewLayer){
        self.stack = [first_layer]
    }
}
