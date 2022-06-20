class Generator(BaseGenerator):
    def data(self):
        var('x y t')
        [m,n]=[0,0]
        while(m*n==0):
            [m,n]=[randint(-3,3),randint(1,2)]
        exprs=[
                m,
                n,
                m*x,
                n*y,
                m*x*y,
                m*x + n*y,
                x^n,
                y^n,
                m*x^n*y,
                m*x*y^n,
            ]
        fx(x,y) = 1
        fy(x,y) = 1
        while(fy(x,y).derivative(x)-fx.derivative(y)==0): # Don't let them use fundamental theorem lol
            [i,j]=[2*randint(0,4),2*randint(0,4)+1]
            
            fx(x,y) = 2*exprs[i]
            fy(x,y) = 2*exprs[j]
        
        p = vector((0,0))
        q = vector((0,0))
        while(p==q):
            p = vector((randint(-4,4),randint(-4,4)))        
            q = vector((randint(-4,4),randint(-4,4)))        

        if(choice([True,False])): # Line or semicircle
            [ta,tb]=[0,1]
            r(t) = vector((1-t)*p + t*q)
            rr(t)= [r(t)[0].derivative(t),r(t)[1].derivative(t)]
            integrand = fx(r(t)[0],r(t)[1])*rr(t)[0]+fy(r(t)[0],r(t)[1])*rr(t)[1]
            result = integrate(integrand, t, ta, tb)
            ctype = "line segment"
        else:
            k=choice([0,1,2,3]) # North, south, east, west semicircle
            if(k<=1): #north or south
                p = vector((-1*randint(1,4),randint(-4,4)))
                q = vector((-1*p[0],p[1]))
                ta=0
                tb=pi
                radius = abs(p[0])
                r(t) = [radius*cos(t),(-1)^k*radius*sin(t)+p[1]]
                rr(t)= [r(t)[0].derivative(t),r(t)[1].derivative(t)]
                integrand = fx(r(t)[0],r(t)[1])*rr(t)[0]+fy(r(t)[0],r(t)[1])*rr(t)[1]
                result = integrate(integrand, t, ta, tb)
                if(k==0):
                    ctype = "upper half of the semicircle"
                if(k==1):
                    ctype = "lower half of the semicircle"
            if(k>=2): #east or west
                p = vector((randint(-4,4),randint(1,4)))
                q = vector((p[0],-1*p[1]))
                ta=0
                tb=pi
                radius = abs(p[1])
                r(t) = [p[0]+(-1)^k*radius*sin(t),radius*cos(t)]
                rr(t)= [r(t)[0].derivative(t),r(t)[1].derivative(t)]
                integrand = fx(r(t)[0],r(t)[1])*rr(t)[0]+fy(r(t)[0],r(t)[1])*rr(t)[1]                
                result = integrate(integrand, t, ta, tb)
                if(k==2):
                    ctype = "right half of the semicircle"
                if(k==3):
                    ctype = "left half of the semicircle"
            
            
            
            
        return {
            "fx": fx(x,y),
            "fy": fy(x,y),
            "rx": r(t)[0],
            "ry": r(t)[1],
            "ctype": ctype,
            "ta": ta,
            "tb": tb,
            "p": p,
            "q": q,
            "integrand": integrand,
            "result": result
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {"plot": plot_vector_field((data['fx'],data['fy']),(x,-5,5),(y,-5,5))+parametric_plot((data['rx'],data['ry']),(t,data['ta'],data['tb']))+point(data['p'],size=24)+point(data['q'],size=24)+text(' $P(%s,%s)$'%(data['p'][0],data['p'][1]),data['p'],horizontal_alignment="left",vertical_alignment="top")+text(' $Q(%s,%s)$'%(data['q'][0],data['q'][1]),data['q'],horizontal_alignment="left",vertical_alignment="bottom")
            }
