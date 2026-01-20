#!/bin/bash

# open_claude_compiler.sh
# Opens Claude Code sessions to compile SDK documentation
# Usage: ./open_claude_compiler.sh [platform]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

print_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to create instruction file for a platform
create_instruction_file() {
    local platform=$1
    local platform_upper=$(echo "$platform" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    local instruction_file="COMPILE_${platform_upper}_INSTRUCTION.md"
    local platform_display=$(echo "$platform" | tr '[:lower:]' '[:upper:]')

    # Build platform-specific details
    local platform_details=""
    case "$platform" in
        ios)
            platform_details="**Language:** Swift (Objective-C compatible)
**Code Identifiers:** \`swift\`, \`Swift\`, \`objectivec\`, \`Objective-C\`
**Key Features:**
- StoreKit 1 vs StoreKit 2 selection
- CocoaPods and Swift Package Manager installation options
- UIKit/SwiftUI considerations"
            ;;
        react-native)
            platform_details="**Language:** JavaScript/TypeScript
**Code Identifiers:** \`typescript React Native\`, \`javascript React Native\`, \`ReactNative\`
**Key Features:**
- npm/yarn installation
- iOS pod install requirement
- Android gradle configuration
- \`storeKit1\` parameter for iOS
- \`androidStores\` parameter"
            ;;
        flutter)
            platform_details="**Language:** Dart
**Code Identifiers:** \`typescript Flutter\`, \`dart\`, \`Flutter\`
**Key Features:**
- pub.dev installation
- iOS pod install requirement
- Android gradle configuration
- \`storeKit1\` parameter for iOS
- \`androidStores\` parameter"
            ;;
        cordova)
            platform_details="**Language:** JavaScript
**Code Identifiers:** \`javascript Cordova\`, \`Cordova\`
**Key Features:**
- Plugin installation via cordova CLI
- Platform-specific setup for iOS and Android
- config.xml modifications"
            ;;
    esac

    cat > "$instruction_file" << EOF
# Compile ${platform_display} SDK Documentation

**Target Output:** \`${platform}.md\`

---

## Instructions

Follow the process documented in \`SDK_COMPILATION_PROCESS.md\` to create comprehensive ${platform} SDK documentation.

## Reference Files

- **Process Guide:** \`SDK_COMPILATION_PROCESS.md\`
- **Reference Example:** \`android.md\` (already completed)
- **Context:** \`CLAUDE.md\`

## Platform Details

**Platform:** ${platform}

${platform_details}

## Step-by-Step Process

1. **Read the Process Guide**
   - Open and read \`SDK_COMPILATION_PROCESS.md\`
   - Understand the 13-section standard structure
   - Note the platform-specific considerations

2. **Find Source Files**
   - Search for ${platform}-specific documentation
   - Look in directories listed in SDK_COMPILATION_PROCESS.md
   - Extract code blocks with correct language identifiers

3. **Extract Code Examples**
   - Read each source file
   - Extract only ${platform}-specific code blocks
   - Preserve code comments and explanations

4. **Compile Documentation**
   - Follow the standard 13-section structure
   - Use \`android.md\` as a quality reference
   - Ensure completeness and accuracy

5. **Quality Check**
   - Verify all sections have content
   - Check code syntax
   - Ensure consistent formatting
   - Validate links and references

## Standard Structure

Create \`${platform}.md\` with these sections:

1. Requirements
2. Installation
3. SDK Initialization
4. Displaying Paywalls
5. Processing Transactions
6. Paywall Action Interceptor
7. User Identification
8. Subscription Status & Entitlements
9. Custom User Attributes
10. Event Listeners
11. Pre-fetching Screens
12. Deeplinks Management
13. Platform-Specific Features
14. Troubleshooting
15. Additional Resources

## Output Location

\`/Users/kevin/Purchasely/Documentation/${platform}.md\`

---

**Ready to compile? Let's create ${platform}.md following the SDK_COMPILATION_PROCESS.md guidelines.**
EOF

    print_success "Created instruction file: $instruction_file"
}

# Function to open Claude Code with instruction
open_claude_with_instruction() {
    local platform=$1
    local platform_upper=$(echo "$platform" | tr '[:lower:]' '[:upper:]' | tr '-' '_')
    local instruction_file="COMPILE_${platform_upper}_INSTRUCTION.md"

    if [ ! -f "$instruction_file" ]; then
        create_instruction_file "$platform"
    fi

    print_info "Instruction file ready: $instruction_file"
    echo ""
    print_info "To compile ${platform} documentation:"
    echo ""
    echo "  Option 1 - In current Claude session:"
    echo "    cat $instruction_file"
    echo ""
    echo "  Option 2 - New Claude Code session:"
    echo "    claude $SCRIPT_DIR -m \"Please read $instruction_file and compile the ${platform} SDK documentation\""
    echo ""
    echo "  Option 3 - Manual:"
    echo "    1. Open the instruction file: $instruction_file"
    echo "    2. Provide it to Claude Code"
    echo ""
}

# Main function
main() {
    local platform=${1:-}

    echo ""
    print_info "Claude SDK Documentation Compiler - Session Launcher"
    echo ""

    case "$platform" in
        android|ios|react-native|flutter|cordova)
            if [ -f "${platform}.md" ]; then
                print_warning "${platform}.md already exists!"
                read -p "Do you want to recreate it? (y/N): " -n 1 -r
                echo
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Skipping ${platform}"
                    exit 0
                fi
            fi

            create_instruction_file "$platform"
            open_claude_with_instruction "$platform"
            ;;

        all)
            print_info "Creating instruction files for all platforms..."
            echo ""

            platforms=("ios" "react-native" "flutter" "cordova")
            for plat in "${platforms[@]}"; do
                if [ ! -f "${plat}.md" ]; then
                    create_instruction_file "$plat"
                else
                    print_warning "${plat}.md already exists - skipping"
                fi
            done

            echo ""
            print_success "All instruction files created!"
            echo ""
            print_info "To compile all platforms, you can:"
            echo "  1. Run this script for each platform individually"
            echo "  2. Use the COMPILE_ALL_PLATFORMS.md file"
            echo "  3. Provide the instruction files to Claude Code one by one"
            ;;

        interactive)
            print_info "Interactive mode - Sequential compilation"
            echo ""

            # Create master instruction
            cat > "COMPILE_ALL_SEQUENTIAL.md" << 'EOF'
# Sequential SDK Documentation Compilation

Compile SDK documentation for all remaining platforms in sequence.

## Platforms to Compile

Please compile the following in order:

1. **ios.md** - iOS/Swift SDK
2. **react-native.md** - React Native SDK
3. **flutter.md** - Flutter SDK
4. **cordova.md** - Cordova SDK

## Process

For each platform:

1. Read the platform-specific instruction file (COMPILE_{PLATFORM}_INSTRUCTION.md)
2. Follow the SDK_COMPILATION_PROCESS.md guidelines
3. Use android.md as a quality reference
4. Create the {platform}.md file
5. Mark the task as complete before moving to the next platform

## Quality Standards

Match the quality, completeness, and structure of android.md for each platform.

---

Let's start with iOS. Please read COMPILE_IOS_INSTRUCTION.md and proceed.
EOF

            # Create all instruction files
            platforms=("ios" "react-native" "flutter" "cordova")
            for plat in "${platforms[@]}"; do
                create_instruction_file "$plat"
            done

            print_success "Created COMPILE_ALL_SEQUENTIAL.md and all instruction files"
            echo ""
            print_info "To start sequential compilation:"
            echo "    cat COMPILE_ALL_SEQUENTIAL.md"
            ;;

        *)
            echo "Usage: $0 {android|ios|react-native|flutter|cordova|all|interactive}"
            echo ""
            echo "Commands:"
            echo "  ios            Create instruction file for iOS documentation"
            echo "  react-native   Create instruction file for React Native documentation"
            echo "  flutter        Create instruction file for Flutter documentation"
            echo "  cordova        Create instruction file for Cordova documentation"
            echo "  all            Create instruction files for all platforms"
            echo "  interactive    Create sequential compilation master file"
            echo ""
            echo "The script will create instruction files that can be provided to Claude Code."
            exit 1
            ;;
    esac

    echo ""
}

main "$@"
