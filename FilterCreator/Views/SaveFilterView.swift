//
//  SaveFilterView.swift
//  FilterCreator
//
//  Created by Jack Smith on 8/25/22.
//

import SwiftUI

struct SaveFilterView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var filterManager: FilterManager
    @State private var name: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("filter name", text: $name)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button(action: {
                    filterManager.saveCurrentFilter(name: name)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("save")
                })
                    .opacity(name.isEmpty ? 0.75 : 1)
                    .disabled(name.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .padding()
                
            }
            .navigationTitle("save current filter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
        }

    }
}

//struct SaveFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveFilterView()
//    }
//}
