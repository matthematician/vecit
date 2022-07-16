class Generator(BaseGenerator):
    def data(self):
        from sage.symbolic.integration.integral import definite_integral
        var('x y z t s')
        
        
        functions=[y*z, x*z, x*y, x^2, y^2, z^2, x+y, x+z, y+z]
        
        
        F1=randint(1,4)*choice([-1,1])*choice(functions)
        F2=randint(1,4)*choice([-1,1])*choice([x,y,z])
        F3=randint(-5,5)
        
        Fvec=[F1, F2, F3]
        
        shuffle(Fvec)
        
        F(x,y,z)=vector(Fvec)
        
        surface=choice(['helicoid', 'cone', 'arcthing'])
        
        
       
        if surface=='cone':
            tmin=0
            tmax=2*pi
            smin=0
            smax=randint(1,4)
            k=randint(-5,5)
            r1(s,t)=s*cos(t)
            r2(s,t)=s*sin(t)
            r3(s,t)=choice([-1,1])*randint(1,3)*s+k
        
        if surface=='helicoid':
            tmin=0
            tmax=2*pi
            smin=0
            smax=randint(1,4)
            k=randint(-5,5)
            r1(s,t)=s*cos(t)
            r2(s,t)=s*sin(t)
            r3(s,t)=choice([-1,1])*randint(1,3)*t+k
            
        if surface=='arcthing':
            k=randint(-5,5)
            l=randint(1,3)
            tmin=k-1
            tmax=k+l
            smin=randint(-5,1)
            smax=smin+randint(3,8)
            r1(s,t)=s
            r2(s,t)=t
            r3(s,t)=choice([-1,1])*randint(1,3)*(t-k)^2+randint(-5,5)    
        
        rvec=[r1(s,t), r2(s,t), r3(s,t)]
        shuffle(rvec)
        R(s,t)=vector(rvec)
        
        Rs(s,t)=vector([R(s,t)[0].derivative(s), R(s,t)[1].derivative(s), R(s,t)[2].derivative(s)])
        Rt(s,t)=vector([R(s,t)[0].derivative(t), R(s,t)[1].derivative(t), R(s,t)[2].derivative(t)])
        
        integrand=F(R(s,t)[0], R(s,t)[1], R(s,t)[2]).dot_product(Rs(s,t).cross_product(Rt(s,t)))
        
        integ= definite_integral( definite_integral(integrand, s, smin, smax ) ,t, tmin, tmax)
        
        
        #  2d problem
        
        theta=uniform(0, 2*pi)

        fx=cos(theta)
        fy=sin(theta)


        theta1=theta
        theta2=theta
        flux=choice(['positive', 'negative'])

        while abs(abs(theta-theta1)-abs(theta-theta2))<pi/6:
            theta1=theta+uniform(-pi/2+0.1, pi/2-0.1)
            theta2=theta+uniform(-pi/2+0.1, pi/2-0.1)
            if flux=='negative':
                theta1=theta1+pi
                theta2=theta2+pi


        P=(uniform(-3, -2), uniform(-7,7))
        Pr=(P[0]+cos(theta1-pi/2)*2, P[1]+sin(theta1-pi/2)*2)
        Pl=(P[0]+cos(theta1+pi/2)*2, P[1]+sin(theta1+pi/2)*2)
        Pv=(P[0]+cos(theta1)*2, P[1]+sin(theta1)*2)
        Ptext=(P[0]-cos(theta1), P[1]-sin(theta1))

        Q=(uniform(2, 3), uniform(-7,7))
        Qr=(Q[0]+cos(theta2-pi/2)*2, Q[1]+sin(theta2-pi/2)*2)
        Ql=(Q[0]+cos(theta2+pi/2)*2, Q[1]+sin(theta2+pi/2)*2)
        Qv=(Q[0]+cos(theta2)*2, Q[1]+sin(theta2)*2)
        Qtext=(Q[0]-cos(theta2), Q[1]-sin(theta2))

        Pdot=cos(theta)*cos(theta1)+sin(theta)*sin(theta1)
        Qdot=cos(theta)*cos(theta2)+sin(theta)*sin(theta2)

        if Pdot>Qdot:
            greaterflux=1
        if Qdot>Pdot:
            greaterflux=2    
        
        
        
        
        return {
            "F": F(x,y,z),
            "Fst": F(R(s,t)[0], R(s,t)[1], R(s,t)[2]),
            "R": R(s,t),
            "Rs": Rs(s,t),
            "Rt": Rt(s,t),
            "smin": smin,
            "smax": smax,
            "tmin": tmin,
            "tmax": tmax,
            "integrand": integrand,
            "integ": integ,
            "surface": surface,
            #
            "fx": fx,
            "fy": fy,
            "P": P,
            "Pl": Pl,
            "Pr": Pr,
            "Pv": Pv,
            "Ptext": Ptext,
            "Q": Q,
            "Ql": Ql,
            "Qr": Qr,
            "Qv": Qv,
            "Qtext": Qtext,
            "greaterflux": greaterflux,
            "flux": flux,
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "field":plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10), color=['blue'], aspect_ratio=1)+text("$\mathbf{S_2}$", data['Qtext'],  color='green')+line([data['Ql'], data['Qr']], color='green')+arrow(data['Q'], data['Qv'], color='green')+text("$\mathbf{S_1}$", data['Ptext'],  color='red')+line([data['Pl'], data['Pr']], color='red')+arrow(data['P'], data['Pv'], color='red')
            
            #plot_vector_field((fx, fy), (x,-10,10),(y,-10,10), color=['blue'], aspect_ratio=1)+point(P, color="red")+line([Pl, Pr], color='red')+arrow(P, Pv, color='red')+point(Q, color="green")+line([Ql, Qr], color='green')+arrow(Q, Qv, color='green')
            
            #"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
           }

