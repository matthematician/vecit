class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #choose functions
        
        fxy=choice([
                randint(1,5)*x^randint(1,5)*y^randint(1,5),
                randint(1,5)*x^randint(1,5)*exp(randint(1,5)*y^randint(1,2)),
                randint(1,5)*y^randint(1,5)*exp(randint(1,5)*x^randint(1,2)),
                #randint(1,5)*x^randint(1,5)*sin(pi/4*randint(1,4)*y^randint(1,5)),
                #randint(1,5)*y^randint(1,5)*sin(pi/4*randint(1,4)*x^randint(1,5)),
                #randint(1,5)*x^randint(1,5)*cos(pi/4*randint(1,5)*y^randint(1,5)),
                #randint(1,5)*y^randint(1,5)*cos(pi/4*randint(1,5)*x^randint(1,5)),
                randint(1,5)*exp(randint(1,5)*x^randint(1,2)-randint(1,3)*y^randint(1,2)),
                randint(1,5)*exp(randint(1,5)*y^randint(1,2)-randint(1,3)*x^randint(1,2)),
            ])
        
        Fxy(x,y)=fxy
        
        
        fx=choice([
                randint(1,5)*choice([-1,1])*t^randint(2,5),
                randint(1,5)*choice([-1,1])*exp(randint(1,5)*choice([-1,1])*t),
                #randint(1,5)*choice([-1,1])*sin(pi/4*randint(1,5)*t),
                #randint(1,5)*choice([-1,1])*cos(pi/4*randint(1,5)*t),
            ])+randint(1,5)*choice([-1,1])*t^choice([0,1])
        
        Fx(t)=fx
        
        fy=choice([
                randint(1,5)*choice([-1,1])*t^randint(2,5),
                randint(1,5)*choice([-1,1])*exp(randint(1,5)*choice([-1,1])*t),
                #randint(1,5)*choice([-1,1])*sin(pi/4*randint(1,5)*t),
                #randint(1,5)*choice([-1,1])*cos(pi/4*randint(1,5)*t),
            ])+randint(1,5)*choice([-1,1])*t^choice([0,1])
        
        Fy(t)=fy
        
        #Compute derivatives.
        
        DFx=derivative(fxy, x)
        DFy=derivative(fxy, y)
        Dxt=derivative(fx,t)
        Dyt=derivative(fy,t)
        
        DFxyt=DFx*Dxt+DFy*Dyt
        
        DFt(t)=derivative(Fxy(fx,fy),t)
        
        #pick a point and compute point
        
        t0=randint(-1,1)
        x0=Fx(t0)
        y0=Fy(t0)
        DFt0=DFt(t0)
        
        
        
        
        
        return {
            "fxy": fxy,
            "fx": fx,
            "fy": fy,
            "DFx": DFx,
            "DFy": DFy,
            "Dxt": Dxt,
            "Dyt": Dyt,
            "DFxyt": DFxyt,
            "t0": t0,
            "x0": x0,
            "y0": y0,
            "DFt0": DFt0,
            
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

