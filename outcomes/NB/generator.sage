class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        #Choose a parameterization
        
        Functions=[randint(1,5)*choice([-1,1]),
                   randint(1,5)*choice([-1,1])*cos(pi*t),
                   randint(1,5)*choice([-1,1])*sin(pi*t),
                   randint(1,5)*choice([-1,1])*t^2+randint(-5,5)*t+randint(-5,5),
                   randint(1,5)*choice([-1,1])*exp(randint(1,5)*choice([-1,1])*t),
                   #randint(1,5)*choice([-1,1])*cos(pi*t)*t,
                   #randint(1,5)*choice([-1,1])*sin(pi*t)*t,
                   #randint(1,5)*choice([-1,1])*t^2+randint(-5,5)*t+randint(-5,5)*t,
                   #randint(1,5)*choice([-1,1])*exp(randint(1,5)*choice([-1,1])*t)*t,
                   randint(1,5)*choice([-1,1])*cos(pi*t)+randint(1,5)*choice([-1,1])*t,
                   randint(1,5)*choice([-1,1])*sin(pi*t)+randint(1,5)*choice([-1,1])*t,
                   randint(1,5)*choice([-1,1])*t^2+randint(-5,5)*t+randint(-5,5)+randint(1,5)*choice([-1,1])*t,
                   randint(1,5)*choice([-1,1])*exp(randint(1,5)*choice([-1,1])*t)+randint(1,5)*choice([-1,1])*t,
                  ]
        
        shuffle(Functions)
        
        f0=Functions[0]
        g0=Functions[1]
        h0=Functions[2]
        
        fun0(t)=Functions[0]
        gun0(t)=Functions[1]
        hun0(t)=Functions[2]
        
        # Pick a point
        
        t0=randint(-8,8)/4
        
        x0=fun0(t0)
        y0=gun0(t0)
        z0=hun0(t0)
        
        
        #Find velocity 
        
        f1=derivative(f0,t)
        g1=derivative(g0,t)
        h1=derivative(h0,t)
        
        fun1(t)=derivative(fun0(t),t)
        gun1(t)=derivative(gun0(t),t)
        hun1(t)=derivative(hun0(t),t)
        
        vx=fun1(t0)
        vy=gun1(t0)
        vz=hun1(t0)
        
        vmag=(vx^2 + vy^2 + vz^2)^(1/2)
        
        #Find acceleration
        
        f2=derivative(f1,t)
        g2=derivative(g1,t)
        h2=derivative(h1,t)
        
        fun2(t)=derivative(fun1(t),t)
        gun2(t)=derivative(gun1(t),t)
        hun2(t)=derivative(hun1(t),t)
        
        ax=fun2(t0)
        ay=gun2(t0)
        az=hun2(t0)
        
        amag=(ax^2 + ay^2 + az^2)^(1/2)
        
        #Parameterize tangent line:
        lx=x0+vx*t
        ly=y0+vy*t
        lz=z0+vz*t
        
        
        
        
        
        
        
        
        
        
        return {
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
            "vx": vx,
            "vy": vy,
            "vz": vz,
            "ax": ax,
            "ay": ay,
            "az": az,
            "lx": lx,
            "ly": ly,
            "lz": lz,
            "vmag": vmag,
            "amag": amag,
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

