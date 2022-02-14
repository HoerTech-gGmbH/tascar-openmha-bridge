#/bin/sh
FILE=$(mktemp).cc
cat > $FILE <<EOF
#include <openmha/mha_algo_comm.hh>
MHAKernel::algo_comm_class_t ac;
EOF
c++ -c ${FILE} -o ${FILE}.o >/dev/null 2>&1 && echo "-DMHAOLDACIF"
