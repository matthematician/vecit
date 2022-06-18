class Generator(BaseGenerator):
    def data(self):
        # Display (gradient) vector field, ask for multiple choice formula, match up with multiple-choice contour plot
        var('x y')
        k=0
        while(k^3 == k):
            k = randint(-4,4)
        # Choose h and j to be harmonic conjugate functions    
        h_choices = [x^2+k*x-y^2,x^3 + k*x^2 - (k+3*x)*y^2  ,x^3-3*x*y^2+k*x,-x+sqrt(x^2+y^2), x-sqrt(x^2+y^2) ]
        j_choices = [(2*x+k)*y, -y^3 + 3*x^2*y + 2*k*x, -y^3 + 3*x^2*y +k*y,x+sqrt(x^2+y^2), -x-sqrt(x^2+y^2) ]
        
        i = randrange(0,5)
        
        tours = 18 # Number of contours
        
        if(choice([True,False])):
            h(x,y) = h_choices[i]
            j(x,y) = j_choices[i]
        else:
            h(x,y) = j_choices[i]
            j(x,y) = h_choices[i]
        
        f(x,y) = [h(x,y).derivative(x), h(x,y).derivative(y)]
        g(x,y) = [j(x,y).derivative(x), j(x,y).derivative(y)] # f, rotated 90 degrees CCW
        f1(x,y) = [ f[0](y,x), f[1](y,x) ]
        g1(x,y) = [ g[0](y,x), g[1](y,x) ]
        
        fields = [{"fx": field[0](x,y), "fy": field[1](x,y)} for field in [f,g,f1,g1]]
        
        shuffle(fields)
        
        cplots = [{"cplotno":"a"},{"cplotno":"b"},{"cplotno":"c"},{"cplotno":"d"}]
        plotfs(x,y) = [h(x,y), j(x,y), -1*h(x,y), -1*j(x,y)]
        
        n = [0,1,2,3]
        shuffle(n)
        
        
        return {
            "fx": f[0](x,y),
            "fy": f[1](x,y),
            "fieldchoices": fields,
            "cplots": cplots,
            "plotfs": [plotfs[n[0]],plotfs[n[1]],plotfs[n[2]],plotfs[n[3]],],
            "potential": h(x,y),
            "tours": tours,
            "n": n,
            "rightplot": cplots[n.index(0)]['cplotno']
            
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {"field": plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10)) , "cplota":contour_plot(data['plotfs'][0],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotb":contour_plot(data['plotfs'][1],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True, label_fmt=lambda x: "$%1.0f$"%x), "cplotc":contour_plot(data['plotfs'][2],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplotd":contour_plot(data['plotfs'][3],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x), "cplot5":contour_plot(data['potential'],(x,-10,10),(y,-10,10), fill=False, contours=data['tours'], labels=True, label_inline=True,  label_fmt=lambda x: "$%1.0f$"%x)+plot_vector_field((data['fx'], data['fy']), (x,-10,10),(y,-10,10))    
           }
