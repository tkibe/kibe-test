#!/bin/bash

# 最大公約数を計算するスクリプト
# 使い方: ./math-gcd.sh <数値1> <数値2>

# 最大公約数の計算
math_gcd() {
    local int_x="$1"
    local int_y="$2"
    local temp

    # $int_xが$int_yより小さい場合、入れ替える
    if [ "$int_x" -lt "$int_y" ]; then
        temp="$int_x"
        int_x="$int_y"
        int_y="$temp"
    fi

    # $int_yが0になるまで割り算を繰り返す
    while [ "$int_y" -ne 0 ]; do
        temp="$int_y"
        int_y=$((int_x % int_y))
        int_x="$temp"
    done

    echo "$int_x"
}

# 引数の数チェック
if [ $# -ne 2 ]; then
    echo "引数の数が不正です。2つの数値を指定してください。"
    exit 1
fi

# 数値チェック
if ! [[ "$1" =~ ^[0-9]+$ ]] || ! [[ "$2" =~ ^[0-9]+$ ]]; then
    echo "引数は正の整数である必要があります。"
    exit 1
fi

# 極端に大きな数字のチェック
MAX_INT=$(echo "2^63-1" | bc)
if [ $(echo "$1 > $MAX_INT" | bc) -eq 1 ] || [ $(echo "$2 > $MAX_INT" | bc) -eq 1 ]; then
    echo "${MAX_INT}以下の正の整数を指定してください。"
    exit 1
fi

# 0チェック
if [ "$1" -eq 0 ] || [ "$2" -eq 0 ]; then
    echo "0は無効な入力です。正の整数を指定してください。"
    exit 1
fi

# 最大公約数の計算
result=$(math_gcd "$1" "$2")

# 結果の出力
echo "${1} と ${2} の最大公約数は ${result} です"