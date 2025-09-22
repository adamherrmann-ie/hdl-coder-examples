function matrix_for_each_simulate(fixed_point_en)
%MATRIX_FOR_EACH_SIMULATE Summary of this function goes here
%   Detailed explanation goes here

input_signal                        = randi([0,15],320,4);
matrix_for_each_data_types.input = numerictype('Double');
matrix_for_each_data_types.output = numerictype('Double');

if (fixed_point_en)
    input_signal                        = fi(input_signal,0,4,0);
    matrix_for_each_data_types.input = numerictype(0,4,0);
    matrix_for_each_data_types.output = numerictype(0,16,0);
end

parallelism                         = 32;
latency                             = 5;
signal_length                       = length(input_signal)/parallelism;
padded_input_signal                 = [input_signal; boolean(zeros(parallelism*latency,4))];
padded_signal_length                = length(padded_input_signal)/parallelism;
signal_time_vector                  = 0:1:padded_signal_length-1;
signal_dims                         = parallelism;

% Timeseries Input
input_data_0.signals.values       = reshape(padded_input_signal(:,1),parallelism,[])';
input_data_0.time                 = signal_time_vector;
input_data_0.signals.dimensions   = signal_dims;      

input_data_1.signals.values       = reshape(padded_input_signal(:,2),parallelism,[])';
input_data_1.time                 = signal_time_vector;
input_data_1.signals.dimensions   = signal_dims;      

input_data_2.signals.values       = reshape(padded_input_signal(:,3),parallelism,[])';
input_data_2.time                 = signal_time_vector;
input_data_2.signals.dimensions   = signal_dims;      

input_data_3.signals.values       = reshape(padded_input_signal(:,4),parallelism,[])';
input_data_3.time                 = signal_time_vector;
input_data_3.signals.dimensions   = signal_dims;      

valid_in.signals.dimensions       = 1;
valid_in.time                     = signal_time_vector;
valid_in.signals.values           = [boolean(ones(signal_length,1)); boolean(zeros(latency,1))];   

% Run the simulink
stopTime = (padded_signal_length + latency - 1);
disp("Starting simulink model..."); tic;
simOut = sim('matrix_for_each_wrapper','FastRestart','off','SrcWorkspace','current','ReturnWorkspaceOutputs','on', 'StopTime', sprintf('%d',stopTime), 'SimulationMode','Accelerator');
model_stop_time = toc;
disp("Finished simulink model " + model_stop_time + " seconds");

end

