class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #Choose a parameterization
        
        Parobolic=[randint(1,3)*choice([-1,1])*t^2, randint(2,4)*choice([-1,1])*t]
        Circular=[randint(1,3)*choice([-1,1])*cos(pi*t), randint(1,3)*choice([-1,1])*sin(pi*t)]
        
        FunType=[Parobolic, Circular]
        FunctionChoices=FunType[randint(0,1)]
        
        
        shuffle(FunctionChoices)
        paramfun=[FunctionChoices[0], FunctionChoices[1], t]
        
        shuffle(paramfun)
        
        f0=paramfun[0]
        g0=paramfun[1]
        h0=paramfun[2]
        
        fun0(t)=paramfun[0]
        gun0(t)=paramfun[1]
        hun0(t)=paramfun[2]
        
        # Pick a point
        
        t0=randint(-8,8)/4
        
        x0=fun0(t0)
        y0=gun0(t0)
        z0=hun0(t0)
        
        
        
        
        #Pick 2 distinct coefficients
        coeff=[1,2,3, 1/2, 1/3]
        shuffle(coeff)
        
        a=coeff[0]
        b=coeff[1]
        
        #generate surface
                
        surface=a*x^2+b*y^2
        s(x,y)=a*x^2+b*y^2
        
        #pick traces
        
        tracev=choice(['x', 'y'])
        k1=randint(-5,5)
        k2=randint(1,3)^2
        
        #compute parameterizations
        
        other='y'
        
        f1=k1
        g1=t
        h1=s(k1, t)
        
        if tracev=='y':
            f1=t
            g1=k1
            h1=s(t,k1)
            other='x'
        
        h2=k2
        r=(k2)^(1/2)
        f2=r*a*cos(t)
        g2=r*b*sin(t)
        
        
        
        
        
        return {
            "surface": surface,
            "f0": f0,
            "g0": g0,
            "h0": h0,
            "t0": t0,
            "x0": x0,
            "y0": y0,
            "z0": z0,
            "f1": f1,
            "g1": g1,
            "h1": h1,
            "f2": f2,
            "g2": g2,
            "h2": h2,
            "tracev": tracev,
            "other": other,
            "k1": k1,
            "k2": k2,
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

