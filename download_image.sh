image_name=${1}
file_name="${image_name//\//_}"
file_name="${file_name//\:/-}"
file_name="${file_name}.tar.gz"
echo "This script pull image given as parameter, and dump to file."
echo "Pulling ${image_name}, dumping to ${file_name}."
echo "pull image: ${image_name}"
docker pull ${image_name}
echo "Dumping to file ${image_name} to ${file_name}"
docker save ${image_name} | gzip > ${file_name}
