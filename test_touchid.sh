#!/bin/bash

# Test script for Touch ID functionality
echo "=== confirm-pam Touch ID Test Suite ==="
echo

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test 1: Authentication Success
echo "Test 1: Authentication Success"
echo "Please authenticate with Touch ID when prompted..."
./target/release/confirm-pam "Test 1: Please authenticate with Touch ID"
EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✅ Test 1 PASSED: Authentication successful${NC}"
elif [ $EXIT_CODE -eq 1 ]; then
    echo -e "${YELLOW}⚠️  Test 1: User cancelled (this is also a valid outcome)${NC}"
else
    echo -e "${RED}❌ Test 1 FAILED: Unexpected exit code $EXIT_CODE${NC}"
fi
echo

# Test 2: User Cancellation
echo "Test 2: User Cancellation"
echo "Please CANCEL the Touch ID prompt when it appears..."
./target/release/confirm-pam "Test 2: Please CANCEL this Touch ID prompt"
EXIT_CODE=$?
if [ $EXIT_CODE -eq 1 ]; then
    echo -e "${GREEN}✅ Test 2 PASSED: Cancellation detected correctly${NC}"
elif [ $EXIT_CODE -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Test 2: User authenticated instead of cancelling${NC}"
else
    echo -e "${RED}❌ Test 2 FAILED: Unexpected exit code $EXIT_CODE${NC}"
fi
echo

# Test 3: Multiple Sequential Authentications
echo "Test 3: Multiple Sequential Authentications"
echo "You will be prompted 3 times. Please authenticate all of them..."
SUCCESS_COUNT=0
for i in 1 2 3; do
    ./target/release/confirm-pam "Test 3: Authentication $i of 3"
    if [ $? -eq 0 ]; then
        ((SUCCESS_COUNT++))
    fi
done
echo -e "${GREEN}✅ Successfully authenticated $SUCCESS_COUNT out of 3 times${NC}"
echo

# Test 4: Special Characters
echo "Test 4: Special Characters in Message"
./target/release/confirm-pam "Test 4: 日本語 🔐 \"quotes\" 'apostrophe'"
EXIT_CODE=$?
if [ $EXIT_CODE -eq 0 ] || [ $EXIT_CODE -eq 1 ]; then
    echo -e "${GREEN}✅ Test 4 PASSED: Special characters handled correctly${NC}"
else
    echo -e "${RED}❌ Test 4 FAILED: Special characters caused an error${NC}"
fi
echo

echo "=== Test Suite Complete ===""