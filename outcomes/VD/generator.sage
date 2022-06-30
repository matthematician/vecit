class Generator(BaseGenerator):
    def data(self):
        var('x y z t')
        
        
        functions=[x-y*z, y-x*z, z-x*y, x*e^y, x*e^z, y*e^z, y*e^z, z*e^x, z*e^y, x^randint(1,2)*y^randint(1,2), x^randint(1,2)*z^randint(1,2), z^randint(1,2)*y^randint(1,2),]
        
        
        Fx=randint(1,4)*choice([-1,1])*choice(functions)
        Fy=randint(1,4)*choice([-1,1])*choice(functions)
        Fz=randint(1,4)*choice([-1,1])*choice(functions)
        P=(randint(-5,5), randint(-5,5), randint(-5,5))
        
        Fxdx=Fx.derivative(x)
        Fydy=Fy.derivative(y)
        Fzdz=Fz.derivative(z)
        
        div(x,y,z)=Fxdx+Fydy+Fzdz
        divP=div(P[0], P[1], P[2])
        
        
        
        k=randint(2,6)
        x0=randint(-3,3)
        y0=randint(-3,3)
        sign=choice([-1,1])

        fx=((x-x0)^3-(x-x0)*k^2)*sign
        fy=((y-y0)^3-(y-y0)*k^2)*sign
        
        Q=(x0,y0)
        
        R=(x0+choice([-1,1])*k, y0+choice([-1,1])*k)
        
        if sign==1:
            divQ='negative'
            divR='positive'
        
        if sign==-1:
            divQ='positive'
            divR='negative'
        
        
        
        return {
            "div": div(x,y,z),
            "divP": divP,
            "divQ": divQ,
            "divR": divR,
            "Fx": Fx,
            "Fy": Fy,
            "Fz": Fz,
            "P": P,
            "Q": Q,
            "R": R,
            "fx": fx/(fx^2+fy^2)^(1/2),
            "fy": fy/(fx^2+fy^2)^(1/2),
            
            
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "field":plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10), color=['blue'])+point(data['Q'],color='red', size=30)+text("$Q$", (data['Q'][0]-0.2, data['Q'][1]), horizontal_alignment='right', color='red')+point(data['R'],color='red', size=30)+text("$R$", (data['R'][0]-0.2, data['R'][1]), horizontal_alignment='right', color='red')
            
            
            #"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
           }

