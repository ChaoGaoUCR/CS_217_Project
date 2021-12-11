count=10
for i in $(seq $count); do
    ./nccl-tests/build/all_reduce_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/all_gather_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/alltoall_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/gather_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/reduce_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/scatter_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/broadcast_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/hypercube_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/reduce_scatter_perf -b 8 -e 256M -f 2 -g 4
done

for i in $(seq $count); do
    ./nccl-tests/build/sendrecv_perf -b 8 -e 256M -f 2 -g 4
done