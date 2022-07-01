class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        
        
        
        x0=round(randint(1,500)*0.01*choice([-1,1]),2)
        y0=round(randint(1,500)*0.01*choice([-1,1]),2)
        
        fz=round(randint(1,500)*0.01*choice([-1,1]),2)
        fzz=round(randint(1,500)*0.01*choice([-1,1]),2)
        fxy=round(randint(1,500)*0.01*choice([-1,1]),2)
        
        intzz="increases"
        if fzz<0:
            intxx="decreases"
            
        intxy="increases"
        if fxy<0:
            intxy="decreases"    
        
        
        z1=choice(['x', 'y'])
        z2=choice(['x', 'y'])
        z3=choice(['x', 'y'])
        
        
        z1c='x'
        z1c0=x0
        z10=y0
        if z1=='x':
            z1c='y'
            z1c0
            z10=x0
        
        z2c='x'
        z2c0=x0
        z20=y0
        if z2=='x':
            z2c='y'
            z2c0
            z20=x0
            
        
        z3c='x'
        z3c0=x0
        z30=y0
        if z3=='x':
            z3c='y'
            z3c0
            z30=x0
        
        
        
        
        
        return {
            "x0": x0,
            "y0": y0,
            "fz": fz,
            "fzz": fzz,
            "fxy": fxy,
            "z1": z1,
            "z2": z2,
            "z3": z3,
            "z10": z10,
            "z20": z20,
            "z30": z30,
            "z1c": z1c,
            "z2c": z2c,
            "z3c": z3c,
            "z1c0": z1c0,
            "z2c0": z2c0,
            "z3c0": z3c0,
            "intzz": intzz,
            "intxy": intxy,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

