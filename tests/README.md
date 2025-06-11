# Neovim Configuration Tests

This directory contains automated tests for the Neovim configuration.

## Test Files

- **`test_minimal.lua`** - Quick smoke test for essential functionality
- **`test_config.lua`** - Comprehensive test suite for all configuration aspects

## Running Tests

### Using Make (Recommended)

```bash
# Run all tests
make test

# Run quick smoke test
make test-minimal

# Test keymaps interactively
make test-keymap

# Run health check
make test-health

# Show help
make help
```

### Using Scripts Directly

```bash
# Run all tests
./scripts/run_tests.sh all

# Run specific test types
./scripts/run_tests.sh keymap
./scripts/run_tests.sh health
```

### Manual Test Execution

```bash
# Run individual test files
nvim --headless -l tests/test_minimal.lua
nvim --headless -l tests/test_config.lua
```

## Test Categories

### Essential Tests (test_minimal.lua)
- ✅ Window navigation keymaps (`<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`)
- ✅ Custom keymaps (`jj`, `H`, `L`)
- ✅ Basic vim options (line numbers, tabs, etc.)
- ✅ Plugin manager loading
- ✅ Window operations

### Comprehensive Tests (test_config.lua)
- ✅ All essential tests
- ✅ Plugin configuration verification
- ✅ LSP configuration
- ✅ Autocommands
- ✅ Custom settings (PHP LSP, etc.)

## Adding New Tests

To add a new test:

1. **For quick checks**: Add to `test_minimal.lua`
2. **For comprehensive checks**: Add to `test_config.lua`
3. **For new test files**: Create `test_*.lua` and they'll be auto-discovered

### Test Template

```lua
-- Load configuration if not already loaded
if not vim.g.mapleader then
  local config_path = vim.fn.stdpath('config')
  dofile(config_path .. '/init.lua')
end

local function assert_true(condition, message)
  if not condition then
    error(message or "Assertion failed")
  end
end

-- Your test code here
print("🧪 Testing something...")
assert_true(some_condition, "Should be true")
print("✅ Test passed")

vim.cmd('qa!')
```

## Test-Driven Development Workflow

1. **Write a failing test** for the new feature
2. **Run the test** to confirm it fails
3. **Implement the feature** to make the test pass
4. **Run all tests** to ensure no regressions
5. **Refactor** if needed while keeping tests green

Example workflow:
```bash
# 1. Add test for new keymap
echo "assert_keymap_exists('n', '<leader>foo', 'New keymap missing')" >> tests/test_minimal.lua

# 2. Run test (should fail)
make test-minimal

# 3. Add keymap to config
echo "vim.keymap.set('n', '<leader>foo', '<cmd>echo \"foo\"<cr>')" >> lua/config/keymaps.lua

# 4. Run test again (should pass)
make test-minimal

# 5. Run all tests
make test
```

## Continuous Integration

These tests can be integrated into CI/CD pipelines:

```bash
# Exit with proper codes for CI
if make test; then
  echo "✅ All tests passed"
  exit 0
else
  echo "❌ Tests failed"
  exit 1
fi
```

## Troubleshooting

### Common Issues

1. **"module not found" errors**: Plugins might not be fully loaded
2. **Keymap missing**: Check if keymaps are set in the right files
3. **Permission errors**: Ensure scripts are executable (`chmod +x scripts/run_tests.sh`)

### Debug Mode

For more verbose output:
```bash
# Run with debug info
nvim -V1 --headless -l tests/test_minimal.lua
```