#!/bin/bash

# GithubActionsでテスト実行するスクリプト
# 使い方: ./test.sh

test() {
    input=("$@")
    output=$(bash math-gcd.sh "${input[@]}" 2>/dev/null)

    if [ $? -eq 0 ]; then
        echo "正常系 - 成功: ${input[*]} => $output"
    else
        echo "正常系 - 失敗: ${input[*]} => '$output'"
    fi
}

test_error() {
    input=("$@")
    output=$(bash math-gcd.sh "${input[@]}" 2>/dev/null)

    if [ $? -ne 0 ]; then
        echo "異常系 - 成功: ${input[*]} => $output"
    else
        echo "異常系 - 失敗: ${input[*]} => $output"
    fi
}

echo "======================"
echo "===== テスト開始 ====="
echo "======================"

echo "--- 正常系のテストを行います ---"

# 正常系
test 2 4
test 123 45
test 555 999

echo "--- 異常系のテストを行います ---"

# 異常系
test_error 2.1 3
test_error 2 3.5
test_error 2.1 3.5
test_error 9
test_error x 6
test_error 5x 6
test_error 2 y
test_error 2 3y
test_error x
test_error   y
test_error 1 y
test_error

echo "======================"
echo "===== テスト終了 ====="
echo "======================"