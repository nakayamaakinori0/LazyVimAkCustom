#!/bin/bash

# Neovim Configuration Test Runner
# This script runs tests for Neovim configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"
TEST_DIR="$CONFIG_DIR/tests"

echo -e "${BLUE}🧪 Neovim Configuration Test Runner${NC}"
echo -e "${BLUE}====================================${NC}"
echo ""

# Check if nvim is available
if ! command -v nvim &> /dev/null; then
    echo -e "${RED}❌ Neovim not found. Please install Neovim first.${NC}"
    exit 1
fi

# Check if test directory exists
if [ ! -d "$TEST_DIR" ]; then
    echo -e "${RED}❌ Test directory not found: $TEST_DIR${NC}"
    exit 1
fi

# Function to run a test file
run_test() {
    local test_file="$1"
    local test_name="$(basename "$test_file" .lua)"
    
    echo -e "${YELLOW}🏃 Running $test_name...${NC}"
    
    # Run test (with timeout if available)
    if command -v timeout &> /dev/null; then
        if timeout 30s nvim --headless -l "$test_file" 2>&1; then
            echo -e "${GREEN}✅ $test_name completed${NC}"
            return 0
        else
            local exit_code=$?
            if [ $exit_code -eq 124 ]; then
                echo -e "${RED}❌ $test_name timed out${NC}"
            else
                echo -e "${RED}❌ $test_name failed with exit code $exit_code${NC}"
            fi
            return $exit_code
        fi
    else
        # No timeout command available (macOS), run without timeout
        if nvim --headless -l "$test_file" 2>&1; then
            echo -e "${GREEN}✅ $test_name completed${NC}"
            return 0
        else
            local exit_code=$?
            echo -e "${RED}❌ $test_name failed with exit code $exit_code${NC}"
            return $exit_code
        fi
    fi
}

# Function to run keymap tests interactively
run_keymap_test() {
    echo -e "${YELLOW}🎯 Testing keymaps interactively...${NC}"
    
    cat << 'EOF' > /tmp/keymap_test.lua
-- Interactive keymap test
print("🎯 Interactive Keymap Test")
print("==========================")
print("")

-- Create test windows
vim.cmd('vsplit')
vim.cmd('split')

print("Created test windows. Total windows: " .. vim.fn.winnr('$'))
print("Current window: " .. vim.fn.winnr())
print("")
print("Testing window navigation...")

-- Test navigation
local tests = {
    {key = '<C-h>', desc = 'left'},
    {key = '<C-j>', desc = 'down'},
    {key = '<C-k>', desc = 'up'},
    {key = '<C-l>', desc = 'right'}
}

for _, test in ipairs(tests) do
    local before = vim.fn.winnr()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(test.key, true, false, true), 'x', false)
    vim.cmd('redraw')
    local after = vim.fn.winnr()
    print(string.format("%s (%s): window %d -> %d", test.key, test.desc, before, after))
end

print("")
print("✅ Keymap test completed. Press any key to exit...")
vim.fn.getchar()
vim.cmd('qa!')
EOF

    nvim -l /tmp/keymap_test.lua
    rm -f /tmp/keymap_test.lua
}

# Function to run quick health check
run_health_check() {
    echo -e "${YELLOW}🩺 Running health check...${NC}"
    
    cat << 'EOF' > /tmp/health_check.lua
print("🩺 Neovim Configuration Health Check")
print("====================================")

local checks = {
    {
        name = "Leader key",
        check = function() return vim.g.mapleader == " " end,
        fix = "Set vim.g.mapleader = ' ' in options.lua"
    },
    {
        name = "Basic options",
        check = function() 
            return vim.opt.number:get() and vim.opt.relativenumber:get() 
        end,
        fix = "Check options.lua for basic vim options"
    },
    {
        name = "Lazy.nvim",
        check = function()
            local ok, _ = pcall(require, 'lazy')
            return ok
        end,
        fix = "Check if lazy.nvim is properly installed"
    },
    {
        name = "Window navigation",
        check = function()
            return vim.fn.maparg('<C-h>', 'n') ~= ''
        end,
        fix = "Check window navigation keymaps in init.lua"
    }
}

local all_passed = true

for _, check in ipairs(checks) do
    local ok, result = pcall(check.check)
    if ok and result then
        print("✅ " .. check.name)
    else
        print("❌ " .. check.name .. " - " .. check.fix)
        all_passed = false
    end
end

print("")
if all_passed then
    print("🎉 All health checks passed!")
else
    print("⚠️  Some health checks failed. See suggestions above.")
end

vim.cmd('qa!')
EOF

    nvim --headless -l /tmp/health_check.lua
    rm -f /tmp/health_check.lua
}

# Main execution
case "${1:-all}" in
    "all")
        echo -e "${BLUE}Running all tests...${NC}"
        echo ""
        
        failed_tests=0
        total_tests=0
        
        # Run all test files
        for test_file in "$TEST_DIR"/*.lua; do
            if [ -f "$test_file" ]; then
                total_tests=$((total_tests + 1))
                if ! run_test "$test_file"; then
                    failed_tests=$((failed_tests + 1))
                fi
                echo ""
            fi
        done
        
        # Summary
        echo -e "${BLUE}Summary:${NC}"
        echo "Total tests: $total_tests"
        echo "Failed tests: $failed_tests"
        
        if [ $failed_tests -eq 0 ]; then
            echo -e "${GREEN}🎉 All tests passed!${NC}"
            exit 0
        else
            echo -e "${RED}❌ $failed_tests test(s) failed${NC}"
            exit 1
        fi
        ;;
    "keymap")
        run_keymap_test
        ;;
    "health")
        run_health_check
        ;;
    "quick")
        echo -e "${BLUE}Running quick health check...${NC}"
        run_health_check
        ;;
    *)
        echo "Usage: $0 [all|keymap|health|quick]"
        echo ""
        echo "Commands:"
        echo "  all     - Run all automated tests (default)"
        echo "  keymap  - Test keymaps interactively"
        echo "  health  - Run health check"
        echo "  quick   - Same as health"
        echo ""
        exit 1
        ;;
esac