import AVFoundation

class SoundPreviewPlayer {
    private var audioPlayer: AVAudioPlayer?

    func playPreview(for url: URL) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                DispatchQueue.main.async {
                    self?.audioPlayer = player
                    print("Audio player created. Preparing to play: \(url.lastPathComponent)")
                    print("Duration: \(player.duration), URL: \(url.lastPathComponent)")
                    self?.audioPlayer?.play()
                }
            } catch {
                DispatchQueue.main.async {
                    print("Playback failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
