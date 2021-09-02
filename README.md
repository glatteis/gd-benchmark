# gd-benchmark scripts

This is some documentation of the gd-benchmark scripts that can run parameter synthesis
benchmarks on Gradient Descent in storm-pars, and QCQP and PSO in Prophesy.

## Generating benchmarks
One can generate benchmarks with the `generate_commands` script. The benchmarks are in
`testcases-paper`, `testcases-paper-tenpercent` or `testcases-paper-twentypercent` and need to be
passed to `--folder`. For example:

	python3 generate_commands.py --folder testcases-paper 

This will generate DTMCs from the POMDP files using `storm-pomdp`. You can look inside these
folders, they are made of models and JSON configs for the benchmarks and should be relatively
readable. To invoke the test scenarios from the paper, you need to use `global-override` with the
supplied json files, like this:

	python3 generate_commands.py --folder testcases-paper --global_override all_gd_methods.json

Invoking this script creates a `slurm_commands_*.sh` and `manual_commands_*.sh` file and modifies
the `hpc.sh` file to invoke the slurm commands. On the VM, look into the manual commands to see
which benchmark you want to re-create. You can also run the entire manual command file, but this will
take a long time.

Now, you probably have some ouput files. From this, you can generate a CSV file that contains the
performance statistics using `process_output.csv`. Just put the outputs into the arguments:

	python3 process_output *.out

This will create an `out_*.csv*` file. The data csvs from the paper are in the `vmcai-paper-bench/` folder.
From this, you can generate scatter plots using `csv_to_scatter.py`, look into
`vmcai-paper-bench/paper_plots.sh` for the commands that are used to generate the plots from the
paper.
