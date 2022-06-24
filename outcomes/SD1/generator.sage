class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y u v')
        
        W=[u,v]
        shuffle(W)
        w0=W[0]
        w1=W[1]
        
        f(u,v)=choice([
                w0*exp(w1),
                w0+exp(w1),
            ])
        
        m=randrange(1,6)^choice([-1,1])
        c=randint(5,10)
        
        uf(x,y)=randint(1,5)*x+randint(1,5)*y
        vf(x,y)=randint(1,5)*x-randint(1,5)*y
        
        soln=solve([uf(x,y)==u, vf(x,y)==v], x, y)
        
        xf(u,v)=soln[0][0].rhs()
        yf(u,v)=soln[0][1].rhs()
        
        #transform v=0 to x,y
        y1(x)=solve([vf(x,y)==0], y)[0].rhs()

        #transform u=c to x,y
        y2(x)=solve([uf(x,y)==c], y)[0].rhs()

        #transform v=m*u to x,y
        y3(x)=solve([vf(x,y)==m*uf(x,y)], y)[0].rhs()

        #find point 1
        px=solve([y==y1(x), y==y2(x)], x, y)[0][0].rhs()
        py=solve([y==y1(x), y==y2(x)], x, y)[0][1].rhs()

        #find point 2
        qx=solve([y==y1(x), y==y3(x)], x, y)[0][0].rhs()
        qy=solve([y==y1(x), y==y3(x)], x, y)[0][1].rhs()

        #find point 3
        rx=solve([y==y2(x), y==y3(x)], x, y)[0][0].rhs()
        ry=solve([y==y2(x), y==y3(x)], x, y)[0][1].rhs()

        xlow=min(px, qx, rx)-0.2
        xhigh=max(px, qx, rx)+0.2
        ylow=min(py, qy, ry)-0.2
        yhigh=max(py, qy, ry)+0.2

        
        xu=derivative(xf(u,v) ,u)
        xv=derivative(xf(u,v) ,v)
        yu=derivative(yf(u,v) ,u)
        yv=derivative(yf(u,v) ,v)
        
        Jacob=xu*yv-xv*yu
        
        
        
        upperv=m*u
            
            
        
        integ = definite_integral( definite_integral( f(u,v)*Jacob, v, 0, m*u ), u, 0, c )

        return {
            "y1": y1(x),
            "y2": y2(x),
            "y3": y3(x),
            "px": px,
            "py": py,
            "qx": qx,
            "qy": qy,
            "rx": rx,
            "ry": ry,
            "m": m,
            "c": c,
            "xu": xu,
            "xv": xv,
            "yu": yu,
            "yv": yv,
            "Jacob": Jacob,
            "fxy": f(uf(x,y), vf(x,y)),
            "fuv": f(u, v),
            "xuv": xf(u,v),
            "yuv": yf(u,v),
            "xlow": xlow,
            "xhigh": xhigh,
            "ylow": ylow,
            "yhigh": yhigh,
            "integ": integ,
        }
    
    @provide_data
    def graphics(data):
        # updated by clontz
        return {
            #"regionxy": implicit_plot3d(data['f']==data['v1'], (data['v0'],0,data['c']), (data['v1'],0,data['max1']), (data['v2'],0,data['k']), opacity=0.5)+implicit_plot3d(data['plane']==data['k'], (data['v0'],0,data['c']), (data['v1'],0,data['max1']), (data['v2'],0,data['k']), opacity=0.5, color='red'),
            "regionxy": polygon([(data['px'],data['py']), (data['qx'],data['qy']), (data['rx'],data['ry'])])+plot(data['y1'], (x,data['xlow'],data['xhigh']), ymin=data['ylow'], ymax=data['yhigh'])+plot(data['y2'], (x,data['xlow'],data['xhigh']), ymin=data['ylow'], ymax=data['yhigh'])+plot(data['y3'], (x,data['xlow'],data['xhigh']), ymin=data['ylow'], ymax=data['yhigh']),
            "regionuv": polygon([(0,0), (data['c'],0), (data['c'],data['c']*data['m'] )], color='red')+plot(0, (x,-0.2,data['c']+0.2), color='red')+plot(data['m']*x, (x,-0.2,data['c']+0.2), color='red', ymin=-0.2, ymax=data['c']*data['m']+0.2)
                
               }
