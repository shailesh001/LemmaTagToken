import NaturalLanguage
import Foundation
import CoreML

var str = "Hello, playground"

let speech = """
Space. the final frontier. These are the voyages of the
Starship Enterprise.  Its continuing mission to explore strange new worlds,
to seek out new life and new civilization, to boldly go where no one has
gone before!
"""

extension String {
    func printLemmas() {
        let tagger = NSLinguisticTagger(tagSchemes:[.lemma], options: 0)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        tagger.string = self
        let range = NSRange(location: 0, length: self.utf16.count)
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) {
            (tag, tokenRange, stop) in
            if let lemma = tag?.rawValue {
                print(lemma)
            }
        }
    }
 
    func printLemmas2() {
        // Re-Written as the Natural Language Framework as NSLinguistic Framework is deprecated
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = self
        
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        tagger.enumerateTags(in: self.startIndex..<self.endIndex, unit: .word, scheme: .lemma, options: options) {
            (tag, tokenRange) in
            if let tag = tag {
                print("\(self[tokenRange]): \(tag.rawValue)")
            }
            
            return true
        }
    }
    
    func printPartsOfSpeech() {
        let tagger = NSLinguisticTagger(tagSchemes: [.lexicalClass], options: 0)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        tagger.string = self
        let range = NSRange(location: 0, length: self.utf16.count)
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) {
            (tag, tokenRange, _) in
            if let tag = tag {
                let word = (self as NSString).substring(with: tokenRange)
                print("\(word) is a \(tag.rawValue)")
            }
        }
    }
    
    func printPartsOfSpeech2() {
        // Re-Written as the Natural Language Framework as NSLinguistic Framework is deprecated
        let tagger = NLTagger(tagSchemes: [.lexicalClass])
        tagger.string = self
        
        let options: NLTagger.Options = [.omitPunctuation, .omitWhitespace]
        tagger.enumerateTags(in: self.startIndex..<self.endIndex, unit: .word, scheme: .lexicalClass, options: options) {
            (tag, tokenRange) in
            if let tag = tag {
                print("\(self[tokenRange]): \(tag.rawValue)")
            }
            
            return true
        }
    }
    
    func printTokens() {
        let tagger = NSLinguisticTagger(tagSchemes:[.tokenType], options: 0)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
        
        tagger.string = self
        let range = NSRange(location: 0, length: self.utf16.count)
        
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) {
            (tag, tokenRange, stop) in
            let word = (self as NSString).substring(with: tokenRange)
            print(word)
        }
    }
    
    func printTokens2() {
        // Re-Written using the Natural Language Framework
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = self
        
        tokenizer.enumerateTokens(in: self.startIndex..<self.endIndex) {
            (tokenRange, _) in
            print("Token: \(self[tokenRange])")
            return true
        }
    }
}

//speech.printLemmas()
speech.printLemmas2()
//speech.printPartsOfSpeech()
speech.printPartsOfSpeech2()
//speech.printTokens()
speech.printTokens2()
