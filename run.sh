path=$(cd `dirname $0`; pwd)

csv=$1
out=$2

echo $path
$path/remote.sh "$path" "$csv" "$out" "$path/rate.sh" "/root/" "rate.sh"
