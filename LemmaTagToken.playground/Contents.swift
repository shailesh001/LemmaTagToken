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
    func printlemmas() {
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
}

speech.printlemmas()
