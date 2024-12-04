logger() {
  local message="$1"
  local type="$2"
  local timestamp="$(date -d @$(date +%s) +'%Y-%m-%d %H:%M:%S')"
  case "$type" in
  "error")
    echo "\e[36m$timestamp\e[m \e[31;1m[ ERROR ]\e[0m - $message"
    ;;
  "debug")
    echo "\e[36m$timestamp\e[m \e[35;1m[ DEBUG ]\e[0m - $message"
    ;;
  "log")
    echo "\e[36m$timestamp\e[m \e[32;1m[ LOG ]\e[0m - $message"
    ;;
  "info")
    echo "\e[36m$timestamp\e[m \e[34;1m[ INFO ]\e[0m - $message"
    ;;
  "warn")
    echo "\e[36m$timestamp\e[m \e[33;1m[ WARN ]\e[0m - $message"
    ;;
  *)
    echo "$timestamp - $message"
    ;;
  esac
}
function node_version {
  # Verifica se estamos em um diretório com package.json
  if [[ -f package.json ]]; then
    # Lê a versão do Node.js do package.json
    local node_version=$(cat package.json | jq -r '.engines.node')
    # Verifica se a versão foi encontrada e se não é "null"
    if [[ -n "$node_version" && "$node_version" != "null" ]]; then
      # Muda para a versão especificada
      nvm use "$node_version" > /dev/null
      logger "Using Node.js version: $node_version" "info"
    else
      nvm use default > /dev/null
      logger "Node.js version not found in package.json, using default version" "warn"
    fi
  fi
}