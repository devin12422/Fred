//
//  ObservableOptionalString.swift
//  Fred
//
//  Created by Devin Kramer (student LM) on 4/19/23.
//

import Foundation
class ObservableOptionalString:ObservableObject{
    @Published var string:String?
    init(string:String? = .none){
        self.string = string
    }
}
