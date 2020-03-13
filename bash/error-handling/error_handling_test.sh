#!/usr/bin/env bash

# local version: 0.0.1

@test "correct arguments" {
  run bash error_handling.sh Alice

  [[ $status -eq 0 ]]
  [[ $output = "Hello, Alice" ]]
}

@test "one long argument" {
  run bash error_handling.sh "Alice and Bob"

  [[ $status -eq 0 ]]
  [[ $output = "Hello, Alice and Bob" ]]
}

@test "incorrect arguments" {
  run bash error_handling.sh Alice Bob

  [[ $status -eq 1 ]]
  [[ $output = "Usage: error_handling.sh <person>" ]]
}

@test "print usage banner with no value given" {
  run bash error_handling.sh

  [[ $status -eq 1 ]]
  [[ $output = "Usage: error_handling.sh <person>" ]]
}

@test "empty argument" {
  run bash error_handling.sh ""

  [[ $status -eq 0 ]]
  [[ $output = "Hello, " ]]
}
