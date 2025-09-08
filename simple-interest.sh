#!/usr/bin/env bash
# simple-interest.sh - Calcula juros simples: J = (P * R * T) / 100
# Uso:
#   ./simple-interest.sh <principal> <taxa_ao_ano_percentual> <tempo_em_anos>
# Exemplo:
#   ./simple-interest.sh 1000 5 2   -> O juros simples é: 100

set -euo pipefail

usage() {
  echo "Uso: $0 <principal> <taxa_percentual> <tempo>"
  echo "Ex.: $0 1000 5 2"
  exit 1
}

# Ajuda
if [[ "${1-}" == "-h" || "${1-}" == "--help" ]]; then
  usage
fi

# Verificação de argumentos
if [[ $# -ne 3 ]]; then
  usage
fi

P="$1"
R="$2"
T="$3"

# Validação simples: números (inteiros ou decimais com ponto)
num_re='^([0-9]+([.][0-9]+)?)$'
if ! [[ $P =~ $num_re && $R =~ $num_re && $T =~ $num_re ]]; then
  echo "Erro: use números válidos (ex.: 1000 5 2 ou 1500.50 7.5 1.5)." >&2
  exit 2
fi

# Cálculo com awk para suportar decimais
SI=$(awk -v p="$P" -v r="$R" -v t="$T" 'BEGIN { printf("%.10g", (p * r * t) / 100) }')

echo "O juros simples é: $SI"
