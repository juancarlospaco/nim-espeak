import osproc, strformat, strutils


const espeakVersion* = staticExec("espeak --version")  ## Espeak version that this Nim module was using when compiled.


proc espeak*(words: string, pitch: range[0..99] = 50, voice = "en-us",
             amplitude: range[0..200] = 100, speed: int16 = 165, wave_file = "",
             end_pause = true, punctuation = false): tuple =
  let
    pau = if end_pause: "" else: "-z"
    pun = if punctuation: "--punct" else: ""
    wav = if wave_file.endsWith(".wav"): fmt"-w {quoteShell(wave_file)}" else: ""
  execCmdEx(fmt"espeak -b 1 {pau} {pun} {wav} -a {amplitude} -p {pitch} -s {speed} -v {voice.strip} {quoteShell(words.strip)}")


when is_main_module:
  echo espeak("Hello, this is a Demo of Nim-Espeak, Nim wrapper for Espeak-NG.")
