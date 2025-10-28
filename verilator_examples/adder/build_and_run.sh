verilator -Wall --cc adder.sv --exe sim_main.cpp --trace
make -C obj_dir -f Vadder.mk Vadder
./obj_dir/Vadder
