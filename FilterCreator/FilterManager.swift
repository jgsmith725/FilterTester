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
    static let contrastDef = PropDefinition(name: "contrast", min: 0.25, max: 4, defaultValue: 1, vintageValue: 0.93)
    static let brightnessDef = PropDefinition(name: "brightness", min: -1, max: 1, defaultValue: 0, vintageValue: 0)
    static let saturationDef = PropDefinition(name: "saturation", min: 0, max: 2, defaultValue: 1, vintageValue: 1.05)
    
    let highlightFilter = CIFilter.highlightShadowAdjust()
    static let highlightDef = PropDefinition(name: "highlight", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let shadowDef = PropDefinition(name: "shadow", min: -1, max: 1, defaultValue: 0, vintageValue: -0.15)
    
    let colorMonochromeFilter = CIFilter.colorMonochrome()
    let tempAndTintFilter = CIFilter.temperatureAndTint()
    static let tempDef = PropDefinition(name: "temp", min: -3000, max: 3000, defaultValue: 0, vintageValue: -30)
    static let tintDef = PropDefinition(name: "tint", min: -100, max: 100, defaultValue: 0, vintageValue: 25)
    
    let vibranceFilter = CIFilter.vibrance()
    static let vibranceDef = PropDefinition(name: "vibrance", min: -1, max: 1, defaultValue: 0, vintageValue: 0.05)
//    static let photoEffectChrome = CIFilter.photoEffectChrome()
    let sharpenLuminescanceFilter = CIFilter.sharpenLuminance()
    static let sharpnessDef = PropDefinition(name: "sharpness", min: 0, max: 2, defaultValue: 1, vintageValue: 0)
    
//    static let hardLightBlend = CIFilter.hardLightBlendMode()
    let colorMatrix = CIFilter.colorMatrix()
    static let rrDef = PropDefinition(name: "rr", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let rgDef = PropDefinition(name: "rg", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let rbDef = PropDefinition(name: "rb", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let grDef = PropDefinition(name: "gr", min: 0, max: 1, defaultValue: 0, vintageValue: 0.2)
    static let ggDef = PropDefinition(name: "gg", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    static let gbDef = PropDefinition(name: "gb", min: 0, max: 1, defaultValue: 0, vintageValue: 0.2)
    static let brDef = PropDefinition(name: "br", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let bgDef = PropDefinition(name: "bg", min: 0, max: 1, defaultValue: 0, vintageValue: 0)
    static let bbDef = PropDefinition(name: "bb", min: 0, max: 1, defaultValue: 1, vintageValue: 1)
    
    let photoEffectInstantFilter = CIFilter.photoEffectInstant()
    let photoEffectFadeFilter = CIFilter.photoEffectFade()
    let photoEffectTrasnferFilter = CIFilter.photoEffectTransfer()
    let photoEffectProcessFilter = CIFilter.photoEffectProcess()

    let photoEffectNoir = CIFilter.photoEffectNoir()
    let randomGenerator = CIFilter.randomGenerator()
    let sourceOverCompositor = CIFilter.sourceOverCompositing()
    let multiplyCompositing = CIFilter.multiplyCompositing()
    
    @Published var photoEffectFade: Bool = false
    @Published var photoEffectInstant: Bool = false
    @Published var photoEffectTransfer: Bool = false
    @Published var photoEffectProcess: Bool = false
    
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
    
    
//    @Published var highlightAmount: Float = FilterManager.exposureDefault
//    @Published var shadowAmount: Float = FilterManager.exposureDefault
//    @Published var temp: Float = FilterManager.exposureDefault
//    @Published var tint: Float = FilterManager.exposureDefault
//    @Published var vibrance: Float = FilterManager.exposureDefault
    
    
    func resetToDefaults() {
        photoEffectFade = false
        photoEffectInstant = false
        photoEffectTransfer = false
        photoEffectProcess = false
        exposure = FilterManager.exposureDef.defaultValue
        contrast = FilterManager.contrastDef.defaultValue
        brightness = FilterManager.brightnessDef.defaultValue
        saturation = FilterManager.saturationDef.defaultValue
        highlight = FilterManager.highlightDef.defaultValue
        shadow = FilterManager.shadowDef.defaultValue
        temp = FilterManager.tempDef.defaultValue
        tint = FilterManager.tintDef.defaultValue
        vibrance = FilterManager.vibranceDef.defaultValue
        sharpness = FilterManager.sharpnessDef.defaultValue
        rr = FilterManager.rrDef.defaultValue
        rg = FilterManager.rgDef.defaultValue
        rb = FilterManager.rbDef.defaultValue
        gr = FilterManager.grDef.defaultValue
        gg = FilterManager.ggDef.defaultValue
        gb = FilterManager.gbDef.defaultValue
        br = FilterManager.brDef.defaultValue
        bg = FilterManager.bgDef.defaultValue
        bb = FilterManager.bbDef.defaultValue
    }
    
    func resetToCurrentVintageFilter() {
        photoEffectFade = true
        photoEffectInstant = false
        photoEffectTransfer = false
        photoEffectProcess = false
        exposure = FilterManager.exposureDef.vintageValue
        contrast = FilterManager.contrastDef.vintageValue
        brightness = FilterManager.brightnessDef.vintageValue
        saturation = FilterManager.saturationDef.vintageValue
        highlight = FilterManager.highlightDef.vintageValue
        shadow = FilterManager.shadowDef.vintageValue
        temp = FilterManager.tempDef.vintageValue
        tint = FilterManager.tintDef.vintageValue
        vibrance = FilterManager.vibranceDef.vintageValue
        sharpness = FilterManager.sharpnessDef.vintageValue
        rr = FilterManager.rrDef.vintageValue
        rg = FilterManager.rgDef.vintageValue
        rb = FilterManager.rbDef.vintageValue
        gr = FilterManager.grDef.vintageValue
        gg = FilterManager.ggDef.vintageValue
        gb = FilterManager.gbDef.vintageValue
        br = FilterManager.brDef.vintageValue
        bg = FilterManager.bgDef.vintageValue
        bb = FilterManager.bbDef.vintageValue
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
            photoEffectTrasnferFilter.inputImage = beginImage
            beginImage = photoEffectTrasnferFilter.outputImage
        }
        
        if photoEffectProcess {
            photoEffectProcessFilter.inputImage = beginImage
            beginImage = photoEffectProcessFilter.outputImage
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
}
