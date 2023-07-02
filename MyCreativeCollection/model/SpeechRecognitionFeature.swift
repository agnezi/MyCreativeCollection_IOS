//
// Perpetalli-CMS
// Created by: itsjagnezi on 02/07/23
// Copyright (c) today and beyond
//

import Speech
import Foundation
import AVFAudio

final class SpeechRecognitionFeature: ObservableObject {
	
	@Published var buttonIsDisabled = true
	@Published var buttonLabel = "N/A"
	@Published var transcriptedText = ""
	
	private let audioEngine = AVAudioEngine()
	private let speechRecognizer = SFSpeechRecognizer()
	private var recognitionTask: SFSpeechRecognitionTask?
	private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
	
	private func startToSpeech() throws {
		
		recognitionTask?.cancel()
		self.recognitionTask = nil
		
		let audioSession = AVAudioSession.sharedInstance()
		try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
		try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
		let inputNode = audioEngine.inputNode
		
		recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
		guard let recognitionRequest = recognitionRequest else { fatalError("Ta dando ruim no SFSpeechAudioBufferRecognitionRequest object") }
		recognitionRequest.shouldReportPartialResults = true
		
		recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
			var isFinal = false
			
			if let result = result {
				
				// Update the text view with the results.
				self.transcriptedText = result.bestTranscription.formattedString
				isFinal = result.isFinal
				print("Text \(result.bestTranscription.formattedString)")
			}
			
			if error != nil || isFinal {
				// Stop recognizing speech if there is a problem.
				self.audioEngine.stop()
				inputNode.removeTap(onBus: 0)
				
				self.recognitionRequest = nil
				self.recognitionTask = nil
				
				self.buttonLabel = "Já vai dar pra falar"
			}
		}
		
		// Configure the microphone input.
		let recordingFormat = inputNode.outputFormat(forBus: 0)
		inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
			self.recognitionRequest?.append(buffer)
		}
		
		audioEngine.prepare()
		
		try audioEngine.start()
		self.buttonLabel = "Ta gravando"
	}
	
	func checkIfIsAvailable() {
		SFSpeechRecognizer.requestAuthorization { authStatus in
			
			OperationQueue.main.addOperation {
				switch authStatus {
				case .authorized:
					self.buttonIsDisabled = false
					self.buttonLabel = "Say something"
					
				case .denied:
					self.buttonIsDisabled = true
					self.buttonLabel = "User denied"
					
				case .restricted:
					self.buttonIsDisabled = true
					self.buttonLabel = "Speech recogntion restricted on this device"
					
				case .notDetermined:
					self.buttonIsDisabled = true
					self.buttonLabel = "Speech recogntion not yet authorized"
					
				@unknown default:
					fatalError("Something happened")
				}
			}
		}
	}
	
	func recordButtonTapped() {
		if audioEngine.isRunning {
			audioEngine.stop()
			recognitionRequest?.endAudio()
			buttonLabel = "Stopping"
		} else {
			do {
				try startToSpeech()
				buttonLabel = "Stop Recording"
			} catch {
				buttonLabel = "Recording Not Available"
				buttonIsDisabled = true
			}
		}
	}
	
}
