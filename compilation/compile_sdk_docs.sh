#!/bin/bash

# compile_sdk_docs.sh
# Script to compile SDK documentation for all platforms
# Usage: ./compile_sdk_docs.sh [platform] [--force]
# Platforms: android, ios, react-native, flutter, cordova, all
#
# By default an existing platform/<platform>.md is left untouched. To RE-compile
# (e.g. after an SDK major version bump such as v5 -> v6), pass --force so the
# prompt is regenerated and the existing file is meant to be overwritten:
#   ./compile_sdk_docs.sh ios --force
#   ./compile_sdk_docs.sh all --force

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory (compilation/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Root directory (parent of compilation/)
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
# Platform output directory
PLATFORM_DIR="$ROOT_DIR/platform"

cd "$SCRIPT_DIR"

# Ensure platform directory exists
mkdir -p "$PLATFORM_DIR"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Function to generate prompt for a platform
generate_prompt() {
    local platform=$1
    local platform_upper=$(echo "$platform" | tr '[:lower:]' '[:upper:]')
    local output_file="platform/${platform}.md"

    cat > "compile_${platform}_prompt.txt" << EOF
Compile / RE-compile the comprehensive ${platform_upper} SDK documentation file, targeting SDK v6.0.0, following compilation/SDK_COMPILATION_PROCESS.md.

TASK: (Over)write ${output_file}

PLATFORM: ${platform_upper}   (target SDK version: 6.0.0)

PROCESS TO FOLLOW:
1. Read compilation/SDK_COMPILATION_PROCESS.md for the complete process and the standard 15-section structure.
2. If ${output_file} already exists, use it as the STRUCTURAL and prose-quality TEMPLATE, then refresh ALL code to v6 and overwrite it.
3. Extract only ${platform_upper}-specific code from the source docs (they are already on v6) and the custom blocks.
4. Cross-check every API name, signature, enum case and default against the SOURCES OF TRUTH below — do not invent or guess.

SOURCES OF TRUTH for v6 (verify against these, in priority order):
- iOS:     ../iOS/MIGRATION-6.0.0.md   and the SDK source under ../iOS/Purchasely/Classes/  (grep to confirm a method is public, not internal/removed)
- Android: ../Android/MIGRATION_V6.md  and the SDK source under ../Android/core/src/main/java/io/purchasely/
- The migration guides under docs/➡️ MIGRATING TO PURCHASELY/migrating-from-sdk-5-to-6/

V6 RULES (critical):
- iOS doc: include ONLY Swift. DO NOT include Objective-C (no longer documented).
- Android doc: include ONLY Kotlin. DO NOT include Java (no longer documented).
- DEFAULT RUNNING MODE IS NOW OBSERVER. The SDK Initialization section MUST prominently state this and show how to set Full explicitly (iOS: .runningMode(.full); Android: .runningMode(PLYRunningMode.Full)) for Purchasely to handle/validate purchases.
- Use the v6 APIs only. The following v5 names are REMOVED/renamed and must NOT appear as usable code:
  iOS:     start(withAPIKey:), setPaywallActionsInterceptor, fetchPresentation, presentationController/productController/planController, closeDisplayedPresentation, controller.PresentationView, PLYPresentationInfo
  Android: setPaywallActionsInterceptor, fetchPresentation, presentationView(...), PLYPresentationProperties, PLYProductViewResult, PaywallObserver, readyToOpenDeeplink, isDeeplinkHandled, subscriptionsFragment, purchaseHistory, intro*/INTRO_*/TRIAL_*
- Use version 6.0.0 wherever a version appears. Android build reqs: Gradle 9.3.0+, Kotlin 2.2.x, JDK 11, minSdk 23, compileSdk 35.

CODE-BLOCK SELECTION:
- Trust the LABEL after the language fence (e.g. swift Swift, kotlin Kotlin), not the highlighter token — some Cordova/Flutter blocks are mislabeled swift/kotlin.

SOURCE DIRECTORIES:
- docs/🚀 Getting Started/sdk-quick-start/ (sdk-installation/, sdk-initialization.md, processing-transactions/, listener-delegate.md, entitlements-management/)
- docs/Onboarding/sdk_initialisation/, sdk_paywall_action_interceptor/, sdk_deeplinks/, sdk_placement/, sdk_asynchronous_display/
- docs/📱 Screens & Paywalls/displaying-screens/
- docs/✈️ GOING FURTHER/
- docs/👤 Users/
- docs/📈 Growth guidances/segmenting-your-user-base/
- custom_blocks/

VERIFICATION (do this before finishing):
- Re-read your generated ${output_file} and confirm every code example matches a real v6 public API in the source of truth.
- Grep the file to confirm NONE of the removed v5 identifiers above remain in code, and that no Objective-C (iOS) / Java (Android) code fences are present.
- Confirm the Table of Contents matches the actual sections.

OUTPUT: (over)write ${output_file}. Then report which sections you produced and the verification result.
EOF

    print_success "Generated prompt file: compile_${platform}_prompt.txt"
}

# Function to compile documentation for a platform
compile_platform() {
    local platform=$1

    print_info "Starting compilation for ${platform}..."

    # Check if already exists in platform/ directory
    if [ -f "$PLATFORM_DIR/${platform}.md" ]; then
        if [ "${FORCE:-0}" != "1" ]; then
            print_warning "platform/${platform}.md already exists. Skipping (re-run with --force to regenerate: './compile_sdk_docs.sh ${platform} --force')."
            return
        fi
        print_warning "platform/${platform}.md exists — --force set: regenerating (the existing file is meant to be overwritten by the compilation)."
    fi

    # Generate prompt file
    generate_prompt "$platform"

    print_info "Prompt file created. To compile, run:"
    echo "    cat compile_${platform}_prompt.txt"
    echo ""
}

# Main script
main() {
    local platform=${1:-}

    # Detect a --force / force flag anywhere in the args (allows regenerating an
    # existing compiled file, e.g. on a major SDK version bump).
    FORCE=0
    for arg in "$@"; do
        if [ "$arg" = "--force" ] || [ "$arg" = "force" ]; then FORCE=1; fi
    done

    echo ""
    print_info "Purchasely SDK Documentation Compiler"
    echo ""

    # Check if SDK_COMPILATION_PROCESS.md exists (in compilation/ folder)
    if [ ! -f "$SCRIPT_DIR/SDK_COMPILATION_PROCESS.md" ]; then
        echo "Error: SDK_COMPILATION_PROCESS.md not found in compilation/!"
        exit 1
    fi

    # Check if CLAUDE.md exists (in root folder)
    if [ ! -f "$ROOT_DIR/CLAUDE.md" ]; then
        echo "Error: CLAUDE.md not found in root directory!"
        exit 1
    fi

    case "$platform" in
        android)
            compile_platform "android"
            ;;
        ios)
            compile_platform "ios"
            ;;
        react-native)
            compile_platform "react-native"
            ;;
        flutter)
            compile_platform "flutter"
            ;;
        cordova)
            compile_platform "cordova"
            ;;
        all)
            print_info "Compiling all platforms..."
            compile_platform "android"
            compile_platform "ios"
            compile_platform "react-native"
            compile_platform "flutter"
            compile_platform "cordova"
            echo ""
            print_success "All prompt files generated!"
            echo ""
            print_info "Next steps:"
            echo "  1. Use these prompts to compile each platform's documentation"
            echo "  2. Or run: ./compile_sdk_docs.sh interactive"
            ;;
        interactive)
            print_info "Interactive mode - Compiling all platforms sequentially..."
            echo ""

            # Create a master instruction file
            cat > "COMPILE_ALL_PLATFORMS.md" << 'EOF'
# Compile All Platform SDKs (target SDK v6.0.0)

Please (re)compile SDK documentation for all platforms following the process in `SDK_COMPILATION_PROCESS.md`. Target SDK version is **6.0.0**. If a `platform/<platform>.md` already exists, use it as the structural/quality template and overwrite it with refreshed v6 content.

## Sources of truth for v6 (verify against these — do not guess)

- iOS: `../iOS/MIGRATION-6.0.0.md` + SDK source `../iOS/Purchasely/Classes/`
- Android: `../Android/MIGRATION_V6.md` + SDK source `../Android/core/src/main/java/io/purchasely/`
- `docs/➡️ MIGRATING TO PURCHASELY/migrating-from-sdk-5-to-6/`

## Platforms to Compile

### 1. Android (android.md)
- Language: **Kotlin only** (Java is no longer documented — do NOT include `java Java` blocks)
- Code identifiers: `kotlin`, `Kotlin`
- v6 specifics: default running mode is **Observer** (set `PLYRunningMode.Full` for purchase handling); `PLYPresentation { }.preload`, `interceptAction<…>`, `PLYPresentationOutcome`, presentation types in `io.purchasely.ext.presentation.*`; deps `io.purchasely:core/google-play/player:6.0.0`, Gradle 9.3.0+, Kotlin 2.2.x

### 2. iOS (ios.md)
- Language: **Swift only** (Objective-C is no longer documented — do NOT include `objectivec` blocks)
- Code identifiers: `swift`, `Swift`
- v6 specifics: default running mode is **`.observer`** (set `.runningMode(.full)` for purchase handling); fluent `Purchasely.apiKey(…)…start { error }`, `PLYPresentationBuilder`, `interceptAction(.x)`, `presentation.swiftUIView`; StoreKit 1 vs 2, CocoaPods/SPM

### 3. React Native (react-native.md)
- Language: JavaScript/TypeScript — code identifiers: `typescript React Native`, `javascript React Native`, `ReactNative`
- Note: the RN/Flutter/Cordova wrappers may still be on the v5 API until their own v6 release — keep their code as found in the sources

### 4. Flutter (flutter.md)
- Language: Dart — code identifiers: `typescript Flutter`, `dart`, `Flutter`

### 5. Cordova (cordova.md)
- Language: JavaScript — code identifiers: `javascript Cordova`, `Cordova`

## Process for Each Platform

1. Read `compilation/SDK_COMPILATION_PROCESS.md` for the complete process
2. Use the standard 15-section structure
3. Extract platform-specific code from source files (trust the LABEL after the fence, not the highlighter token)
4. Cross-check every API/signature/default against the sources of truth above
5. Follow the quality checklist
6. (Over)write the `platform/{platform}.md` file

## Quality Standards

- Match the quality and completeness of the existing compiled docs
- All code must be syntactically correct and use real v6 public APIs only
- No placeholder values except intentional ones
- Consistent formatting throughout
- Complete table of contents matching actual sections
- Verify: no removed v5 identifiers remain in code; no Objective-C (iOS) / Java (Android) fences

Please proceed to compile all platforms.
EOF

            print_success "Created COMPILE_ALL_PLATFORMS.md"
            print_info "This file contains instructions to compile all remaining platforms."
            echo ""
            print_info "To execute, provide this file to Claude Code."
            ;;
        check)
            print_info "Checking compilation status..."
            echo ""

            platforms=("android" "ios" "react-native" "flutter" "cordova")
            for plat in "${platforms[@]}"; do
                if [ -f "$PLATFORM_DIR/${plat}.md" ]; then
                    size=$(wc -l < "$PLATFORM_DIR/${plat}.md")
                    print_success "platform/${plat}.md - COMPLETE (${size} lines)"
                else
                    print_warning "platform/${plat}.md - PENDING"
                fi
            done
            echo ""
            ;;
        clean)
            print_info "Cleaning up generated prompt files..."
            rm -f compile_*_prompt.txt
            rm -f COMPILE_ALL_PLATFORMS.md
            print_success "Cleanup complete"
            ;;
        *)
            echo "Usage: $0 {android|ios|react-native|flutter|cordova|all|interactive|check|clean} [--force]"
            echo ""
            echo "Commands:"
            echo "  android        Generate prompt for Android documentation"
            echo "  ios            Generate prompt for iOS documentation"
            echo "  react-native   Generate prompt for React Native documentation"
            echo "  flutter        Generate prompt for Flutter documentation"
            echo "  cordova        Generate prompt for Cordova documentation"
            echo "  all            Generate prompts for all platforms (android, ios, react-native, flutter, cordova)"
            echo "  interactive    Create master instruction file for all platforms"
            echo "  check          Check compilation status"
            echo "  clean          Remove generated prompt files"
            echo ""
            echo "Options:"
            echo "  --force        Regenerate even if platform/<platform>.md already exists"
            echo "                 (use this to re-compile after an SDK major version bump)"
            echo ""
            echo "Example:"
            echo "  $0 ios"
            echo "  $0 ios --force"
            echo "  $0 all --force"
            echo "  $0 interactive"
            exit 1
            ;;
    esac

    echo ""
}

main "$@"
