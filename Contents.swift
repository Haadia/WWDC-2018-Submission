
/*:
 # Drawing Calculator
 */
/*:
## Introduction
 A ‘redo’ of iPhone calculator app, with Machine Learning capabilities of handwritten digits recognition, using Apple’s recent APIs CoreML and Vision.
*/
/*:
## Usage
 Run using the play button at the bottom of the editor window. Open 'Live view' in assitent editor to view the output.
 
 Draw the digits in the provided black space at bottom right and perform your desired operations.
*/
/*:
## Features
 * Users can add, subtract, divide and multiply.
 * Users can calculate percentages.
 * Users can delete the last digit by swiping left (iOS Calculator's **swipe left to delete** feature)
*/
/*: ## Credits
 [my_mnist]: https://github.com/Weijay/DigitRecognition/tree/master/ML_model "Some hover text"
 
 I used open-source [my_mnist] CoreML model, based on MNIST dataset, to predict the probability of handwritten digits.
 */


import UIKit
import PlaygroundSupport


let view1 = MainView(frame: CGRect(x: 0, y: 0, width: 360, height: 640))

PlaygroundSupport.PlaygroundPage.current.liveView = view1

