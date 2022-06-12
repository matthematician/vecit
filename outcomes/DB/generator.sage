class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        
        
        
        x0=round(randint(1,500)*0.01*choice([-1,1]),2)
        y0=round(randint(1,500)*0.01*choice([-1,1]),2)
        fx0=round(randint(1,500)*0.01*choice([-1,1]),2)
        fy0=round(randint(1,500)*0.01*choice([-1,1]),2)
        fxx0=round(randint(1,500)*0.01*choice([-1,1]),2)
        fxy0=round(randint(1,500)*0.01*choice([-1,1]),2)
        fyy0=round(randint(1,500)*0.01*choice([-1,1]),2)
        
        intxx="increasing"
        if fxx0<0:
            intxx="decreasing"
            
        intxy="increasing"
        if fxy0<0:
            intxy="decreasing"    
        
        intyy="increases"
        if fyy0<0:
            intyy="decreases"
        
        
        
        
        
        
        
        
        return {
            "x0": x0,
            "y0": y0,
            "fx0": fx0,
            "fy0": fy0,
            "fxx0": fxx0,
            "fxy0": fxy0,
            "fyy0": fyy0,
            "intxx": intxx,
            "intxy": intxy,
            "intyy": intyy,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

