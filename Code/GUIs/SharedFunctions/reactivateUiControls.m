function reactivateUiControls( deactivationStruct )
%REACTIVATEUICONTROLS reactivates all ui controls previously deactivated
%   input argument: structure returned from DEACTIVATEUICONTROLS
% see also: DEACTIVATEUICONTROLS
hGuiObj = deactivationStruct.hGuiObj;
hFig = deactivationStruct.hFig;
enableStates = deactivationStruct.enableStates;
closeRequestFcnTemp = deactivationStruct.closeRequestFcnTemp;
for guiObjNr = 1:length(hGuiObj)
    set(hGuiObj(guiObjNr),'Enable', enableStates{guiObjNr});
end
set(hFig, 'CloseRequestFcn', closeRequestFcnTemp);

end

