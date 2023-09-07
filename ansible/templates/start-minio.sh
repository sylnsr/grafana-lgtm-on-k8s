echo "Starting MinIO server"
export MINIO_ROOT_USER={{ minio_root_user }}
export MINIO_ROOT_PASSWORD={{ minio_root_password }}
minio server /mnt/data --console-address :9090 &>/dev/null &