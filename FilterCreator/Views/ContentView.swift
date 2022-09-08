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
    @State private var showOriginal: Bool = false
    @State private var showSaveFilter: Bool = false
    
    private enum PickerSourceType: Identifiable {
        var id: Self { self }
        case camera
        case library
    }
    
    private var picActions: [Alert.Button] {
        let buttons: [Alert.Button] = [
            .cancel(Text("cancel")),
            //            .default(Text("camera"), action: {
            //                sourceType = .camera
            //            }),
                .default(Text("photo library"), action: {
                    sourceType = .library
                })
        ]
        
        return buttons
    }
    
    var body: some View {
        VStack {
            if let image = displayedImage, let inputImage = inputImage {
                if !filterManager.isLandscape {
                    Image(uiImage: showOriginal ? inputImage : image)
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(showOriginal ? Angle(degrees: 0) : Angle(degrees: -90))
                        .padding()
                        .onTapGesture {
                            showOriginal.toggle()
                        }
                    HStack {
                        Text(showOriginal ? "showing original image (tap image to toggle)" : "filters applied (tap image to toggle)")
                            .font(.caption)
                            .padding(.horizontal)
                        Spacer()
                        Button(action: {
                            sourceType = .library
                        }, label: {
                            Text("new image")
                        })
                    }
                    .padding(.horizontal)

                    
                } else {
                    Image(uiImage: showOriginal ? inputImage : image)
                        .resizable()
                        .scaledToFill()
                        .rotationEffect(showOriginal ? Angle(degrees: 0) : Angle(degrees: -90))
                        .padding()
                        .onTapGesture {
                            showOriginal.toggle()
                        }
                }
            } else {
//                Image(systemName: "photo")
//                    .padding()
//                    .background(Rectangle().stroke().foregroundColor(Color.blue))
//                    .onTapGesture {
//                        showActionSheet = true
//                        //sourceType = .library
//                    }
                Button(action: {
                    showActionSheet = true
                    //sourceType = .library
                }, label: {
                    Text("upload an image")
                })
                    .padding()
            }
            
            if !filterManager.isLandscape && displayedImage != nil {
                ScrollView {
                    Menu(content: {
                        ForEach(filterManager.savedFilters){ filter in
                            Button(action: {
                                print("button tapped for filter \(filter.name)")
                                filterManager.loadFilter(filter: filter)
                                applyFilter()
                            }, label: {
                                Text(filter.name)
                            })
                        }
                    }, label: {
                        Text(filterManager.activeFilter?.name ?? "no filter")
                            .font(.largeTitle)
                            .padding(.horizontal)
                            .padding(.top)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                    })
                    
                    Button(action: {
                        showSaveFilter = true
                    }, label: {
                        Text("save current filter")
                    })
                        .padding()
                    
                    if let activeFilter = filterManager.activeFilter, !filterManager.isReservedFilter(name: activeFilter.name) {
                        Button(action: {
                            filterManager.deleteFilter(name: activeFilter.name)
                        }, label: {
                            Text("delete current filter")
                                .foregroundColor(Color.red)
                        })
                            .padding()
                    }

                    Group {
                        Toggle(isOn: $filterManager.photoEffectFade) {
                            Text("diminished color vintage")
                        }
                        .onChange(of: filterManager.photoEffectFade) { _ in
                            applyFilter()
                        }
                        Toggle(isOn: $filterManager.photoEffectInstant) {
                            Text("distorted vintage")
                        }
                        .onChange(of: filterManager.photoEffectInstant) { _ in
                            applyFilter()
                        }
                        Toggle(isOn: $filterManager.photoEffectTransfer) {
                            Text("warm vintage")
                        }
                        .onChange(of: filterManager.photoEffectTransfer) { _ in
                            applyFilter()
                        }
                        Toggle(isOn: $filterManager.photoEffectProcess) {
                            Text("cool vintage")
                        }
                        .onChange(of: filterManager.photoEffectProcess) { _ in
                            applyFilter()
                        }
                        Toggle(isOn: $filterManager.photoEffectNoir) {
                            Text("noir")
                        }
                        .onChange(of: filterManager.photoEffectNoir) { _ in
                            applyFilter()
                        }
                    }
                    .padding(.horizontal)
                    
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
                        PropSlider(binding: filterBinding($filterManager.sharpness), def: FilterManager.sharpnessDef)
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
        }
        .sheet(isPresented: $showSaveFilter) {
            SaveFilterView()
                .environmentObject(filterManager)
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
        .onChange(of: inputImage) { _ in
            print("input image change")
            applyFilter()
        }
        .onAppear {
            filterManager.setup()
        }
    }
    
    private func filterBinding(_ binding: Binding<Float>) -> Binding<Float> {
        return Binding(get: {
            binding.wrappedValue
        }, set: { (newVal) in
            binding.wrappedValue = newVal
            applyFilter()
        })
    }
    
    private func applyFilter() {
        guard let image = inputImage else { return }
        displayedImage = filterManager.applyFilter(image: image)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
