clc;
clear all;

%% Setup Model
input_signal                        = fi(randi([0,15],320,4),0,4,0);
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

matrix_for_each_data_types.output = numerictype(0,16,0);

%% Begin HDL Generation
top_level_block = 'matrix_for_each_wrapper';

use_mref = false;

proj = currentProject;
rtl_directory = regexprep(proj.ProjectStartupFolder, 'work$', 'rtl');

if (use_mref)
    full_hierarchical_path   = 'matrix_for_each_wrapper/matrix_for_each_top_mref';
    block_name               = 'matrix_for_each_top_mref';
else
    full_hierarchical_path   = 'matrix_for_each_wrapper/matrix_for_each_top_sref';
    block_name               = 'matrix_for_each_top_sref';
end

module_prefix            = 'matrix_foreach_';
reset_input_port         = 'i_rstn';
clock_input_port         = 'i_clk';

% Load the Model
load_system(top_level_block);

% Restore the Model to default HDL parameters
hdlrestoreparams(full_hierarchical_path);

current_time = datetime('now');
date_time_string = sprintf('%s_', datetime(current_time, 'Format', 'yyMMdd_HHmmss'));
target_directory_string = sprintf('%s%s', date_time_string, block_name);

% Model HDL Parameters
hdlset_param(top_level_block,'TargetLanguage','SystemVerilog');              % https://uk.mathworks.com/help/hdlcoder/ug/target.html#buiuh3k-20
hdlset_param(top_level_block,'Traceability','on');                           % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-40
hdlset_param(top_level_block,'PreserveDesignDelays','on');                   % https://uk.mathworks.com/help/hdlcoder/ug/pipelining-parameters.html#bu_om9f-1
hdlset_param(top_level_block,'ResourceReport','on');                         % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-42
hdlset_param(top_level_block,'DeleteUnusedPorts','off');                     % https://uk.mathworks.com/help/hdlcoder/ug/general-optimization-parameters.html#mw_f7b18e22-cd9f-459b-9db9-7a076aa75a2d
hdlset_param(top_level_block,'OptimizationReport','on');                     % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-44
hdlset_param(top_level_block,'ResetType','Asynchronous');                    % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-60
hdlset_param(top_level_block,'ResetAssertedLevel','active-low');             % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-62
hdlset_param(top_level_block,'ClockInputPort',clock_input_port);         % https://uk.mathworks.com/help/hdlcoder/ug/clock-and-timing-controller-settings.html#buiuh3k-64
hdlset_param(top_level_block,'ClockInputs','Single');                        % https://uk.mathworks.com/help/hdlcoder/ug/clock-and-timing-controller-settings.html#buiuh3k-78
hdlset_param(top_level_block,'ClockEnableInputPort','clken_INCORRECT');           % https://uk.mathworks.com/help/hdlcoder/ug/clock-enable-settings.html#buiuh3k-68
hdlset_param(top_level_block,'MinimizeClockEnables','on');                   % https://uk.mathworks.com/help/hdlcoder/ug/minimize-clock-enables-and-reset-signals.html
hdlset_param(top_level_block,'ResetInputPort',reset_input_port);            % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-73
hdlset_param(top_level_block,'UserComment','(c) Adam Herrmann');             % https://uk.mathworks.com/help/hdlcoder/ug/comment-in-header.html
hdlset_param(top_level_block,'BlockGenerateLabel','_gen');                   % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_53c144bf-ca0b-4336-a223-4726c5b26dfb
hdlset_param(top_level_block,'InstanceGenerateLabel','_gen');                % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_54959ae3-fe60-42c4-bae8-5e6f76f24f44
hdlset_param(top_level_block,'InstancePostfix','');                          % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_9d7a2ae6-6c81-46a4-8e68-ec763336396b
hdlset_param(top_level_block,'InstancePrefix','u_');                         % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_943198bc-ed5a-4cc6-884b-398c7756d1a8
hdlset_param(top_level_block,'ModulePrefix',module_prefix);                          % https://uk.mathworks.com/help/hdlcoder/ref/makehdl.html (search for moduleprefix)
hdlset_param(top_level_block,'SubsystemReuse', 'Atomic and Virtual');        
hdlset_param(top_level_block,'VectorPrefix','vec_');                         % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_d78e159b-8559-4ab2-ac4a-714fa92dfdad
hdlset_param(top_level_block,'UseAggregatesForConst','off');                 % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-constants-and-matlab-function-blocks.html#buiuh3k-192
hdlset_param(top_level_block,'InitializeBlockRAM','on');                     % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-rams.html#buiuh3k-217
hdlset_param(top_level_block,'RAMArchitecture','WithClockEnable');           % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-rams.html#buiuh3k-219
hdlset_param(top_level_block,'NoResetInitializationMode','None');            % https://uk.mathworks.com/help/hdlcoder/ug/no-reset-registers-initialization.html
hdlset_param(top_level_block,'MinimizeIntermediateSignals','on');           % https://uk.mathworks.com/help/hdlcoder/ug/rtl-style.html#buiuh3k-209
hdlset_param(top_level_block,'MaskParameterAsGeneric','off');                % https://uk.mathworks.com/help/hdlcoder/ug/rtl-style.html#buiuh3k-215
hdlset_param(top_level_block,'SafeZeroConcat','on');                         % https://uk.mathworks.com/help/hdlcoder/ug/rtl-annotations.html#buiuh3k-203
hdlset_param(top_level_block,'CustomFileHeaderComment','');                  % https://uk.mathworks.com/help/hdlcoder/ug/file-comment-customization.html#mw_17fc13e9-9712-4bb2-a001-7597e41e7a1f
hdlset_param(top_level_block,'DateComment','on');                            % https://uk.mathworks.com/help/hdlcoder/ug/rtl-annotations.html
hdlset_param(top_level_block,'RequirementComments','on');                    % https://uk.mathworks.com/help/hdlcoder/ug/file-comment-customization.html#buiuh3k-211
hdlset_param(top_level_block,'GenerateValidationModel','off');               % https://uk.mathworks.com/help/hdlcoder/ug/model-generation-for-hdl-code.html#buiuh3k-35
hdlset_param(top_level_block,'LayoutStyle','None');                          % https://uk.mathworks.com/help/hdlcoder/ug/naming-options.html#mw_78d763a5-1a29-46a4-8d3c-910004fd81eb
hdlset_param(top_level_block,'AutoRoute','off');                             % https://uk.mathworks.com/help/hdlcoder/ug/naming-options.html#mw_8a49f8bf-5fe2-4314-86c2-e02fdeeb1d4c
hdlset_param(top_level_block,'HighlightFeedbackLoops','on');                 % https://uk.mathworks.com/help/hdlcoder/ug/diagnostics-for-optimizations.html#buiuh3k-256
hdlset_param(top_level_block,'CodeGenerationOutput','GenerateHDLCode');      % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-output.html
hdlset_param(top_level_block,'GenerateHDLCode','on');                        % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-output.html
hdlset_param(top_level_block,'TargetDirectory',target_directory_string);       % https://uk.mathworks.com/help/hdlcoder/ug/target.html#buiuh3k-25
hdlset_param(top_level_block,'TreatIOThresholdAs', 'Warning');               % Needed to stop an error if the IO pins goes above 5000
hdlset_param(top_level_block,'DeleteUnusedPorts', 'on');
hdlset_param(top_level_block,'EDAScriptGeneration', 'off');
hdlset_param(top_level_block,'GenerateHDLTestBench', 'off');
hdlset_param(top_level_block, 'UseSingleLibrary', 'on');
hdlset_param(top_level_block, 'UseVerilogTimescale', 'off');

% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','No synthesis tool specified','TargetWorkflow','Generic ASIC/FPGA');

ProjectFolder = strcat(rtl_directory,'\',target_directory_string);

% Specify the top level project directory
hWC.ProjectFolder = char(ProjectFolder);

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndTestbench = true;
hWC.RunTaskVerifyWithHDLCosimulation = false;
hWC.RunTaskCreateProject = false;
hWC.RunTaskPerformLogicSynthesis = false;
hWC.RunTaskPerformMapping = false;
hWC.RunTaskPerformPlaceAndRoute = false;
hWC.RunTaskAnnotateModelWithSynthesisResult = false;

% Set properties related to 'RunTaskGenerateRTLCodeAndTestbench' Task
hWC.GenerateRTLCode = true;
hWC.GenerateTestbench = false;
hWC.GenerateValidationModel = false;

% Set properties related to 'RunTaskCreateProject' Task
hWC.Objective = hdlcoder.Objective.None;
hWC.AdditionalProjectCreationTclFiles = '';

% Set properties related to 'RunTaskPerformMapping' Task
hWC.SkipPreRouteTimingAnalysis = true;

% Set properties related to 'RunTaskPerformPlaceAndRoute' Task
hWC.IgnorePlaceAndRouteErrors = true;

% Set properties related to 'RunTaskAnnotateModelWithSynthesisResult' Task
hWC.CriticalPathSource = 'pre-route';
hWC.CriticalPathNumber =  1;
hWC.ShowAllPaths = false;
hWC.ShowDelayData = false;
hWC.ShowUniquePaths = false;
hWC.ShowEndsOnly = false;
hWC.AnnotateModel = 'generated';

% Validate the Workflow Configuration Object
hWC.validate;

% Run the workflow
hdlcoder.runWorkflow(full_hierarchical_path, hWC);