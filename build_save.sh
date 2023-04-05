image_name="base_image:1.5.0"
file_name="${image_name//\//_}"
file_name="${file_name//\:/-}"
file_name="${file_name}.tar.gz"
echo "This script pull image given as parameter, and dump to file."
echo "build ${image_name}, dumping to ${file_name}."
echo "build image: ${image_name}"
docker build . --tag ${image_name}
echo "Dumping to file ${image_name} to ${file_name}"
docker save ${image_name} | gzip > ${file_name}
