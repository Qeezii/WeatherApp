//
//  LanguageDetection.swift
//  WeatherApp
//
//  Created by Алексей Полетаев on 28.12.2021.
//

import Foundation
import NaturalLanguage
import CoreML

public class LanguageDetection {
    
    public init() {}
        
    public func detectLanguage(text: String) -> String? {
        
        let recognizer = NLLanguageRecognizer()
        recognizer.languageConstraints = [.english, .russian]
        recognizer.processString(text)

        if let language = recognizer.dominantLanguage {
            return language.rawValue
        } else {
            return "en"
        }
    }
}
