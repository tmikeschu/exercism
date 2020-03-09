main () {
  NAME=${1:-you}
  echo "One for ${NAME}, one for me."
}

main "$@"
