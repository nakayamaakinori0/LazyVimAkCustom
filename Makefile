# Neovim Configuration Makefile

.PHONY: test test-minimal test-keymap test-health clean help

# Default target
all: test

# Run all tests
test:
	@echo "🧪 Running all tests..."
	@./scripts/run_tests.sh all

# Run minimal smoke test
test-minimal:
	@echo "🧪 Running minimal test..."
	@cd $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST)))) && nvim --headless -l tests/test_minimal.lua

# Test keymaps interactively
test-keymap:
	@echo "🎯 Testing keymaps..."
	@./scripts/run_tests.sh keymap

# Run health check
test-health:
	@echo "🩺 Running health check..."
	@./scripts/run_tests.sh health

# Quick test (alias for health)
quick: test-health

# Clean temporary files
clean:
	@echo "🧹 Cleaning temporary files..."
	@rm -f /tmp/keymap_test.lua /tmp/health_check.lua
	@echo "✅ Clean completed"

# Help
help:
	@echo "Neovim Configuration Test Commands:"
	@echo ""
	@echo "  make test         - Run all automated tests"
	@echo "  make test-minimal - Run quick smoke test"
	@echo "  make test-keymap  - Test keymaps interactively"
	@echo "  make test-health  - Run health check"
	@echo "  make quick        - Same as test-health"
	@echo "  make clean        - Clean temporary files"
	@echo "  make help         - Show this help"
	@echo ""
	@echo "Direct script usage:"
	@echo "  ./scripts/run_tests.sh [all|keymap|health|quick]"