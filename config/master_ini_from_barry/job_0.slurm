#!/bin/bash -l
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH --job-name=bgMain0
#SBATCH -o /dev/null

conda activate glob

job_1=$(sbatch --parsable                                                                                                       \
               --output=/dev/null                                                                                               \
               --export=ALL                                                                                                     \
               --ntasks=1                                                                                                       \
               --cpus-per-task=16                                                                                               \
               --time=$TIME_LIMIT                                                                                               \
               --job-name=bg0_1                                                                                                 \
               --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                  \
                        python deterministic_runner_with_arguments.py                                                           \
                                $INI_FILE_ONE                                                                                   \
                                -mod $MAIN_OUTPUT_DIR/clone_0__2_11/1979_1994                                                   \
                                -clonemap 0__2_11                                                                               \
                                -sd $start_one                                                                                  \
                                -ed $end_one                                                                                    \
                                -clone_connections None                                                                         \
                                -misd $SPINUP_DIRECTORY                                                                         \
                                -dfis 1978-12-31                                                                                \
                                -num_of_sp_years $NUMBER_OF_SPINUP_YEARS & wait")

job_2=$(sbatch --parsable                                                                                                      \
               --export=ALL                                                                                                    \
               --ntasks=1                                                                                                      \
               --output=/dev/null                                                                                               \
               --cpus-per-task=16                                                                                              \
               --time=$TIME_LIMIT                                                                                              \
               --job-name=bg0_2                                                                                                \
               --dependency=afterok:${job_1}                                                                                    \
               --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                 \
                        python deterministic_runner_with_arguments.py                                                          \
                                $INI_FILE_ONE                                                                                  \
                                -mod $MAIN_OUTPUT_DIR/clone_0__2/1979_1994                                                     \
                                -clonemap 0__2                                                                                 \
                                -sd $start_one                                                                                 \
                                -ed $end_one                                                                                   \
                                -clone_connections $MAIN_OUTPUT_DIR/clone_0__2_11/1979_1994/netcdf/discharge_dailyTot_output.nc\
                                -misd $SPINUP_DIRECTORY                                                                        \
                                -dfis 1978-12-31                                                                               \
                                -num_of_sp_years $NUMBER_OF_SPINUP_YEARS & wait")

# job_3=$(sbatch --parsable                                                                                                       \
#                --output=/dev/null                                                                                               \
#                --export=ALL                                                                                                     \
#                --ntasks=1                                                                                                       \
#                --cpus-per-task=16                                                                                               \
#                --time=$TIME_LIMIT                                                                                               \
#                --job-name=bg0_3                                                                                                 \
#                --dependency=afterok:${job_1}                                                                                    \
#                --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                  \
#                         python deterministic_runner_with_arguments.py                                                           \
#                                 $INI_FILE_FOLLOWON                                                                              \
#                                 -mod $MAIN_OUTPUT_DIR/clone_0__2_11/1995_2009                                                   \
#                                 -clonemap 0__2_11                                                                               \
#                                 -sd $start_two                                                                                  \
#                                 -ed $end_two                                                                                    \
#                                 -clone_connections None                                                                         \
#                                 -misd $MAIN_OUTPUT_DIR/clone_0__2_11/1979_1994/states                                           \
#                                 -dfis 1994-12-31                                                                                \
#                                 -num_of_sp_years 0 & wait")
# job_4=$(sbatch --parsable                                                                                                       \
#                --output=/dev/null                                                                                               \
#                --export=ALL                                                                                                     \
#                --ntasks=1                                                                                                       \
#                --cpus-per-task=16                                                                                               \
#                --time=$TIME_LIMIT                                                                                               \
#                --job-name=bg0_4                                                                                                 \
#                --dependency=afterok:${job_2},afterok:${job_3}                                                                   \
#                --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                  \
#                         python deterministic_runner_with_arguments.py                                                           \
#                                 $INI_FILE_FOLLOWON                                                                              \
#                                 -mod $MAIN_OUTPUT_DIR/clone_0__2/1995_2009                                                      \
#                                 -clonemap 0__2                                                                                  \
#                                 -sd $start_two                                                                                  \
#                                 -ed $end_two                                                                                    \
#                                 -clone_connections $MAIN_OUTPUT_DIR/clone_0__2_11/1995_2009/netcdf/discharge_dailyTot_output.nc \
#                                 -misd $MAIN_OUTPUT_DIR/clone_0__2/1979_1994/states                                              \
#                                 -dfis 1994-12-31                                                                                \
#                                 -num_of_sp_years 0 & wait")

# job_5=$(sbatch --parsable                                                                                                       \
#                --output=/dev/null                                                                                               \
#                --export=ALL                                                                                                     \
#                --ntasks=1                                                                                                       \
#                --cpus-per-task=16                                                                                               \
#                --time=$TIME_LIMIT                                                                                               \
#                --job-name=bg0_5                                                                                                 \
#                --dependency=afterok:${job_3}                                                                                    \
#                --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                  \
#                         python deterministic_runner_with_arguments.py                                                           \
#                                 $INI_FILE_FOLLOWON                                                                              \
#                                 -mod $MAIN_OUTPUT_DIR/clone_0__2_11/2010_2019                                                   \
#                                 -clonemap 0__2_11                                                                               \
#                                 -sd $start_three                                                                                \
#                                 -ed $end_three                                                                                  \
#                                 -clone_connections None                                                                         \
#                                 -misd $MAIN_OUTPUT_DIR/clone_0__2_11/1995_2009/states                                           \
#                                 -dfis 2009-12-31                                                                                \
#                                 -num_of_sp_years 0 & wait")

# job_6=$(sbatch --parsable                                                                                                       \
#                --output=/dev/null                                                                                               \
#                --export=ALL                                                                                                     \
#                --ntasks=1                                                                                                       \
#                --cpus-per-task=16                                                                                               \
#                --time=$TIME_LIMIT                                                                                               \
#                --job-name=bg0_6                                                                                                 \
#                --dependency=afterok:${job_4},afterok:${job_5}                                                                   \
#                --wrap="export PCRASTER_NR_WORKER_THREADS=16 &&                                                                  \
#                         python deterministic_runner_with_arguments.py                                                           \
#                                 $INI_FILE_FOLLOWON                                                                              \
#                                 -mod $MAIN_OUTPUT_DIR/clone_0__2/2010_2019                                                      \
#                                 -clonemap 0__2                                                                                  \
#                                 -sd $start_three                                                                                \
#                                 -ed $end_three                                                                                  \
#                                 -clone_connections $MAIN_OUTPUT_DIR/clone_0__2_11/2010_2019/netcdf/discharge_dailyTot_output.nc \
#                                 -misd $MAIN_OUTPUT_DIR/clone_0__2/1995_2009/states                                              \
#                                 -dfis 2009-12-31                                                                                \
#                                 -num_of_sp_years 0 & wait")