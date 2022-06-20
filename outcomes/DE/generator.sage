class Generator(BaseGenerator):
    def data(self):
       
        var('x y t')
        #pick a function
        x0=randint(-3,3)
        y0=randint(-3,3)
        
        f(x,y) = choice([
                #randint(1,5)*choice([-1,1])*(x-x0)^2+randint(1,5)*choice([-1,1])*(y-y0)^2+ randint(1,5)*choice([-1,1])*(x-x0)*(y-y0),
                #exp(randint(1,5)*choice([-1,1])*(x-x0)^2+randint(1,5)*choice([-1,1])*(y-y0)^2+ randint(1,5)*choice([-1,1])*(x-x0)*(y-y0)),
                (x+y)*exp((x-x0)/randint(-5,-1)+(y-y0)/randint(-5,1))
            ])
        
        fx(x,y) = f(x,y).derivative(x)
        fy(x,y) = f(x,y).derivative(y)
        
        
        #pick 3 points
        x1=randint(-3,3)
        y1=randint(-3,3)
        k2=choice([-1,1])
        k3=choice([-1,1])
        
        x2=x1
        y2=y1+randint(1,5)*k2
        
        x3=x1+abs(y2-y1)*k3 #x1+randint(1,4)*k3
        y3=y1
        
        #Find critical points
        
        #initial critical points
        cp=[[x1,y1],[x2,y2],[x3,y3]]
        
        #find valid zeroes of gradient
        
        zeroes=solve([fx(x,y)==0,fy(x,y)==0],x,y)
        
        for i in range(len(zeroes)):
            xi=zeroes[i][0].rhs()
            yi=zeroes[i][1].rhs()
            if ((xi-x1)*k3>=0 and (yi-y1)*k2>=0 and ((y2-y3)*(xi-x2)+(x3-x2)*(yi-y2))*k2*k3*(-1)>=0):
                cp.append([xi, yi])
        
        #find zeroes vertical line
        
        f2(y)=f(x1,y)
        zeroes=solve([f2(y).derivative(y)==0],y)
        for i in range(len(zeroes)):
            yi=zeroes[i].rhs()
            if (yi<max(y2,y1) and yi>min(y2,y1)):
                cp.append([x1, yi])
                
        #find zeroes vertical line
        
        f3(x)=f(x,y1)
        zeroes=solve([f3(x).derivative(x)==0],x)
        for i in range(len(zeroes)):
            xi=zeroes[i].rhs()
            if (xi<max(x3,x1) and xi>min(x3,x1)):
                cp.append([xi, y1])        
        
        
        #find zeroes slant line
        l(x)=(y3-y2)/(x3-x2)*(x-x2)+y2
        f4(x)=f(x,l(x))
        zeroes=solve([f4(x).derivative(x)==0],x)
        for i in range(len(zeroes)):
            xi=zeroes[i].rhs()
            if (xi<max(x3,x1) and xi>min(x3,x1)):
                cp.append([xi, y1]) 
        
        #compute min value
        
        minvalue=f(x1,y1)
        
        for i in range(len(cp)):
            if f(cp[i][0], cp[i][1])<minvalue:
                minvalue=f(cp[i][0], cp[i][1])
        
        #find solutions for min value
        
        minsolns=[]
        for i in range(len(cp)):
            if f(cp[i][0], cp[i][1])==minvalue:
                minsolns.append(cp[i])
        
        #compute max value
        
        maxvalue=f(x1,y1)
        
        for i in range(len(cp)):
            if f(cp[i][0], cp[i][1])>maxvalue:
                maxvalue=f(cp[i][0], cp[i][1])
        
        #find solutions for max value
        
        maxsolns=[]
        for i in range(len(cp)):
            if f(cp[i][0], cp[i][1])==maxvalue:
                maxsolns.append(cp[i])
                
        return {
            "f": f(x,y),
            "x1": x1,
            "y1": y1,
            "x2": x2,
            "y2": y2,
            "x3": x3,
            "y3": y3,
            "cp": cp,
            "minvalue": minvalue,
            "maxvalue": maxvalue,
            "minsolns": minsolns,
            "maxsolns": maxsolns,
            
        }

    #@provide_data
    #def graphics(data):
        # updated by clontz
    #    return {#"param": parametric_plot3d([data['f0'], data['g0'], data['h0']], (t, -2, 2))
    #            "contour": contour_plot(data['surface'], (x,data['min'],data['max']), (y,data['ymin'],data['ymax']), fill=False, plot_points=400, #labels=True, contours=data['tours'])+point2d(data['c2'],size=30,rgbcolor=(0.5,0,0))
    #           }

