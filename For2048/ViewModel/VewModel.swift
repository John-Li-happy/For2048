//
//  ViewModel.swift
//  For2048
//
//  Created by Zhaoyang Li on 10/23/20.
//

import Foundation

class ViewModel {
    //MARK: - DOWN
    func downHandler(inputMatrix: [[Int]], aSimpleHnadler handler: @escaping ([[Int]]) -> Void) {
        var outputMatrix = inputMatrix
        
        for eachColumeIndex in 0..<inputMatrix.count {
            var calculatedFlag = false
            var columeArray: [Int] = inputMatrix.map{ $0[eachColumeIndex] }

            for eachElement in stride(from: columeArray.count - 1, to: -1, by: -1) {
                if eachElement == 0 {
                    columeArray = downTurn(inputRow: columeArray, inputIndex: eachElement)
                } else {
                    if calculatedFlag {
                        columeArray = downTurn(inputRow: columeArray, inputIndex: eachElement)
                    } else {
                        if columeArray[eachElement] == columeArray[eachElement - 1] {
                            columeArray[eachElement] = columeArray[eachElement] * 2
                            columeArray[eachElement - 1] = 0
                            columeArray = downTurn(inputRow: columeArray, inputIndex: eachElement)
                            calculatedFlag = true
                        } else {
                            columeArray = downTurn(inputRow: columeArray, inputIndex: eachElement)
                        }
                    }
                }
            }
            for populateCounter in 0..<outputMatrix.count {
                outputMatrix[populateCounter][eachColumeIndex] = columeArray[populateCounter]
            }
        }
        handler(outputMatrix)
    }
    private func downTurn(inputRow: [Int], inputIndex: Int) -> [Int] {
        var outputRow = inputRow
        if inputIndex == inputRow.count - 1 { return inputRow }
        
        var minZeroIndex = -1
        for counter in inputIndex..<inputRow.count {
            if outputRow[counter] == 0 { minZeroIndex = counter }
            
            if counter == inputRow.count - 1 {
                if minZeroIndex != -1 {
                    outputRow[minZeroIndex] = outputRow[inputIndex]
                    outputRow[inputIndex] = 0
                } else { return inputRow }
            }
        }
        return outputRow
    }
    
    //MARK: - UP
    func upHandler(inputMatrix: [[Int]], aSimpleHnadler handler: @escaping ([[Int]]) -> Void) {
        var outputMatrix = inputMatrix
        for eachColume in 0..<inputMatrix.count {
            var columeArray: [Int] = inputMatrix.map{ $0[eachColume] }
            var calculatedFlag = false
            
            for eachElement in 0..<columeArray.count {
                if eachElement == columeArray.count - 1 {
                    columeArray = upTurn(inputRow: columeArray, inputIndex: eachElement)
                } else {
                    if calculatedFlag {
                        columeArray = upTurn(inputRow: columeArray, inputIndex: eachElement)
                    } else {
                        if columeArray[eachElement] == columeArray[eachElement + 1] {
                            columeArray[eachElement] = columeArray[eachElement] * 2
                            columeArray[eachElement + 1] = 0
                            columeArray = upTurn(inputRow: columeArray, inputIndex: eachElement)
                            calculatedFlag = true
                        } else {
                            columeArray = upTurn(inputRow: columeArray, inputIndex: eachElement)
                        }
                    }
                }
            }
            for populateCounter in 0..<outputMatrix.count {
                outputMatrix[populateCounter][eachColume] = columeArray[populateCounter]
            }
        }
        handler(outputMatrix)
    }
    private func upTurn(inputRow: [Int], inputIndex: Int) -> [Int] {
        var outputRow = inputRow
        if inputIndex == 0 { return inputRow }
        
        var minZeroIndex = 4
        for counter in stride(from: inputIndex - 1, to: -1, by: -1) {
            if outputRow[counter] == 0 { minZeroIndex = counter }
            
            if counter == 0 {
                if minZeroIndex != 4 {
                    outputRow[minZeroIndex] = outputRow[inputIndex]
                    outputRow[inputIndex] = 0
                } else { return inputRow }
            }
        }
        return outputRow
    }
    
    // MARK: - LEFT
    func leftHandler(inputMatrix: [[Int]], aSimpleHnadler handler: @escaping ([[Int]]) -> Void) {
        var outputMatrix = inputMatrix
        for eachRowIndex in 0..<inputMatrix.count {
            var calculatedFlag = false

            for eachElement in 0..<outputMatrix[eachRowIndex].count {
                if eachElement == outputMatrix[eachRowIndex].count - 1 {
                    outputMatrix[eachRowIndex] = leftTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                } else {
                    if calculatedFlag {
                        outputMatrix[eachRowIndex] = leftTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                    } else {
                        if inputMatrix[eachRowIndex][eachElement] == inputMatrix[eachRowIndex][eachElement + 1] {
                            outputMatrix[eachRowIndex][eachElement] = inputMatrix[eachRowIndex][eachElement] * 2
                            outputMatrix[eachRowIndex][eachElement + 1] = 0
                            outputMatrix[eachRowIndex] = leftTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                            calculatedFlag = true
                        } else {
                            outputMatrix[eachRowIndex] = leftTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                        }
                    }
                }
            }
        }
        handler(outputMatrix)
    }
    private func leftTurn(inputRow: [Int], inputIndex: Int) -> [Int] {
        var outputRow = inputRow
        if inputIndex == 0 { return inputRow }
        
        var minZeroIndex = 4
        for counter in stride(from: inputIndex - 1, to: -1, by: -1) {
            if outputRow[counter] == 0 { minZeroIndex = counter }
            
            if counter == 0 {
                if minZeroIndex != 4 {
                    outputRow[minZeroIndex] = outputRow[inputIndex]
                    outputRow[inputIndex] = 0
                } else { return inputRow }
            }
        }
        return outputRow
    }
    
    // MARK: - RIGHT
    func rightHandler(inputMatrix: [[Int]], aSimpleHnadler handler: @escaping ([[Int]]) -> Void) {
        var outputMatrix = inputMatrix
        
        for eachRowIndex in 0..<inputMatrix.count {
            var calculatedFlag = false
            for eachElement in stride(from: outputMatrix[eachRowIndex].count - 1, to: -1, by: -1) {
                if eachElement == 0 {
                    outputMatrix[eachRowIndex] = rightTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                } else {
                    if calculatedFlag {
                        outputMatrix[eachRowIndex] = rightTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                    } else {
                        if inputMatrix[eachRowIndex][eachElement] == inputMatrix[eachRowIndex][eachElement - 1] {
                            outputMatrix[eachRowIndex][eachElement] = inputMatrix[eachRowIndex][eachElement] * 2
                            outputMatrix[eachRowIndex][eachElement - 1] = 0
                            outputMatrix[eachRowIndex] = rightTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                            calculatedFlag = true
                        } else {
                            outputMatrix[eachRowIndex] = rightTurn(inputRow: outputMatrix[eachRowIndex], inputIndex: eachElement)
                        }
                    }
                }
            }
        }
        handler(outputMatrix)
    }
    private func rightTurn(inputRow: [Int], inputIndex: Int) -> [Int] {
        var outputRow = inputRow
        if inputIndex == inputRow.count - 1 { return inputRow }
        
        var minZeroIndex = -1
        for counter in inputIndex..<inputRow.count {
            if outputRow[counter] == 0 { minZeroIndex = counter }
            
            if counter == inputRow.count - 1 {
                if minZeroIndex != -1 {
                    outputRow[minZeroIndex] = outputRow[inputIndex]
                    outputRow[inputIndex] = 0
                } else { return inputRow }
            }
        }
        return outputRow
    }
}

