class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        
        #Pick 2 distinct coefficients
        coeff=[1,2,3, 1/2, 1/3]
        shuffle(coeff)
        
        a=coeff[0]
        b=coeff[1]
        
        #pick a random surface
        
        surfaces = [a*x^2+b*y^2, a*x^2-b*y^2, -a*x^2+b*y^2, a*x^2+b*y, a*x^2-b*y, -a*x^2+b*y, a*x+b*y^2, a*x-b*y^2, -a*x+b*y^2,
                    b*x^2+a*y^2, b*x^2-a*y^2, -b*x^2+a*y^2, b*x^2+a*y, b*x^2-a*y, -b*x^2+a*y, b*x+a*y^2, b*x-a*y^2, -b*x+a*y^2
                   ]
        shuffle(surfaces)
        surface=surfaces[0]
        
        choices=[surfaces[0], surfaces[1], surfaces[2], surfaces[3], surfaces[4]]
        shuffle(choices)
        
        
        
        
        return {
            "surface": surface,
            "choice0": choices[0],
            "choice1": choices[1],
            "choice2": choices[2],
            "choice3": choices[3],
            "choice4": choices[4],
            #"slope": m,
            #"intercept": b,
        }

    @provide_data
    def graphics(data):
        # updated by clontz
        return {"surface": plot3d(data['surface'], (x, -2, 2), (y, -2, 2)), 
                "contour": contour_plot(data['surface'], (x,-2,2), (y,-2,2), fill=False, plot_points=100, labels=True)
               }

