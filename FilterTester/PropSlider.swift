//
//  PropSlider.swift
//  FilterTester
//
//  Created by Jack Smith on 8/21/22.
//

import SwiftUI

struct PropSlider: View {
    let binding: Binding<Float>
    let def: PropDefinition
    
    var body: some View {
        VStack {
            Slider(value: binding, in: def.min...def.max, label: { Text(def.name) } , minimumValueLabel: { Text(String(describing: def.min)) }, maximumValueLabel: { Text(String(describing: def.max)) })
            Text("\(def.name) \(binding.wrappedValue)")
        }
    }
}

//struct PropSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        PropSlider()
//    }
//}
