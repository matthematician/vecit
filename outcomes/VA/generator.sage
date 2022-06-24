class Generator(BaseGenerator):
    def data(self):
        # Display (gradient) vector field, ask for multiple choice formula, match up with multiple-choice contour plot
        var('x y t')
        
        intvalue=choice(['positive', 'negative', 'zero'])
        scenario=randint(0,1)
        
        if scenario==0:
            fx=-y/(x^2+y^2)^(1/2)
            fy=x/(x^2+y^2)^(1/2)

            
            c=choice([1, 1.2, 0.8])
            k=randint(3,7)
            theta0=randint(-10,10)/10
            if intvalue=='positive':
                rx(t)=k*cos(pi*(t+theta0))
                ry(t)=c*k*sin(pi*(t+theta0))
            if intvalue=='negative':
                rx(t)=k*cos(pi*((1-t)+theta0))
                ry(t)=c*k*sin(pi*((1-t)+theta0))
            if intvalue=='zero':
                x0=randint(1, 7)*choice([-1,1])
                y0=randint(1, 7)*choice([-1,1])
                rx(t)=-x0+2*x0*t
                ry(t)=-y0+2*y0*t
            
            
            
        if scenario==1:
            dx=randint(3,5)
            dy=randint(3,5)
            signx=choice([-1,1])
            signy=choice([-1,1])
            fx=dx/5*signx
            fy=dy/5*signy
            
            if intvalue=='positive':
                x0=randint(-7,-3)*signx
                y0=randint(-7,-3)*signy
                x1=randint(3,7)*signx
                y1=randint(3,7)*signy
                rx(t)=(x0+(x1-x0)*t)
                ry(t)=(y0+(y1-y0)*t)
            if intvalue=='negative':
                x0=randint(-7,-3)*signx*(-1)
                y0=randint(-7,-3)*signy*(-1)
                x1=randint(3,7)*signx*(-1)
                y1=randint(3,7)*signy*(-1)
                rx(t)=(x0+(x1-x0)*t)
                ry(t)=(y0+(y1-y0)*t)    
            if intvalue=='zero':
                x0=randint(-5,-1)*signx
                y0=randint(-5,-1)*signy*(-1)
                x1=-1*x0
                y1=y0+(x1-x0)*(-1)*fx/fy
                rx(t)=(x0+(x1-x0)*t)
                ry(t)=(y0+(y1-y0)*t) 
                
            
        
        P=(rx(0), ry(0))
        Q=(rx(1), ry(1))
        
        return {
            "fx": fx,
            "fy": fy,
            "rx": rx(t),
            "ry": ry(t),
            "intvalue": intvalue,
            "P": P,
            "Q": Q,
            
            
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {
            "field":plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10), color=['blue'])+parametric_plot( (data['rx'], data['ry']), (t, 0, 1), color='red', thickness=2, )+point(data['P'],color='red', size=30)+point(data['Q'],color='red', size=30)+text("$P$", data['P'], horizontal_alignment='left', color='red')+text("$Q$", data['Q'], horizontal_alignment='right', color='red'),
            
            
            #"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
           }
