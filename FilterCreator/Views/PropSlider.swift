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
    
    private var stepSize: Float {
        (def.max - def.min) / 200
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Slider(value: binding, in: def.min...def.max, label: { Text(def.name) } , minimumValueLabel: { Text(String(describing: def.min)) }, maximumValueLabel: { Text(String(describing: def.max)) })
            
            Stepper("", value: binding, in: def.min...def.max, step: stepSize)
                .frame(width: 100)
            
            
            HStack {
                Text("\(def.name) \(binding.wrappedValue)")
                Button(action: {
                    binding.wrappedValue = def.defaultValue
                }, label: {
                    Text("reset")
                })
            }
        }
        .padding()
    }
}

//struct PropSlider_Previews: PreviewProvider {
//    static var previews: some View {
//        PropSlider()
//    }
//}
