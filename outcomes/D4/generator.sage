class Generator(BaseGenerator):
    def data(self):
        k = 2*randint(1,4)^3*choice([-1,1])
        b=1
        var('x y')
        f(x,y) = x^2 + 2*b*x*y^2+2*k*y
        fxx(x,y) = f(x,y).derivative(x,2)
        fyy(x,y) = f(x,y).derivative(y,2)
        fxy(x,y) = f(x,y).derivative(x).derivative(y)
        Delta(x,y) = fxx(x,y)*fyy(x,y)-fxy(x,y)^2
        
        c2 = vector([-b*((k/2).nth_root(3))^2,(k/2).nth_root(3)])
        
        if(Delta(c2[0],c2[1])<0):
            c2type = "saddle point"
        else:
            if(fxx(c2[0],c2[1])>0):
                c2type = "local minimum"
            if(fxx(c2[0],c2[1])<0):
                c2type = "local maximum"
            if(Delta(c2[0],c2[1])==0):
                c2type = "degenerate"

        surface = f(x,y)
        m =2*max(abs(c2[0]),abs(c2[1]))
        m0 = 2*min(abs(c2[0]),abs(c2[1]))
        z0 = f(c2[0],c2[1])        
        tours = [z0+k*0.2*z0 for k in range(-6,6)]
        tours.sort()
        
                
        return {
            "f": f(x,y),
            "c2": c2,
            "c2type": c2type,
            "min": -1*m,
            "max": m,
            "ymin": -1*m0,
            "ymax": m0,
            "surface": surface,
            "tours": tuple(tours),
            "fxx1": fxx(c2[0],c2[1]),
            "d1": Delta(c2[0],c2[1])
            
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                "contour": contour_plot(data['surface'], (x,data['min'],data['max']), (y,data['ymin'],data['ymax']), fill=False, plot_points=400, labels=True, contours=data['tours'])+point2d(data['c2'],size=30,rgbcolor=(0.5,0,0))
               }

