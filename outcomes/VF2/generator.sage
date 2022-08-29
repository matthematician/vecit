class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y z t s')
        
        X=[x,y,z]
        
        #surface->bound
        
        
        functions=[x,y,z,  x*y, x*z, y*z,x+z, y+z, x+y, x-y, x-z, y-z, x^2, y^2, z^2 ]
        
        
        F10=randint(1,4)*choice([-1,1])*choice(functions)
        F11=randint(1,4)*choice([-1,1])*choice(functions)
        F12=randint(1,4)*choice([-1,1])*choice(functions)
        
        F1(x,y,z)=vector([F10, F11, F12])
        

        
        surface1=choice(['sphere', 'paraboloid'])
        
        radius=randint(2,10)
        cutoff=randint(4,10)
        
        cutv=choice([x,y,z])
        
        f1(t)=radius*cos(t)
        f2(t)=radius*sin(t)
        f3(t)=cutoff
        
        if surface1=='sphere':
            k=radius^2+cutoff^2
            surface1eqn=x^2+y^2+z^2
            
        if surface1=='paraboloid':
            k=radius^2-cutoff
            if cutv==x:
                surface1eqn=y^2+z^2-x
            if cutv==y:
                surface1eqn=x^2+z^2-y    
            if cutv==z:
                surface1eqn=x^2+y^2-z    
        if cutv==x:
            R1(t)=vector([f3(t),f1(t), f2(t)])
        if cutv==y:
            R1(t)=vector([f2(t),f3(t), f1(t)])
        if cutv==z:
            R1(t)=vector([f1(t),f2(t), f3(t)])
            
        tmin=0
        tmax=2*pi
        
        F1t(t)=F1(R1(t)[0], R1(t)[1], R1(t)[2])
        R1t(t)=vector([R1(t)[0].derivative(t), R1(t)[1].derivative(t), R1(t)[2].derivative(t)])
        
        integrand1=F1t(t).dot_product(R1t(t))
        
        integ1=definite_integral(integrand1, t, tmin, tmax)
        
        
        
        
        
        
        
        a=randrange(1,11)
        b=randrange(1,11)
        c=randrange(1,11)
        
        
        
        v1=vector([0,0,0])
        
        vshift=choice([x,y,z])
        
        surface2=choice(['triangle', 'rectangle'])
        
        if surface2=='triangle':
            if vshift==x:
                v2=vector([a,0,0])
                v3=vector([a,b,c])
                surface2eqn=c*y-b*z
                X1=x
                X1min=0
                X1max=a
                X2=y
                X2min=0
                X2max=Rational(b)/a*x
                f(x,y)=(x,y,Rational(c)/b*y)
                V=[v1, v2, v3]
                normvec(X1, X2)=vector([0,c,-b])
                k2=0
            if vshift==y:
                v2=vector([0,a,0])
                v3=vector([c,a,b])
                surface2eqn=b*x-c*z
                X1=y
                X1min=0
                X1max=a
                X2=z
                X2min=0
                X2max=Rational(b)/a*y
                f(y,z)=(Rational(c)/b*z,y,z)
                V=[v1, v2, v3]
                normvec(X1, X2)=vector([b,0,-c])
                k2=0
            if vshift==z:
                v2=vector([0,0,a])
                v3=vector([b,c,a])
                surface2eqn=c*x-b*y
                X1=z
                X1min=0
                X1max=a
                X2=x
                X2min=0
                X2max=Rational(b)/a*z
                f(z,x)=(x,Rational(c)/b*x,z)
                V=[v1, v2, v3]   
                normvec(X1, X2)=vector([c,-b,0])
                k2=0
        
        if surface2=='rectangle':
            if vshift==x:
                v2=vector([a,0,0])
                v3=vector([a,b,c])
                v4=vector([0,b,c])
                surface2eqn=c*y-b*z
                X1=x
                X1min=0
                X1max=a
                X2=y
                X2min=0
                X2max=b
                f(x,y)=(x,y,Rational(c)/b*y)
                V=[v1, v2, v3, v4]
                normvec(X1, X2)=vector([0,c,-b])
                k2=0
            if vshift==y:
                v2=vector([0,a,0])
                v3=vector([c,a,b])
                v4=vector([c,0,b])
                surface2eqn=b*x-c*z
                X1=y
                X1min=0
                X1max=a
                X2=z
                X2min=0
                X2max=b
                f(y,z)=(Rational(c)/b*z,y,z)
                V=[v1, v2, v3, v4]
                normvec(X1, X2)=vector([b,0,-c])
                k2=0
            if vshift==z:
                v2=vector([0,0,a])
                v3=vector([b,c,a])
                v4=vector([b,c,0])
                surface2eqn=c*x-b*y
                X1=z
                X1min=0
                X1max=a
                X2=x
                X2min=0
                X2max=b
                f(z,x)=(x,Rational(c)/b*x,z)
                V=[v1, v2, v3, v4]   
                normvec(X1, X2)=vector([c,-b,0])
                k2=0
        
        F20(x,y,z)=randint(1,4)*choice([-1,1])*choice(functions)
        F21(x,y,z)=randint(1,4)*choice([-1,1])*choice(functions)
        F22(x,y,z)=randint(1,4)*choice([-1,1])*choice(functions)
        
        F2(x,y,z)=vector([F20(x,y,z), F21(x,y,z), F22(x,y,z)])
        
        curlF2(x,y,z)=vector([F22(x,y,z).derivative(y)-F21(x,y,z).derivative(z) , -(F22(x,y,z).derivative(x)-F20(x,y,z).derivative(z)) , F21(x,y,z).derivative(x)-F20(x,y,z).derivative(y) ])
        curlF2flat(X1, X2)=curlF2( f(X1,X2)[0] , f(X1,X2)[1] , f(X1,X2)[2])
        
        #curlF20(x,y,z) = curlF2(x,y,z)[0]
        #curlF21(x,y,z) = curlF2(x,y,z)[1]
        #curlF22(x,y,z) = curlF2(x,y,z)[2]
        
        #curlF2flat(X1, X2)=vector([ curlF20( f(X1, X2)[0] , f(X1, X2)[1] , f(X1, X2)[2] ), curlF21( f(X1, X2)[0] , f(X1, X2)[1] , f(X1, X2)[2] ) , curlF22( f(X1, X2)[0] , f(X1, X2)[1] , f(X1, X2)[2] ) ])
        
        
        integrand2=normvec(X1,X2).dot_product( curlF2flat(X1,X2) )
        integ2 = definite_integral( definite_integral( integrand2, X2, X2min, X2max ), X1, X1min, X1max )
        
        
        
        
        return {
            "F1": F1(x,y,z),
            "F1t": F1t(t),
            "R1": R1(t),
            "R1t": R1t(t),
            "tmin": tmin,
            "tmax": tmax,
            "integrand1": integrand1,
            "integ1": integ1,
            "surface1": surface1,
            "cutv": cutv,
            "cutoff": cutoff,
            "k": k,
            "surface1eqn": surface1eqn,
            #
            "F2": F2(x,y,z),
            "curlF2": curlF2(x,y,z),
            "curlF2flat": curlF2flat(X1, X2),
            "normvec": normvec(X1,X2),
            "V": V,
            "surface2eqn": surface2eqn,
            "surface2": surface2,
            "X1": X1,
            "X1min": X1min,
            "X1max": X1max,
            "X2": X2,
            "X2min": X2min,
            "X2max": X2max,
            "integrand2": integrand2,
            "integ2": integ2,
            "k2": k2,
            "f": f(X1, X2),
        }
    
#    @provide_data
#    def graphics(data):
    # updated by clontz
#        return {
#            "field":plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10), color=['blue'], aspect_ratio=1)+text("$\mathbf{S_2}$", data['Qtext'],  color='green')+line([data['Ql'], data['Qr']], color='green')+arrow(data['Q'], data['Qv'], color='green')+text("$\mathbf{S_1}$", data['Ptext'],  color='red')+line([data['Pl'], data['Pr']], color='red')+arrow(data['P'], data['Pv'], color='red')
            
            #plot_vector_field((fx, fy), (x,-10,10),(y,-10,10), color=['blue'], aspect_ratio=1)+point(P, color="red")+line([Pl, Pr], color='red')+arrow(P, Pv, color='red')+point(Q, color="green")+line([Ql, Qr], color='green')+arrow(Q, Qv, color='green')
            
            #"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
#           }

