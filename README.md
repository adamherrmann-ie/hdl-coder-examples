# HDL Coder Examples
This repo contains examples for running HDL Coder and HDL Verifier by MathWorks.

- matrix_for_each is a simple example showing the implementation of a simple multiply and add operation appied to a matrix with maximum code reuse across multiple instances.

## Simulating HDL in Verilator and Inspecting Waves

[Verilator](https://www.veripool.org/verilator/) is a cool tool that translates System Verilog into C++, allowing us to simulate the generated HDL code in an easy environment. Verilator also allows us to create waves from the wires in the design.

In verilator_examples is a Dockerfile which will setup your environemnt with the necessary tools to run verilator and inspect the waves.

### Requirements

- [Docker](https://www.docker.com/) - for running the containerized environment
- [VcXsrc](https://vcxsrv.com/) - for opening GUI appliations in Windows

### Launching Container

Ensure your Xwindows server is running by running XLaunch and using the default settings.

Run the following commands in Windows CMD from the verilator_examples directory to build and run the docker container:

``` 
docker build -t verilator-fedora .
docker run -v .\adder:/adder -it verilator-fedora
```

`-v .\adder:/adder` makes the directory `adder` available in the container in the location `/adder`. `-it` opens the container in interactive mode so we get a shell.
To make sure your DISPLAY connection is working. Run `xeyes`, you should see the xeyes application launch and eyes become visible in Windows.

### Running Verilator

You can now open the `adder` exaple in `/adder` and verilate it to create C++:
```
verilator -Wall --cc adder.sv --exe sim_main.cpp --trace
```
Next, we make the C++ into an executable:
```
make -C obj_dir -f Vadder.mk Vadder
```
Now run it and open the generated waves in `gtkwave`:
```
./obj_dir/Vadder
gtkwave waveform.vcd
```