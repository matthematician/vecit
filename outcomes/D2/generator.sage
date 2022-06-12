class Generator(BaseGenerator):
    def data(self):
        var('x y z')
        
        n = randrange(1,5)*choice([-1,1]) # x-function parameter
        m = 2*randrange(1,3)+1 # y-function parameter
        k = randrange(2,4) # y-exponent
        dx = [randrange(1,4)*choice([-1,1])/choice([10,100]),randrange(1,4)*choice([-1,1])/choice([10,100])]
        z0 = choice([-1,1])*randrange(1,19)
        
        x0 = [n,choice([0,1])]
        xx = [x0[0]+dx[0], x0[1]+dx[1]]
        
        xfuncs = [sin(n*pi*(x^2-n*x)), cos(n*pi*(x^2-n*x)), exp(x^2-n*x)]
        
        yfuncs = [1/(1+y^m), 1/sqrt(1+y^m)]
        
        fx(x,y) = x-n
        fy(x,y) = x-n
        yr = 0
        
        while(fx(x0[0],x0[1])*fy(x0[0],x0[1])==0 and (yr==0 or x0[1]==0)):
            yr = randrange(0,2)
            fx(x,y) = 2*x*y^k + xfuncs[randrange(0,3)]
            fy(x,y) = k*x^2*y^(k-1) + yfuncs[yr]
        
        xe(x,y,z) = x-x0[0]
        ye(x,y,z) = y-x0[1]
        ze(x,y,z) = z-z0
        
        
        
        return {
            "fx": fx(x,y),
            "fy": fy(x,y),
            "fx0": fx(x0[0],x0[1]),
            "fy0": round(fy(x0[0],x0[1]),ndigits=1),
            "xe": xe(x,y,z),
            "ye": ye(x,y,z),
            "ze": ze(x,y,z),
            "planelhs": z,
            "planerhs": z0 - fx(x0[0],x0[1])*x0[0] - fy(x0[0],x0[1])*x0[1] + fx(x0[0],x0[1])*x + fy(x0[0],x0[1])*y,
            "x0": x0[0],
            "y0": x0[1],
            "x1": round(xx[0],ndigits=2),
            "y1": round(xx[1],ndigits=2),
            "dx": round(dx[0],ndigits=2),
            "dy": round(dx[1],ndigits=2),
            "z0": z0,
            "z1": round(z0+fx(x0[0],x0[1])*dx[0]+fy(x0[0],x0[1])*dx[1],ndigits=4)
            
        }

#    @provide_data
#    def graphics(data):
        # updated by clontz
#        return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
                #"contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
#               }
#
