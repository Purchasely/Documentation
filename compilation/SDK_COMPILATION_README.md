# SDK Documentation Compilation Scripts

This directory contains automated scripts to compile comprehensive SDK documentation for all Purchasely platforms.

---

## Overview

Two bash scripts help automate the SDK documentation compilation process:

1. **`compile_sdk_docs.sh`** - Generates prompt files and checks compilation status
2. **`open_claude_compiler.sh`** - Creates detailed instruction files for Claude Code

---

## Quick Start

### Compile All Platforms at Once

```bash
./open_claude_compiler.sh interactive
```

This creates a master instruction file that guides Claude through compiling all platforms sequentially.

### Compile Individual Platform

```bash
# For iOS
./open_claude_compiler.sh ios

# For React Native
./open_claude_compiler.sh react-native

# For Flutter
./open_claude_compiler.sh flutter

# For Cordova
./open_claude_compiler.sh cordova
```

---

## Scripts Reference

### compile_sdk_docs.sh

**Purpose:** Generate prompts and manage compilation workflow

**Usage:**
```bash
./compile_sdk_docs.sh [command]
```

**Commands:**

| Command | Description |
|---------|-------------|
| `android` | Generate prompt for Android documentation |
| `ios` | Generate prompt for iOS documentation |
| `react-native` | Generate prompt for React Native documentation |
| `flutter` | Generate prompt for Flutter documentation |
| `cordova` | Generate prompt for Cordova documentation |
| `all` | Generate prompts for all platforms |
| `interactive` | Create master instruction file (COMPILE_ALL_PLATFORMS.md) |
| `check` | Check compilation status of all platforms |
| `clean` | Remove generated prompt files |

**Examples:**

```bash
# Check current status
./compile_sdk_docs.sh check

# Generate all prompts
./compile_sdk_docs.sh all

# Create interactive compilation file
./compile_sdk_docs.sh interactive

# Clean up generated files
./compile_sdk_docs.sh clean
```

### open_claude_compiler.sh

**Purpose:** Create detailed instruction files and launch Claude Code sessions

**Usage:**
```bash
./open_claude_compiler.sh [command]
```

**Commands:**

| Command | Description |
|---------|-------------|
| `ios` | Create iOS instruction file |
| `react-native` | Create React Native instruction file |
| `flutter` | Create Flutter instruction file |
| `cordova` | Create Cordova instruction file |
| `all` | Create instruction files for all platforms |
| `interactive` | Create sequential compilation master file |

**Examples:**

```bash
# Create instruction file for iOS
./open_claude_compiler.sh ios

# Create all instruction files
./open_claude_compiler.sh all

# Create sequential compilation workflow
./open_claude_compiler.sh interactive
```

---

## Compilation Workflows

### Workflow 1: Sequential Compilation (Recommended)

Best for compiling all platforms in one session:

```bash
# Step 1: Create the sequential compilation file
./open_claude_compiler.sh interactive

# Step 2: Provide to Claude Code
cat COMPILE_ALL_SEQUENTIAL.md

# Claude will then compile each platform in order:
# 1. ios.md
# 2. react-native.md
# 3. flutter.md
# 4. cordova.md
```

### Workflow 2: Individual Platform Compilation

Best for updating a single platform:

```bash
# Step 1: Create instruction file
./open_claude_compiler.sh ios

# Step 2: Provide to Claude Code
cat COMPILE_IOS_INSTRUCTION.md

# Step 3: Claude compiles ios.md
```

### Workflow 3: Parallel Compilation

Best for speed (requires multiple Claude sessions):

```bash
# Create all instruction files
./open_claude_compiler.sh all

# Then in separate Claude Code sessions:
# Session 1: cat COMPILE_IOS_INSTRUCTION.md
# Session 2: cat COMPILE_REACT_NATIVE_INSTRUCTION.md
# Session 3: cat COMPILE_FLUTTER_INSTRUCTION.md
# Session 4: cat COMPILE_CORDOVA_INSTRUCTION.md
```

---

## Generated Files

### Instruction Files

| File | Purpose |
|------|---------|
| `COMPILE_IOS_INSTRUCTION.md` | iOS compilation instructions |
| `COMPILE_REACT_NATIVE_INSTRUCTION.md` | React Native compilation instructions |
| `COMPILE_FLUTTER_INSTRUCTION.md` | Flutter compilation instructions |
| `COMPILE_CORDOVA_INSTRUCTION.md` | Cordova compilation instructions |
| `COMPILE_ALL_SEQUENTIAL.md` | Sequential compilation workflow |
| `COMPILE_ALL_PLATFORMS.md` | Parallel compilation guide |

### Prompt Files

| File | Purpose |
|------|---------|
| `compile_ios_prompt.txt` | Concise iOS compilation prompt |
| `compile_react_native_prompt.txt` | Concise React Native prompt |
| `compile_flutter_prompt.txt` | Concise Flutter prompt |
| `compile_cordova_prompt.txt` | Concise Cordova prompt |

### Output Files

| File | Status |
|------|--------|
| `android.md` | ✅ Complete |
| `ios.md` | ⏳ Pending |
| `react-native.md` | ⏳ Pending |
| `flutter.md` | ⏳ Pending |
| `cordova.md` | ⏳ Pending |

---

## Checking Compilation Status

```bash
./compile_sdk_docs.sh check
```

**Output:**
```
ℹ Checking compilation status...

✓ android.md - COMPLETE (450 lines)
⚠ ios.md - PENDING
⚠ react-native.md - PENDING
⚠ flutter.md - PENDING
⚠ cordova.md - PENDING
```

---

## Cleaning Up

Remove all generated prompt and instruction files:

```bash
./compile_sdk_docs.sh clean
```

This removes:
- All `compile_*_prompt.txt` files
- All `COMPILE_*_INSTRUCTION.md` files
- `COMPILE_ALL_PLATFORMS.md`
- `COMPILE_ALL_SEQUENTIAL.md`

**Note:** This does NOT remove the final output files (android.md, ios.md, etc.)

---

## Process Documentation

The complete compilation process is documented in:

- **`SDK_COMPILATION_PROCESS.md`** - Full step-by-step process for compiling any platform
- **`CLAUDE.md`** - General context about the Purchasely documentation repository

Both files are referenced by the scripts and used as guides during compilation.

---

## Platform-Specific Notes

### iOS
- Language: Swift (Objective-C compatible)
- Key Features: StoreKit 1 vs 2, CocoaPods/SPM
- Special Sections: StoreKit version selection

### React Native
- Language: JavaScript/TypeScript
- Key Features: npm/yarn, iOS pods, Android gradle
- Special Parameters: `storeKit1`, `androidStores`

### Flutter
- Language: Dart
- Key Features: pub.dev, iOS pods, Android gradle
- Special Parameters: `storeKit1`, `androidStores`

### Cordova
- Language: JavaScript
- Key Features: Plugin installation, config.xml
- Platform Setup: iOS and Android specific configurations

---

## Troubleshooting

### Script Not Executable

```bash
chmod +x compile_sdk_docs.sh
chmod +x open_claude_compiler.sh
```

### Files Already Exist

The scripts will warn if output files already exist. You can:
- Delete the existing file manually
- Answer 'y' when prompted to recreate

### Claude Context

Make sure Claude has access to:
- `SDK_COMPILATION_PROCESS.md`
- `CLAUDE.md`
- `android.md` (as reference)
- Source documentation files in `docs/` and `custom_blocks/`

---

## Example Session

Complete workflow to compile all platforms:

```bash
# 1. Check what's already compiled
./compile_sdk_docs.sh check

# 2. Create sequential compilation workflow
./open_claude_compiler.sh interactive

# 3. Start compilation (in Claude Code)
cat COMPILE_ALL_SEQUENTIAL.md

# 4. Monitor progress
./compile_sdk_docs.sh check

# 5. Clean up when done
./compile_sdk_docs.sh clean
```

---

## Version Updates

When updating for a new SDK version:

1. Update source documentation files
2. Run compilation scripts to regenerate platform docs
3. Review changes in generated files
4. Commit updated platform .md files

---

*For questions or issues, refer to SDK_COMPILATION_PROCESS.md*
