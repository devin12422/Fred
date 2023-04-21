//
//  AnyMyView.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/14/23.
//

import Foundation
import SwiftUI
struct AnyMyView: View {

    private let internalView: AnyView
    let original_view: Any
    let view_type: Any.Type;
    
    init<V: View>(_ view: V) {
        internalView = AnyView(view)
        original_view = view
        view_type = V.self
    }
    
    var body: some View {
        internalView
    }
}
