%% Panic Simulator

% The aim of the Panic Simulator is to simulate features of human escape 
% panic in crowded environments with a single exit e.g. baths, discotheques,
% stadia, lecture halls or rooms in general. Thereby the modeling of the 
% pedestrian’s behavior is inspired by the model used by Helbing et al.*. 
% The graphical user interface enables an intuitive and fast handling in
% all settings and features of the Panic Simulator as well as it allows
% convenient research in the fields of panic behavior and room architectures. 

% The basic characteristics and features of the Panic Simulator are:

% SETTINGS:     management of the properties for 
%               Agents (simulated individuals),
%               Arena (simulated environment),
%               Equation of motion (model of pedestrian’s behavior) and
%               Plot (speed of simulation)

% ARENA EDITOR: powerful editor to adjust and manipulate the environment by
%               creating, removing or modifying the properties of Agents 
%               and Arena

% AUTOMATE:     statistic tool allowing automated variable sweep, averaging
%               over multiple runs and data visualization

% For detailed description of all features please read the ‘Panic Simulator
% User Guide’.

% * Dirk Helbing, Illes Farkas, Tamas Vicsek, Simulating dynamical features of escape panic
% Nature 407, 487-409 (2000)

% $Author: Julian Schmidt, Alexander Spaeh $    $Date: 2014/04/12 21:16:00 $    $Revision: 1.0 $
% Copyright: 2014, Julian Schmidt and Alexander Spaeh

if ~isdeployed
    addpath(genpath('./Code'));
end
warningsOff();
PanicSimulatorGui();