//
//  FilterManager.swift
//  FilterTester
//
//  Created by Jack Smith on 8/21/22.
//

import Foundation
import UIKit
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

final class FilterManager: ObservableObject {
    static let shared = FilterManager()
    
    let exposureFilter = CIFilter.exposureAdjust()
    static let exposureDef = PropDefinition(name: "exposure", min: -10, max: 10, defaultValue: 0, vintageValue: 0.2)
    
    let colorFilter = CIFilter.colorControls()
    static let contrastDef = PropDefinition(name: "contrast", min: 0.25, max: 4, defaultValue: 1, vintageValue: 0.97)
    static let brightnessDef = PropDefinition(name: "brightness", min: -1, max: 1, defaultValue: 0, vintageValue: 0)
    static let saturationDef = PropDefinition(name: "saturation", min: 0, max: 2, defaultValue: 1, vintageValue: 1.05)
    
    let highlightFilter = CIFilter.highlightShadowAdjust()
    static let highlightDef = PropDefinition(name: "highlight", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let shadowDef = PropDefinition(name: "shadow", min: -1, max: 1, defaultValue: 0, vintageValue: -0.15)
    
    let colorMonochromeFilter = CIFilter.colorMonochrome()
    let tempAndTintFilter = CIFilter.temperatureAndTint()
    static let tempDef = PropDefinition(name: "temp", min: -3000, max: 3000, defaultValue: 0, vintageValue: -30)
    static let tintDef = PropDefinition(name: "tint", min: -100, max: 100, defaultValue: 0, vintageValue: 0)
    
    let vibranceFilter = CIFilter.vibrance()
    static let vibranceDef = PropDefinition(name: "vibrance", min: -1, max: 1, defaultValue: 0, vintageValue: 0.1)
//    static let photoEffectChrome = CIFilter.photoEffectChrome()
    let sharpenLuminescanceFilter = CIFilter.sharpenLuminance()
    static let sharpnessDef = PropDefinition(name: "sharpness", min: 0, max: 2, defaultValue: 1, vintageValue: 1)
    
//    static let hardLightBlend = CIFilter.hardLightBlendMode()
    let colorMatrix = CIFilter.colorMatrix()
    static let rrDef = PropDefinition(name: "rr", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let rgDef = PropDefinition(name: "rg", min: 0, max: 1, defaultValue: 0, vintageValue: 0.1)
    static let rbDef = PropDefinition(name: "rb", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let grDef = PropDefinition(name: "gr", min: 0, max: 1, defaultValue: 0, vintageValue: 0.13)
    static let ggDef = PropDefinition(name: "gg", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let gbDef = PropDefinition(name: "gb", min: 0, max: 1, defaultValue: 0, vintageValue: 0.13)
    static let brDef = PropDefinition(name: "br", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let bgDef = PropDefinition(name: "bg", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let bbDef = PropDefinition(name: "bb", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    
    let photoEffectInstantFilter = CIFilter.photoEffectInstant()
    let photoEffectFadeFilter = CIFilter.photoEffectFade()
    let photoEffectTransferFilter = CIFilter.photoEffectTransfer()
    let photoEffectProcessFilter = CIFilter.photoEffectProcess()

    let photoEffectNoirFilter = CIFilter.photoEffectNoir()
    let randomGenerator = CIFilter.randomGenerator()
    let sourceOverCompositor = CIFilter.sourceOverCompositing()
    let multiplyCompositing = CIFilter.multiplyCompositing()
    
    @Published var isLandscape: Bool = true
    
    @Published var photoEffectFade: Bool = false
    @Published var photoEffectInstant: Bool = false
    @Published var photoEffectTransfer: Bool = false
    @Published var photoEffectProcess: Bool = false
    @Published var photoEffectNoir: Bool = false
    
    @Published var exposure: Float = FilterManager.exposureDef.defaultValue //-10 to 10
    @Published var contrast: Float = FilterManager.contrastDef.defaultValue //.25 to 4, 1 is center
    @Published var brightness: Float = FilterManager.brightnessDef.defaultValue //-10 to 10
    @Published var saturation: Float = FilterManager.saturationDef.defaultValue //-10 to 10
    @Published var highlight: Float = FilterManager.highlightDef.defaultValue
    @Published var shadow: Float = FilterManager.shadowDef.defaultValue
    @Published var temp: Float = FilterManager.tempDef.defaultValue
    @Published var tint: Float = FilterManager.tintDef.defaultValue
    @Published var vibrance: Float = FilterManager.vibranceDef.defaultValue
    @Published var sharpness: Float = FilterManager.sharpnessDef.defaultValue
    @Published var rr: Float = FilterManager.rrDef.defaultValue
    @Published var rg: Float = FilterManager.rgDef.defaultValue
    @Published var rb: Float = FilterManager.rbDef.defaultValue
    @Published var gr: Float = FilterManager.grDef.defaultValue
    @Published var gg: Float = FilterManager.ggDef.defaultValue
    @Published var gb: Float = FilterManager.gbDef.defaultValue
    @Published var br: Float = FilterManager.brDef.defaultValue
    @Published var bg: Float = FilterManager.bgDef.defaultValue
    @Published var bb: Float = FilterManager.bbDef.defaultValue
    @Published var savedFilters: [FilterConfig] = []
    @Published var activeFilter: FilterConfig? = nil
    
    static let defaultFilters = [defaultFilter, currentVintageFilter, noirFilter]
    
    static let defaultFilter = FilterConfig(name: "none",
                                            instant: false,
                                            fade: false,
                                            transfer: false,
                                            process: false,
                                            noir: false,
                                            exposure: FilterManager.exposureDef.defaultValue,
                                            contrast: FilterManager.contrastDef.defaultValue,
                                            brightness: FilterManager.brightnessDef.defaultValue,
                                            saturation: FilterManager.saturationDef.defaultValue,
                                            highlight: FilterManager.highlightDef.defaultValue,
                                            shadow: FilterManager.shadowDef.defaultValue,
                                            temp: FilterManager.tempDef.defaultValue,
                                            tint: FilterManager.tintDef.defaultValue,
                                            sharpness: FilterManager.sharpnessDef.defaultValue,
                                            vibrance: FilterManager.vibranceDef.defaultValue,
                                            rr: FilterManager.rrDef.defaultValue,
                                            rg: FilterManager.rgDef.defaultValue,
                                            rb: FilterManager.rbDef.defaultValue,
                                            gr: FilterManager.grDef.defaultValue,
                                            gg: FilterManager.ggDef.defaultValue,
                                            gb: FilterManager.gbDef.defaultValue,
                                            br: FilterManager.brDef.defaultValue,
                                            bg: FilterManager.bgDef.defaultValue,
                                            bb: FilterManager.bbDef.defaultValue)
    
    static let currentVintageFilter = FilterConfig(name: "vintage",
                                                   instant: false,
                                                 fade: true,
                                                 transfer: false,
                                                 process: false,
                                                   noir: false,
                                                 exposure: FilterManager.exposureDef.vintageValue,
                                                 contrast: FilterManager.contrastDef.vintageValue,
                                                 brightness: FilterManager.brightnessDef.vintageValue,
                                                 saturation: FilterManager.saturationDef.vintageValue,
                                                 highlight: FilterManager.highlightDef.vintageValue,
                                                 shadow: FilterManager.shadowDef.vintageValue,
                                                 temp: FilterManager.tempDef.vintageValue,
                                                 tint: FilterManager.tintDef.vintageValue,
                                                 sharpness: FilterManager.sharpnessDef.vintageValue,
                                                 vibrance: FilterManager.vibranceDef.vintageValue,
                                                 rr: FilterManager.rrDef.vintageValue,
                                                 rg: FilterManager.rgDef.vintageValue,
                                                 rb: FilterManager.rbDef.vintageValue,
                                                 gr: FilterManager.grDef.vintageValue,
                                                 gg: FilterManager.ggDef.vintageValue,
                                                 gb: FilterManager.gbDef.vintageValue,
                                                 br: FilterManager.brDef.vintageValue,
                                                 bg: FilterManager.bgDef.vintageValue,
                                                 bb: FilterManager.bbDef.vintageValue)
    
    static let noirFilter = FilterConfig(name: "noir",
                                            instant: false,
                                            fade: false,
                                            transfer: false,
                                            process: false,
                                            noir: true,
                                            exposure: FilterManager.exposureDef.defaultValue,
                                            contrast: FilterManager.contrastDef.defaultValue,
                                            brightness: FilterManager.brightnessDef.defaultValue,
                                            saturation: FilterManager.saturationDef.defaultValue,
                                            highlight: FilterManager.highlightDef.defaultValue,
                                            shadow: FilterManager.shadowDef.defaultValue,
                                            temp: FilterManager.tempDef.defaultValue,
                                            tint: FilterManager.tintDef.defaultValue,
                                            sharpness: FilterManager.sharpnessDef.defaultValue,
                                            vibrance: FilterManager.vibranceDef.defaultValue,
                                            rr: FilterManager.rrDef.defaultValue,
                                            rg: FilterManager.rgDef.defaultValue,
                                            rb: FilterManager.rbDef.defaultValue,
                                            gr: FilterManager.grDef.defaultValue,
                                            gg: FilterManager.ggDef.defaultValue,
                                            gb: FilterManager.gbDef.defaultValue,
                                            br: FilterManager.brDef.defaultValue,
                                            bg: FilterManager.bgDef.defaultValue,
                                            bb: FilterManager.bbDef.defaultValue)
    
    func loadFilter(filter: FilterConfig) {
        photoEffectFade = filter.fade
        photoEffectInstant = filter.instant
        photoEffectTransfer = filter.transfer
        photoEffectProcess = filter.process
        photoEffectNoir = filter.noir
        exposure = filter.exposure
        contrast =  filter.contrast
        brightness = filter.brightness
        saturation = filter.saturation
        highlight = filter.highlight
        shadow = filter.shadow
        temp = filter.temp
        tint = filter.tint
        vibrance = filter.vibrance
        sharpness = filter.sharpness
        rr = filter.rr
        rg = filter.rg
        rb = filter.rb
        gr = filter.gr
        gg = filter.gg
        gb = filter.gb
        br = filter.br
        bg = filter.bg
        bb = filter.bb
        
        activeFilter = filter
    }
    
    func getCurrentFilter(name: String) -> FilterConfig {
        let currentFilter = FilterConfig(name: name,
                                         instant: photoEffectInstant,
                                         fade: photoEffectFade,
                                         transfer: photoEffectTransfer,
                                         process: photoEffectProcess,
                                         noir: photoEffectNoir,
                                         exposure: exposure,
                                         contrast: contrast,
                                         brightness: brightness,
                                         saturation: saturation,
                                         highlight: highlight,
                                         shadow: shadow,
                                         temp: temp,
                                         tint: tint,
                                         sharpness: sharpness,
                                         vibrance: vibrance,
                                         rr: rr,
                                         rg: rg,
                                         rb: rb,
                                         gr: gr,
                                         gg: gg,
                                         gb: gb,
                                         br: br,
                                         bg: bg,
                                         bb: bb)
        return currentFilter
    }
    
    func applyFilter(image: UIImage) -> UIImage {
        let context = CIContext()
        var beginImage = CIImage(image: image)
        
        if photoEffectFade {
            photoEffectFadeFilter.inputImage = beginImage
            beginImage = photoEffectFadeFilter.outputImage
        }
        
        if photoEffectInstant {
            photoEffectInstantFilter.inputImage = beginImage
            beginImage = photoEffectInstantFilter.outputImage
        }
        
        if photoEffectTransfer {
            photoEffectTransferFilter.inputImage = beginImage
            beginImage = photoEffectTransferFilter.outputImage
        }
        
        if photoEffectProcess {
            photoEffectProcessFilter.inputImage = beginImage
            beginImage = photoEffectProcessFilter.outputImage
        }
        
        if photoEffectNoir {
            photoEffectNoirFilter.inputImage = beginImage
            beginImage = photoEffectNoirFilter.outputImage
        }

        exposureFilter.inputImage = beginImage
        exposureFilter.ev = exposure //-10 to 10
        beginImage = exposureFilter.outputImage
        
        colorFilter.inputImage = beginImage
        colorFilter.contrast = contrast //.25 to 4, 1 is center
        colorFilter.brightness = brightness //-1 to 1
        colorFilter.saturation = saturation //0 to 2
        beginImage = colorFilter.outputImage
        
        
        highlightFilter.inputImage = beginImage
        highlightFilter.highlightAmount = highlight //0 to 1
        highlightFilter.shadowAmount = shadow //-1 to 1
        //highlightFilter.radius
        beginImage = highlightFilter.outputImage
        
        tempAndTintFilter.inputImage = beginImage // temp down, tint up
        tempAndTintFilter.neutral = CIVector(x: CGFloat(temp) + 6500, y: CGFloat(tint))
        tempAndTintFilter.targetNeutral = CIVector(x: 6500, y: 0)
        beginImage = tempAndTintFilter.outputImage

        vibranceFilter.inputImage = beginImage
        vibranceFilter.amount = vibrance //-1 to 1
        beginImage = vibranceFilter.outputImage

        sharpenLuminescanceFilter.inputImage = beginImage
        sharpenLuminescanceFilter.sharpness = sharpness //0 to 2
        beginImage = sharpenLuminescanceFilter.outputImage
        
        //hardLightBlend.inputImage = sharpenLuminescance.outputImage
        
        colorMatrix.inputImage = beginImage
        colorMatrix.rVector = CIVector(x:  CGFloat(rr), y:  CGFloat(rg), z:  CGFloat(rb), w: 0) //turn oranges slightly to red
        colorMatrix.gVector = CIVector(x:  CGFloat(gr), y:  CGFloat(gg), z:  CGFloat(gb), w: 0) //add green
        colorMatrix.bVector = CIVector(x: CGFloat(br), y: CGFloat(bg), z: CGFloat(bb), w: 0)
        beginImage = colorMatrix.outputImage
        //let noisyImage = addNoise(image: colorMatrix.outputImage)
        let noisyImage = beginImage

        
        guard let newImage = noisyImage else {
            return image //return the input
        }
    

        if let cgimg = context.createCGImage(newImage, from: newImage.extent){
            let uiImage = UIImage(cgImage: cgimg, scale: 1, orientation: .right)
            return uiImage
        }
        return image //return the input
    }
    
    private func addNoise(image: CIImage?) -> CIImage? {
        guard let image = image else { return nil }
        let whitenVector = CIVector(x: 0, y: 1, z: 0, w: 0)
        let fineGrain = CIVector(x:0, y:0.005, z:0, w:0)
        let zeroVector = CIVector(x: 0, y: 0, z: 0, w: 0)
        
        let noise = randomGenerator.outputImage
        colorMatrix.inputImage = noise
        colorMatrix.rVector = whitenVector
        colorMatrix.gVector = whitenVector
        colorMatrix.bVector = whitenVector
        colorMatrix.aVector = fineGrain
        colorMatrix.biasVector = zeroVector
        
        let whiteSpecks = colorMatrix.outputImage
        
        sourceOverCompositor.inputImage = whiteSpecks
        sourceOverCompositor.backgroundImage = image
        var combinedImage = sourceOverCompositor.outputImage
        combinedImage = combinedImage?.cropped(to: image.extent)
        return combinedImage
    }
    
    func listenForDeviceOrientationChanges() {
        print("starting to listen for orientation changes")
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil, using: { [weak self] notification in
            self?.isLandscape = UIDevice.current.orientation.isLandscape
        })
    }
    
    func setup() {
        listenForDeviceOrientationChanges()
        loadAllFilters()
    }

    func saveCurrentFilter(name: String) {
        guard !isReservedFilter(name: name) else {
            print("attempt to use reserved name failed")
            return
        }
        
        let currentFilter = getCurrentFilter(name: name)
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(currentFilter)
            let manager = FileManager.default
            guard let folderURL = getFolderURL() else { return }
            if !manager.fileExists(atPath: folderURL.path) {
                try manager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            }

            let fileName = folderURL.appendingPathComponent(name)
//            guard fileName.isFileURL && !manager.fileExists(atPath: fileName.path) else {
//                print("file already exists")
//                return
//            }
            
            try data.write(to: fileName)
            
            if let index = savedFilters.firstIndex(where: { $0.name == name }) {
                savedFilters[index] = currentFilter
            } else {
                savedFilters.append(currentFilter)
            }
            activeFilter = currentFilter
        } catch let error {
            print(String(describing: error))
        }

    }
    
    func isReservedFilter(name: String) -> Bool {
        return FilterManager.defaultFilters.map({ $0.name }).contains(name)
    }
    
    func deleteFilter(name: String) {
        guard !isReservedFilter(name: name) else {
            print("attempt to delete reserved name failed")
            return
        }
        let manager = FileManager.default
        guard let folderURL = getFolderURL() else { return }
        let fileName = folderURL.appendingPathComponent(name)
        do {
            if manager.fileExists(atPath: fileName.path) {
                try manager.removeItem(at: fileName)
            }
            if let index = savedFilters.firstIndex(where: { $0.name == name }) {
                savedFilters.remove(at: index)
            }
            loadFilter(filter: FilterManager.defaultFilter)
        } catch let error {
            print(String(describing: error))
        }
    }

    static let filterFolderName = "FilterConfigs"
    
    func loadAllFilters() {
        let manager = FileManager.default
        guard let folderURL = getFolderURL() else { return }
        do {

            let directoryContents = try manager.contentsOfDirectory(atPath: folderURL.path)
            let datas = try directoryContents.map { try Data(contentsOf: URL(fileURLWithPath: folderURL.appendingPathComponent($0).path)) }
            savedFilters = datas.compactMap { tryDecodeFilter(data: $0) }
            savedFilters.append(contentsOf: FilterManager.defaultFilters)
            print("saved filters: \(String(describing: savedFilters))")
        } catch let error {
            print(String(describing: error))
            savedFilters = FilterManager.defaultFilters
        }
    }
    
    private func tryDecodeFilter(data: Data) -> FilterConfig? {
        let jsonDecoder = JSONDecoder()
        do {
            let config = try jsonDecoder.decode(FilterConfig.self, from: data)
            return config
        } catch {
            print(String(describing: error))
        }
        return nil
    }

    private func getFolderURL() -> URL? {
        let manager = FileManager.default
        guard var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        url = url.appendingPathComponent(FilterManager.filterFolderName)
        return url
    }
    
}
