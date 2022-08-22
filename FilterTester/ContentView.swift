//
//  ContentView.swift
//  FilterTester
//
//  Created by Jack Smith on 8/21/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var filterManager: FilterManager = FilterManager()
    
    @State private var sourceType: PickerSourceType? = nil
    @State private var inputImage: UIImage? = nil
    @State private var displayedImage: UIImage? = nil
    @State private var showActionSheet: Bool = false
    
    private enum PickerSourceType: Identifiable {
        var id: Self { self }
        case camera
        case library
    }
    
    private var picActions: [Alert.Button] {
        let buttons: [Alert.Button] = [
            .cancel(Text("cancel")),
            .default(Text("camera"), action: {
                sourceType = .camera
            }),
            .default(Text("photo library"), action: {
                sourceType = .library
            })
            ]
        
        return buttons
    }
    
    var body: some View {
        VStack {
            if let image = displayedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            
            ScrollView {
                Button(action: {
                    showActionSheet = true
                }, label: {
                    Text("upload image")
                })
                    .padding()
                
                Button(action: {
                    filterManager.resetToDefaults()
                    guard let image = inputImage else { return }
                    displayedImage = filterManager.applyFilter(image: image)
                    
                }, label: {
                    Text("reset to defaults")
                })
                    .padding()
                
                Group {
                    PropSlider(binding: filterBinding($filterManager.exposure), def: FilterManager.exposureDef)
                    PropSlider(binding: filterBinding($filterManager.contrast), def: FilterManager.contrastDef)
                    PropSlider(binding: filterBinding($filterManager.brightness), def: FilterManager.brightnessDef)
                    PropSlider(binding: filterBinding($filterManager.saturation), def: FilterManager.saturationDef)
                    PropSlider(binding: filterBinding($filterManager.highlight), def: FilterManager.highlightDef)
                    PropSlider(binding: filterBinding($filterManager.shadow), def: FilterManager.shadowDef)
                    PropSlider(binding: filterBinding($filterManager.temp), def: FilterManager.tempDef)
                    PropSlider(binding: filterBinding($filterManager.tint), def: FilterManager.tintDef)
                    PropSlider(binding: filterBinding($filterManager.vibrance), def: FilterManager.vibranceDef)
                }

                Group {
                    PropSlider(binding: filterBinding($filterManager.rr), def: FilterManager.rrDef)
                    PropSlider(binding: filterBinding($filterManager.rg), def: FilterManager.rgDef)
                    PropSlider(binding: filterBinding($filterManager.rb), def: FilterManager.rbDef)
                    PropSlider(binding: filterBinding($filterManager.gr), def: FilterManager.grDef)
                    PropSlider(binding: filterBinding($filterManager.gg), def: FilterManager.ggDef)
                    PropSlider(binding: filterBinding($filterManager.gb), def: FilterManager.gbDef)
                    PropSlider(binding: filterBinding($filterManager.br), def: FilterManager.brDef)
                    PropSlider(binding: filterBinding($filterManager.bg), def: FilterManager.bgDef)
                    PropSlider(binding: filterBinding($filterManager.bb), def: FilterManager.bbDef)
                }
            }
        }
        .fullScreenCover(item: $sourceType, onDismiss: {
            sourceType = nil
        }) { item in
            if sourceType == .camera {
                ImagePicker(image: $inputImage, sourceType: .camera)
            } else if sourceType == .library {
                ImagePicker(image: $inputImage, sourceType: .photoLibrary)
            }
        }
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("choose an image"),
                        message: Text(""),
                        buttons: picActions)
        })
    }
    
    private func filterBinding(_ binding: Binding<Float>) -> Binding<Float> {
        return Binding(get: {
            binding.wrappedValue
        }, set: { (newVal) in
            binding.wrappedValue = newVal
            guard let image = inputImage else { return }
            displayedImage = filterManager.applyFilter(image: image)
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
