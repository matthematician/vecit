class Generator(BaseGenerator):
    def data(self):
        var('x y')
        
        # Choose a slew of integer lattice points
        [h,k,s,a,b,i,j,k] = [0,0,0,0,0,0,0,0]
        while( i==h or k==j or h==0 or k==0):
            [h,k,s,a,b,i,j,k] = [randrange(-5,5),randrange(-5,5),choice([-1,1]),randrange(1,5),randrange(1,5),randrange(-5,5),randrange(-5,5),randrange(-5,5)]
        
        boundings = [
            {"version": 0, "bound0": x^2 + y^2 ==-1, "bound1": x == y^2 * h/k/k, "bound2": x + s*y == h+s*k , "bound1text": "", "xrange": sorted([h,h+k+s*k+s*k^2/h]), "yrange": sorted([k,-k-s*k^2/h]), "xshade": [y^2*h/k/k, h+s*(k-y)], "yshade": [-s*sqrt(k^2*x/h), s*(h+s*k-x)], "type1": "As a Type-1 region this requires two pieces, one of which is ", "type2": "This region is best described with the Type-2 inequalities "} ,
            {"version": 1, "bound0": x^2+y^2 == -1, "bound1": y == x^2 * k/h/h, "bound2": x + s*y == h+s*k , "bound1text": "", "xrange": sorted([h,-h-s*h^2/k]), "yrange": sorted([k,k+h^2/k]), "xshade": [-s*sqrt(h^2*y/k), h+s*(k-y)], "yshade": [x^2*k/h/h, s*(h+s*k-x)], "type2": "As a Type-2 region this requires two pieces, one of which is ", "type1": "This region is best described with the Type-1 inequalities "},
            {"version": 2, "bound0": x == i, "bound1": y == QQ(b/(i-h))*(x-h)+k, "bound2": y == QQ(a/(h-i))*(x-h)+k , "bound1text": "the line "+str(x == i)+" and ", "xrange": sorted([i,h]), "yrange": [k-a,k+b], "yshade": [QQ(a/(h-i))*(x-h)+k, QQ(b/(i-h))*(x-h)+k], "xshade": [i , QQ((h-i)/a)*(y-k) + h], "type2": "As a Type-2 region this requires two pieces, one of which is ", "type1": "This region is best described with the Type-1 inequalities " },
            {"version": 3, "bound0": y==j, "bound1": y==QQ((k-j)/a)*(x-h)+k, "bound2": y==QQ((j-k)/b)*(x-h)+k , "bound1text": "the line "+str(y==j)+" and ", "xrange": [h-a,h+b], "yrange": sorted([j,k]), "xshade":  [(y-k)*a/(k-j) + h , (y-k)*b/(j-k) + h] , "yshade": [j , QQ((k-j)/a)*(x-h)+k], "type1": "As a Type-1 region this requires two pieces, one of which is ", "type2": "This region is best described with the Type-2 inequalities " },
        ]
        
        shuffle(boundings)
        reg = boundings[0]
        
        
        #solve intersections
        intx=[0]
        inty=[0]
        soln=solve([reg['bound0'], reg['bound1']], x,y)
        soln=soln+solve([reg['bound0'], reg['bound2']], x,y)
        soln=soln+solve([reg['bound1'], reg['bound2']], x,y)
        
        for i in range(len(soln)):
            if soln[i][0].rhs() in RR and soln[i][1].rhs() in RR:
                intx.append(soln[i][0].rhs())
                inty.append(soln[i][1].rhs())
        
        xup=max(intx)+0.2
        xdown=min(intx)-0.2
        yup=max(inty)+0.2
        ydown=min(inty)-0.2
        
        
        if(reg['version']==2 and h < i):
            reg['xshade'].reverse()
        
        if(reg['version']==3 and k < j):
            reg['yshade'].reverse()
        
        return {
            "line": reg['bound0'],
            "graph1": reg['bound1'],
            "graph2": reg['bound2'],
            "linetext": reg['bound1text'],
            "aychkay": vector([h,k]),
            "xmin": QQ(reg['xrange'][0]),
            "xmax": QQ(reg['xrange'][1]),
            "ymin": QQ(reg['yrange'][0]),
            "ymax": QQ(reg['yrange'][1]),
            "xshademin": reg['xshade'][0],
            "xshademax": reg['xshade'][1],
            "yshademin": reg['yshade'][0],
            "yshademax": reg['yshade'][1],
            "type1": reg['type1'],
            "type2": reg['type2'],
            "xup": xup,
            "xdown": xdown,
            "yup": yup,
            "ydown": ydown,
        }

    @provide_data
    def graphics(data):
        # updated by clontz
         return {"region": implicit_plot(data['line'],(x,data['xdown'],data['xup']),(y,data['ydown'],data['yup']), axes=True)+implicit_plot(data['graph1'],(x,data['xdown'],data['xup']),(y,data['ydown'],data['yup']), axes=True)+implicit_plot(data['graph2'],(x,data['xdown'],data['xup']),(y,data['ydown'],data['yup']), axes=True)
               }
            