//
//  SaveFilterView.swift
//  FilterCreator
//
//  Created by Jack Smith on 8/25/22.
//

import SwiftUI

struct SaveFilterView: View {
    @EnvironmentObject private var filterManager: FilterManager
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            TextField("filter name", text: $name)
            Spacer()
            Button(action: {
                filterManager.saveCurrentFilter(name: name)
            }, label: {
                Text("save")
            })
                .opacity(name.isEmpty ? 0.75 : 1)
                .disabled(name.isEmpty)
        }
    }
}

//struct SaveFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveFilterView()
//    }
//}
