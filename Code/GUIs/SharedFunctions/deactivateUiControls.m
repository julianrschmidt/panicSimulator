function deactivationStruct = deactivateUiControls( hFig )
%DEACTIVATEUICONTROLS Deactivates all Ui Controls
%   Sets 'Enable' settings of all Ui Controls in hFig to 'off'
%   and deletes the closeRequestFcn. To reactivate as before, call function
%   reactivateUiControls with the returned structure as parameter
% See also: REACTIVATEUICONTROLS
hGuiObj = [findobj(allchild(hFig), 'Type','uicontrol');...
    findobj(allchild(hFig), 'Type','uimenu')];
enableStates = get(hGuiObj,'Enable');
set(hGuiObj,'Enable', 'off');
closeRequestFcnTemp = get(hFig, 'CloseRequestFcn');
set(hFig, 'CloseRequestFcn', '');

deactivationStruct.hGuiObj = hGuiObj;
deactivationStruct.enableStates = enableStates;
deactivationStruct.closeRequestFcnTemp = closeRequestFcnTemp;
deactivationStruct.hFig = hFig;

end

