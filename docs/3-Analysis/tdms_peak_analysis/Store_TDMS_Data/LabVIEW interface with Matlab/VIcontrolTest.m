vifile='HypTest.vi';%filename for LabVIEW VI that will be read/controlled. Script developed with HypTest.vi.
vilocation='C:\Users\Admin\Desktop';%directory folder where VI is located

e = actxserver('LabVIEW.Application');%%%%\/ set up VI as server for communicating with matlab
vipath = [vilocation,'\',vifile];
cd(vilocation)
vi = invoke(e,'GetVIReference',vipath);%%%

methods(vi)% print list of commands for vi
vi.FPWinOpen = 1; % Opens the window. Sets VI to variable 'vi'. Can't use vi.Run, it hangs. Start manually. 
eval(['!start ',vifile])% manual start of VI

%% Example control/read commands in loop (variable names need to be changed to variable you want to control/read)
while 1;
c=vi.GetControlValue('c big');%command for reading a value. Here this is variable 'c' from HypTest.vi
if c==1;
    pause(2)
vi.SetControlValue('stop',1);pause(1);vi.SetControlValue('stop',0);%command for seting value push button (variable 'stop') true/false (1/0), can also send in doubles, depending on variable being set
else;end;end
vi.SetControlValue('stop',0);eval(['!start ',vifile])
