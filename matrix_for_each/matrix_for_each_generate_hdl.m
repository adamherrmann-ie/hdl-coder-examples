clc;
clear all;

%% Setup Model

matrix_for_each_run;

%% Begin HDL Generation

proj = currentProject;
rtl_directory = regexprep(proj.ProjectStartupFolder, 'work$', 'rtl');

full_hierarchical_path   = 'matrix_for_each_wrapper/matrix_for_each_top_sref';
block_name               = 'matrix_for_each_top_sref';

module_prefix            = 'matrix_foreach_';
reset_input_port         = 'i_rstn';
clock_input_port         = 'i_clk';

% Load the Model
load_system('matrix_for_each_wrapper');

% Restore the Model to default HDL parameters
hdlrestoreparams(full_hierarchical_path);

current_time = datetime('now');
date_time_string = sprintf('%s_', datetime(current_time, 'Format', 'yyMMdd_HHmmss'));
target_directory_string = sprintf('%s%s', date_time_string, block_name);

% Model HDL Parameters
hdlset_param('matrix_for_each_wrapper','TargetLanguage','SystemVerilog');              % https://uk.mathworks.com/help/hdlcoder/ug/target.html#buiuh3k-20
hdlset_param('matrix_for_each_wrapper','Traceability','on');                           % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-40
hdlset_param('matrix_for_each_wrapper','PreserveDesignDelays','on');                   % https://uk.mathworks.com/help/hdlcoder/ug/pipelining-parameters.html#bu_om9f-1
hdlset_param('matrix_for_each_wrapper','ResourceReport','on');                         % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-42
hdlset_param('matrix_for_each_wrapper','DeleteUnusedPorts','off');                     % https://uk.mathworks.com/help/hdlcoder/ug/general-optimization-parameters.html#mw_f7b18e22-cd9f-459b-9db9-7a076aa75a2d
hdlset_param('matrix_for_each_wrapper','OptimizationReport','on');                     % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-report-parameters.html#buiuh3k-44
hdlset_param('matrix_for_each_wrapper','ResetType','Asynchronous');                    % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-60
hdlset_param('matrix_for_each_wrapper','ResetAssertedLevel','active-low');             % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-62
hdlset_param('matrix_for_each_wrapper','ClockInputPort',clock_input_port);         % https://uk.mathworks.com/help/hdlcoder/ug/clock-and-timing-controller-settings.html#buiuh3k-64
hdlset_param('matrix_for_each_wrapper','ClockInputs','Single');                        % https://uk.mathworks.com/help/hdlcoder/ug/clock-and-timing-controller-settings.html#buiuh3k-78
hdlset_param('matrix_for_each_wrapper','ClockEnableInputPort','clken_INCORRECT');           % https://uk.mathworks.com/help/hdlcoder/ug/clock-enable-settings.html#buiuh3k-68
hdlset_param('matrix_for_each_wrapper','MinimizeClockEnables','on');                   % https://uk.mathworks.com/help/hdlcoder/ug/minimize-clock-enables-and-reset-signals.html
hdlset_param('matrix_for_each_wrapper','ResetInputPort',reset_input_port);            % https://uk.mathworks.com/help/hdlcoder/ug/reset-and-clock-enable-settings.html#buiuh3k-73
hdlset_param('matrix_for_each_wrapper','UserComment','(c) Adam Herrmann');             % https://uk.mathworks.com/help/hdlcoder/ug/comment-in-header.html
hdlset_param('matrix_for_each_wrapper','BlockGenerateLabel','_gen');                   % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_53c144bf-ca0b-4336-a223-4726c5b26dfb
hdlset_param('matrix_for_each_wrapper','InstanceGenerateLabel','_gen');                % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_54959ae3-fe60-42c4-bae8-5e6f76f24f44
hdlset_param('matrix_for_each_wrapper','InstancePostfix','');                          % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_9d7a2ae6-6c81-46a4-8e68-ec763336396b
hdlset_param('matrix_for_each_wrapper','InstancePrefix','u_');                         % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_943198bc-ed5a-4cc6-884b-398c7756d1a8
hdlset_param('matrix_for_each_wrapper','ModulePrefix',module_prefix);                          % https://uk.mathworks.com/help/hdlcoder/ref/makehdl.html (search for moduleprefix)
hdlset_param('matrix_for_each_wrapper','SubsystemReuse', 'Atomic and Virtual');        
hdlset_param('matrix_for_each_wrapper','VectorPrefix','vec_');                         % https://uk.mathworks.com/help/hdlcoder/ug/generate-statements-labels.html#mw_d78e159b-8559-4ab2-ac4a-714fa92dfdad
hdlset_param('matrix_for_each_wrapper','UseAggregatesForConst','off');                 % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-constants-and-matlab-function-blocks.html#buiuh3k-192
hdlset_param('matrix_for_each_wrapper','InitializeBlockRAM','on');                     % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-rams.html#buiuh3k-217
hdlset_param('matrix_for_each_wrapper','RAMArchitecture','WithClockEnable');           % https://uk.mathworks.com/help/hdlcoder/ug/rtl-customizations-for-rams.html#buiuh3k-219
hdlset_param('matrix_for_each_wrapper','NoResetInitializationMode','None');            % https://uk.mathworks.com/help/hdlcoder/ug/no-reset-registers-initialization.html
hdlset_param('matrix_for_each_wrapper','MinimizeIntermediateSignals','on');           % https://uk.mathworks.com/help/hdlcoder/ug/rtl-style.html#buiuh3k-209
hdlset_param('matrix_for_each_wrapper','MaskParameterAsGeneric','off');                % https://uk.mathworks.com/help/hdlcoder/ug/rtl-style.html#buiuh3k-215
hdlset_param('matrix_for_each_wrapper','SafeZeroConcat','on');                         % https://uk.mathworks.com/help/hdlcoder/ug/rtl-annotations.html#buiuh3k-203
hdlset_param('matrix_for_each_wrapper','CustomFileHeaderComment','');                  % https://uk.mathworks.com/help/hdlcoder/ug/file-comment-customization.html#mw_17fc13e9-9712-4bb2-a001-7597e41e7a1f
hdlset_param('matrix_for_each_wrapper','DateComment','on');                            % https://uk.mathworks.com/help/hdlcoder/ug/rtl-annotations.html
hdlset_param('matrix_for_each_wrapper','RequirementComments','on');                    % https://uk.mathworks.com/help/hdlcoder/ug/file-comment-customization.html#buiuh3k-211
hdlset_param('matrix_for_each_wrapper','GenerateValidationModel','off');               % https://uk.mathworks.com/help/hdlcoder/ug/model-generation-for-hdl-code.html#buiuh3k-35
hdlset_param('matrix_for_each_wrapper','LayoutStyle','None');                          % https://uk.mathworks.com/help/hdlcoder/ug/naming-options.html#mw_78d763a5-1a29-46a4-8d3c-910004fd81eb
hdlset_param('matrix_for_each_wrapper','AutoRoute','off');                             % https://uk.mathworks.com/help/hdlcoder/ug/naming-options.html#mw_8a49f8bf-5fe2-4314-86c2-e02fdeeb1d4c
hdlset_param('matrix_for_each_wrapper','HighlightFeedbackLoops','on');                 % https://uk.mathworks.com/help/hdlcoder/ug/diagnostics-for-optimizations.html#buiuh3k-256
hdlset_param('matrix_for_each_wrapper','CodeGenerationOutput','GenerateHDLCode');      % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-output.html
hdlset_param('matrix_for_each_wrapper','GenerateHDLCode','on');                        % https://uk.mathworks.com/help/hdlcoder/ug/code-generation-output.html
hdlset_param('matrix_for_each_wrapper','TargetDirectory',target_directory_string);       % https://uk.mathworks.com/help/hdlcoder/ug/target.html#buiuh3k-25
hdlset_param('matrix_for_each_wrapper','TreatIOThresholdAs', 'Warning');               % Needed to stop an error if the IO pins goes above 5000
hdlset_param('matrix_for_each_wrapper','DeleteUnusedPorts', 'on');
hdlset_param('matrix_for_each_wrapper','EDAScriptGeneration', 'off');
hdlset_param('matrix_for_each_wrapper','GenerateHDLTestBench', 'off');
hdlset_param('matrix_for_each_wrapper', 'UseSingleLibrary', 'on');
hdlset_param('matrix_for_each_wrapper', 'UseVerilogTimescale', 'off');
set_param('matrix_for_each_wrapper', 'DefaultParameterBehavior', 'Inlined');

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