SRC_DIR=`pwd`
DST_DIR=`pwd`
protoc --proto_path=$SRC_DIR --python_out=$DST_DIR $SRC_DIR/addressbook.proto
