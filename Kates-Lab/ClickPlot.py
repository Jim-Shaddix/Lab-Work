
import matplotlib.pyplot as plt
import numpy as np

def click_plot(fig, ax, x_signal, y_signal, x_points, y_points, signal_kwargs={}):
    '''
    DESCRIPTION:
        - These plots have clickable points (The "point" data is clickable).
          Everytime a click is made on a point, the position of the point 
          is recorded. If the point is clicked on again, it will remove 
          the record of that point.
          
    RETURN: [List] of [List] containing 2_elements: (x-coordinate, y-coordinate)
            - The coordinates describe the locations that were recorded
    '''
    
    # Points to be Recorded
    important_points = []
    
    #      --- Plot The Data --- 
    
    # Signal Plot
    ax.plot(x_signal, y_signal, **signal_kwargs)

    # Point Plot
    coll = ax.scatter(x_points, y_points, color=["blue"]*len(x_points),
                      picker=5,label="Point Data")

    ax.legend(loc="best")
    
    #      --- Clickable Event ---
    
    def on_pick(event):

        # Index to Where The Event Occurred
        ind = event.ind[0]

        # Where The Event Occurred
        x_val, y_val = x_points[ind], y_points[ind]
       
        if [x_val,y_val] not in important_points:   
            
            # Record Point
            # color is speciified by: RGBA tuple
            # https://www.cgl.ucsf.edu/chimera/docs/ProgrammersGuide/Examples/footnotes/rgba.html
            important_points.append([x_val,y_val])
            coll._facecolors[ind,:] = (1, 0, 0, 1)
            coll._edgecolors[ind,:] = (1, 0, 0, 1)
            print("\t  Picked  Point [ {:>3} ] at: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))
  
        else: 
        
            # Stop Recording Point
            important_points.remove([x_val,y_val])
            coll._facecolors[ind,:] = (0, 0, 1, 1)
            coll._edgecolors[ind,:] = (0, 0, 1, 1)
            print("\t  Removed Point [ {:>3} ] at: [ {:06.2f}, {:06.5f} ]".format(ind,x_val,y_val))

        fig.canvas.draw()

    fig.canvas.mpl_connect('pick_event', on_pick)
    
    # Add Blocking to Stop The Program
    plt.show(block=True)

    return important_points


def main():
    
    # Sample Data
    y = [0,0,0,2,0,0,0,-2,0,0,0,2,0,0,0,-2,0]
    x = range(len(y))
    
    y_peak = [2,-2,2,-2]
    x_peak = [3,7,11,15]

    # Set Plot Info
    fig, ax = plt.subplots()                
    ax.set_xlabel("x-axis")
    ax.set_ylabel("y-axis")
    ax.set_title("Click On The Peaks!")
    
    signal_kwargs = { 
                    "linewidth":1, 
                    "linestyle":"-",
                    "color":"green",
                    "label":"Magnitude vs. Frequency"
                    }

    # Make Clickable Plot
    imp = click_plot(fig, ax, x, y, x_peak, y_peak, signal_kwargs)
    
    print("\nPoints Picked:\n",imp)
    
if __name__ == "__main__":
    main()









