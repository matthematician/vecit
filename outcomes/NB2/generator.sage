class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #Choose a parameterization
        
        
        #t0 = randint(1,3)
        
        
        Functions=[randint(1,2)*(t+randint(-2,-1))+randint(-5,5), 
                   randint(1,2)*(t+randint(-2,-1))^2+randint(-5,5), 
                   #randint(1,3)*(t+randint(-3,-1))+randint(-5,5), 
                   cos(t),
                   sin(t)
                  ]
        
        shuffle(Functions)
        
        
        
        r(t)=vector([Functions[0], Functions[1], Functions[2] ])
        
        
        #r(t)=vector([cos(t), sin(t), t ])
        
        v(t) = diff(r(t), t)
        
        a(t) = diff(v(t) , t)
        
        sp(t) = abs(v(t))
        
        spp(t) = diff(sp(t), t)
        
        Tan(t) = v(t)/abs(v(t))
        
        curve(t) = abs(diff( Tan(t), t ))/sp(t)
        
        Norm(t) = diff( Tan(t), t)/abs( diff( Tan(t), t) )
        
        cT(t) = spp(t)
        
        cN(t) = curve(t)*sp(t)^2
        
        t1 = randint(1,3)
        
        t2 = randint(8,10)
        
        t0 = 0
        
        
        
        
        
        
        
        
        
        
        return {
            "t0": t0,
            "t1": t1,
            "t2": t2,
            "r":r(t),
            "sp": sp(t),
            "Tan": Tan(t),
            "Tan0": Tan(t0),
            "Norm0": Norm(t0),
            "curve0": curve(t0),
            "cT0": cT(t0),
            "cN0": cN(t0),
            "a0": a(t0),
            "v": v(t),
            
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

