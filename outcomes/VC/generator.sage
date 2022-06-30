class Generator(BaseGenerator):
    def data(self):
        var('x y z t')
        
        
        functions=[x-y*z, y-x*z, z-x*y, x*e^y, x*e^z, y*e^z, y*e^z, z*e^x, z*e^y, x^randint(1,2)*y^randint(1,2), x^randint(1,2)*z^randint(1,2), z^randint(1,2)*y^randint(1,2),]
        
        
        normvec=vector([0,0,0])
        
        while normvec==vector([0,0,0]):
            Fx=randint(1,4)*choice([-1,1])*choice(functions)
            Fy=randint(1,4)*choice([-1,1])*choice(functions)
            Fz=randint(1,4)*choice([-1,1])*choice(functions)
            P=(randint(-5,5), randint(-5,5), randint(-5,5))
        
            Fxdy=Fx.derivative(y)
            Fxdz=Fx.derivative(z)
            Fydx=Fy.derivative(x)
            Fydz=Fy.derivative(z)
            Fzdx=Fz.derivative(x)
            Fzdy=Fz.derivative(y)
        
            curl(x,y,z)=vector([Fzdy-Fydz, Fxdz-Fzdx, Fydx-Fxdy])
            normvec=curl(P[0], P[1], P[2])
        
        L=(normvec[0]*t+P[0], normvec[1]*t+P[1], normvec[2]*t+P[2])
        
        
        circdens=choice(['positive', 'negative', 'zero'])
        
        if circdens=='positive':
            fx=-y
            fy=x*uniform(0.8,1.2)
        
        if circdens=='negative':
            fx=y
            fy=-x*uniform(0.8,1.2)
        
        if circdens=='zero':
            fx=randint(1,5)*choice([-1,1])
            fy=randint(1,5)*choice([-1,1])
        
        Q=(randint(-5,5), randint(-5,5))
        
        
        
        
        return {
            "curl": curl(x,y,z),
            "L": L,
            "normvec": normvec,
            "Fx": Fx,
            "Fy": Fy,
            "Fz": Fz,
            "P": P,
            "Q": Q,
            "circdens": circdens,
            "fx": fx/(fx^2+fy^2)^(1/2),
            "fy": fy/(fx^2+fy^2)^(1/2),
            
            
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "field":plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10), color=['blue'])+point(data['Q'],color='red', size=30)+text("$Q$", (data['Q'][0]-0.2, data['Q'][1]), horizontal_alignment='right', color='red')
            
            
            #"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
           }

