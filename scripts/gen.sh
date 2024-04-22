#!/bin/bash
# USAGE: gen.sh PATH(s)
# PATH: project path which contains a proto directory and
#   a .proto named after the project (eg: blog, blog.proto)
#   and optionally some other .proto files

argc=$#
argv=("$@")

for (( j = 0; j < argc; ++j )); do
    project_dir="${argv[j]}"
    proto_dir="${project_dir}/proto"
    proto_file="${project_dir}.proto"

    # Generate gRPC and Protobuf code for ${PROJECT}/${PROJECT}.proto
    # (eg: greet/greet.proto)
    ./node_modules/.bin/grpc_tools_node_protoc -I "${proto_dir}"                                   \
        --js_out=import_style=commonjs:"${proto_dir}"                            \
        --grpc_out=grpc_js:"${proto_dir}"                                        \
        "${proto_dir}/${proto_file}"

    # Generate only Protobuf code for all the other .proto files (if any)
    # (eg: calculator/sum.proto)
    find "${proto_dir}" -type f -name "*.proto" -not -path "${proto_dir}/${proto_file}" | while read -r file; do
        ./node_modules/.bin/grpc_tools_node_protoc -I "${proto_dir}"                                   \
            --js_out=import_style=commonjs:"${proto_dir}"                            \
            "$file"
    done
done