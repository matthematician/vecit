class Generator(BaseGenerator):
    def data(self):
        var('x y')
        
        case=randint(0,1)
        
        if case==0:
            c = randint(1,4)*choice([-1,1])            
            a = abs(c) *randint(1,4)
            b = 2*randint(1,3)^2*c^2
            p = randint(0,1)
            a=a*(-1)^p
            b=b*(-1)^p
            c=c*(-1)^p
            f(x,y) = a*x^2+b*y^2+c*x^2*y
            c2 = vector([(2*a*b/c^2)^(1/2), -a/c])
            c3 = vector([-1*(2*a*b/c^2)^(1/2), -a/c])  
            
            
        if case==1:
            c = randint(1,4)*choice([-1,1])            
            b = abs(c) *randint(1,4)
            a = 2*randint(1,3)^2*c^2
            p = randint(0,1)
            a=a*(-1)^p
            b=b*(-1)^p
            c=c*(-1)^p
            f(x,y) = a*x^2+b*y^2+c*x*y^2
            c2 = vector([-b/c, (2*a*b/c^2)^(1/2)])
            c3 = vector([-b/c, -1*(2*a*b/c^2)^(1/2)])   
            
        
        
        
        fxx(x,y) = f(x,y).derivative(x,2)
        fyy(x,y) = f(x,y).derivative(y,2)
        fxy(x,y) = f(x,y).derivative(x).derivative(y)
        Delta(x,y) = fxx(x,y)*fyy(x,y)-fxy(x,y)^2
        
        
        
        if(Delta(0,0)<0):
            c1type = "saddle point"
        else:
            if(fxx(0,0)>0):
                c1type = "local minimum"
            if(fxx(0,0)<0):
                c1type = "local maximum"
            if(Delta(0,0)==0):
                c1type = "degenerate"
        
        #c2 = vector([2*h,2*k])
        #c3 = vector([2*h,0])
        #c4 = vector([0,2*k])
        
        if(Delta(c2[0],c2[1])<0):
            c2type = "saddle point"
        else:
            if(fxx(c2[0],c2[1])>0):
                c2type = "local minimum"
            if(fxx(c2[0],c2[1])<0):
                c2type = "local maximum"
            if(Delta(c2[0],c2[1])==0):
                c2type = "degenerate"

                
        if(Delta(c3[0],c3[1])<0):
            c3type = "saddle point"
        else:
            if(fxx(c3[0],c3[1])>0):
                c3type = "local minimum"
            if(fxx(c3[0],c3[1])<0):
                c3type = "local maximum"
            if(Delta(c3[0],c3[1])==0):
                c3type = "degenerate"        
                
                
        #if(Delta(c4[0],c4[1])<0):
        #    c4type = "saddle point"
        #else:
        #    if(fxx(c4[0],c4[1])>0):
        #        c4type = "local minimum"
        #    if(fxx(c4[0],c4[1])<0):
        #        c4type = "local maximum"
        #    if(Delta(c4[0],c4[1])==0):
        #        c4type = "degenerate"
                
                
        surface = f(x,y)
        m =2*max(abs(c2[0]),abs(c3[0]),)
        m0 =2*max(abs(c2[1]),abs(c3[1]),)
        z = max(f(0,0),f(c2[0],c2[1]),f(c3[0],c3[1]),)        
        z0 = min(f(0,0),f(c2[0],c2[1]),f(c3[0],c3[1]),)        

        di = [
            abs( f(0,0) - f(c2[0],c2[1])),
            abs( f(0,0) - f(c3[0],c3[1])),
            abs( f(c2[0],c2[1]) - f(c3[0],c3[1])),
            ]
        di = [i for i in di if i!=0]
        dd = min(di)/3
        tours = [f(0,0)+k*dd for k in range(-1,1)]+[f(c2[0],c2[1])+k*dd for k in range(-1,1)]+[f(c3[0],c3[1])+k*dd for k in range(-1,1)]
        tours = [i for i in set(tours)]
        tours.sort()
        
                
        return {
            "f": f(x,y),
            "c1": vector([0,0]),
            "c1type": c1type,
            "c2": c2,
            "c2type": c2type,
            "c3": c3,
            "c3type": c3type,
            #"c4": c4,
            #"c4type": c4type,            
            "min": -1*max(m,m0),
            "max": max(m,m0),
            "ymin": -1*max(m,m0),
            "ymax": max(m,m0),
            "surface": surface,
            "tours": tuple(tours),
            "fxx1": fxx(0,0),
            "d1": Delta(0,0),
            "fxx2": fxx(c2[0],c2[1]),
            "d2": Delta(c2[0],c2[1]),
            "fxx3": fxx(c2[0],0),
            "d3": Delta(c3[0],c3[1]),
            #"fxx4": fxx(0,c2[1]),
            #"d4": Delta(0,c2[1])
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                "contour": contour_plot(data['surface'], (x,data['min'],data['max']), (y,data['ymin'],data['ymax']), fill=False, plot_points=400, labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x, contours=data['tours'])+point2d(data['c2'],size=30,rgbcolor=(0.5,0,0))+point2d((0,0),size=30,rgbcolor=(0.5,0,0))+point2d(data['c3'],size=30,rgbcolor=(0.5,0,0))
               }

