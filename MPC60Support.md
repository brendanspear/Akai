# MPC60 Support – Future Development Notes

**Current Status:**  
This app does not support writing MPC60-format files or reading legacy MPC60 disk images. It focuses exclusively on converting modern WAV and AIFF files for use with Akai S-series samplers.

---

## Why MPC60 Isn’t Supported

The MPC60 uses a unique file and disk format that is different from the S900/S950, and:

- Stores samples, programs (pad assignments), and sequences.
- Uses a different OS and hardware architecture.
- Has no widely documented or open specification for program file structure.

---

## Potential Future Work

If someone wants to extend this app to support MPC60, here are options:

### ✅ Basic Sample Conversion
- **Easy (already possible):**
  - Reuse converted WAV → raw PCM → disk image techniques.
  - Modify sampler headers and directory structures for MPC60 format.

### ⚠️ Program File Writing
- **Medium/Hard (partially documented):**
  - Encode sample layout, tuning, envelope, etc.
  - Reverse-engineer or reference data from emulator projects.

### ❌ MIDI Sequence Support
- **Not planned (outside scope):**
  - Parsing or generating MIDI sequence data is not relevant to sample conversion.

---

## Suggestions

If adding MPC60 support:
1. Add `.mpc60` to the `SamplerType` enum.
2. Update `SamplerType+Properties.swift` to define:
   - Display name
   - Output file extension
   - Supported file types (probably `.wav`, `.aiff`)
3. Add specialized conversion logic to write MPC60-compatible headers and directory structure.
4. Consider referencing tools like **MPC60 Disk Image Extractor** (open-source) for format insights.

---

## Resources

- [MPC60 Manual (PDF)](https://www.vintagesynth.com/sites/default/files/2020-10/mpc60_manual.pdf)
- [MPC-Editor Project (archived)](https://sourceforge.net/projects/mpceditor/)
- [Forums & GitHub projects related to MPC format parsing]

---

_© 2024 Brendan Spear. This is a developer note for future contributors._
