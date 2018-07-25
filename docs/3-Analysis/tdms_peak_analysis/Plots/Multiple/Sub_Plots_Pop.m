function Sub_Plots_Pop(varargin)
      
      figure(777);
      
      % Plot
      tdms_data = varargin{3};
      Plot_File(tdms_data);
      
      % Set: Axis Info
      title({['Subplot ',num2str(varargin{4})],['Temperature ',num2str(tdms_data.temperature)]})
      ylabel("Voltage (V)")
      xlabel("Frequency (khz)")
      
end