class Generator(BaseGenerator):
    def data(self):
        var('x y t n')
        chaff = [ # Single-variable chaff to clutter up the vector field formula
            sin(n)^2,
            exp(n^2),
            randint(2,5)*choice([-1,1])*n^randint(2,6),
            sqrt(1+n^(2*randint(1,4))),
            n/(n^(randint(1,4)*2)+randint(1,6))
        ]
        shuffle(chaff)
        
        C(y) = chaff[0].subs(n=y)
        D(x) = chaff[1].subs(n=x)
         # Randomly generate a nonoverlapping set of rectangles/triangles all of whose areas are distinct
        
        m = 9
        areas = [0,0,0]
        while(m>8 or len(set(areas))<3):
            gaps = [randint(0,2),randint(1,2),randint(1,2),randint(0,2)]
            widths = [randint(3,6),randint(3,6),randint(3,6)]
            [h,i,j,k,l,m] = [-8+gaps[0],-8+gaps[0]+widths[0],-8+gaps[0]+widths[0]+gaps[1],-8+gaps[0]+widths[0]+gaps[1]+widths[1],-8+gaps[0]+widths[0]+gaps[1]+widths[1]+gaps[2],-8+gaps[0]+widths[0]+gaps[1]+widths[1]+gaps[2]+widths[2] ]
            heights = [2*randint(1,4),2*randint(1,4),2*randint(1,4)]
            triangles = [choice([1,-1,-1/2,1/2]),choice([1,-1,-1/2,1/2]),choice([1,-1,-1/2,1/2])]  # 1/2 = triangle, 1 = rectangle ; 1 = CCW and -1 = CW
            areas = [(i-h)*heights[0]*triangles[0],(k-j)*heights[1]*triangles[1],(m-l)*heights[2]*triangles[2]]
            
        
        if(choice([True,False])):
            [a,b] = [randint(1,4)*choice([-1,1]),2*randint(1,6)*choice([-1,1])]
            [fx,fy] = [b*x*y + D(x), a*x + b/2*x^2 + C(y)]
        else:
            [a,b] = [randint(1,4)*choice([-1,1]),2*randint(1,6)*choice([-1,1])]
            [fx,fy] = [b/2*y^2 + D(x), a*x+b*x*y+C(y)]
            
            
        ix = randint(1,3) # Which of the three curves is correct answer
        circ = a*areas[ix-1]
        
        bases = [[h,i],[j,k],[l,m]]
            
        jx = Mod(ix,3) # The index of an incorrect answer to change to have area = circ
        areas[jx] = areas[jx]/heights[jx]*circ/(bases[jx][1]-bases[jx][0])/triangles[jx]
        heights[jx] = areas[jx]/triangles[jx]/(bases[jx][1]-bases[jx][0])
        
        polygoncoords=[]
        arrowcoords=[]
        minmax = 9
        
        for q in range(3):
            if(abs(triangles[q])==1): #Rectangle
                g = heights[q]/2
                if(g>minmax):
                    minmax = g + 2
                polygoncoords += [
                    [[bases[q][0],g],[bases[q][0],-g],[bases[q][1],-g],[bases[q][1],g]]
                ]
                ar = bases[q]
                if(triangles[q] < 0): # CCW, arrow (q0,-g) to (q1,-g)
                    ar.sort(reverse=True)
                arrowcoords += [
                    [[ar[0],-g],[0.25*(ar[0]+3*ar[1]),-g]]
                ]
            else: # Triangle
                g = choice([-1,1])*heights[q]/2
                if(g>minmax):
                    minmax = g + 2
                polygoncoords += [
                    [[bases[q][0],g],[bases[q][1],g],[bases[q][1],-g]]
                ]
                ar = bases[q]
                if(sign(g)*sign(triangles[q])>0): # Need right to left arrow
                    ar.sort(reverse=True)
                arrowcoords += [
                    [[ar[0],g],[(0.25)*(ar[0]+3*ar[1]),g]]
                ]

        
        ## Now give an honest Green's application
        
        CC(y) = chaff[2].subs(n=y)
        DD(x) = chaff[3].subs(n=x)
        [gx,gy] = [randint(2,8)*y^2+DD(x),randint(2,8)*x+CC(y)]
        rad = randint(1,8)
        
        igrand = gy.derivative(x)-gx.derivative(y)
        
        ans = integrate(integrate(gy.derivative(x)-gx.derivative(y),y,-sqrt(rad^2-x^2),sqrt(rad^2-x^2)),x,-rad,rad)

           
            
        return {
            "fx": fx,
            "fy": fy,
            "which": ix,
            "scurl": fy.derivative(x)-fx.derivative(y),
            "bases": [h,i,j,k,l,m],
            "areas": areas,
            "circ": circ,
            "pc": tuple(polygoncoords),
            "ar": tuple(arrowcoords),
            "nareas": len(set(areas)),
            "minmax": minmax,
            "gx": gx,
            "gy": gy,
            "r": rad^2,
            "integrand": igrand,
            "ans": ans
        }
    
    @provide_data
    def graphics(data):
    # updated by clontz
        return {"plot": plot_slope_field(data['fy']/data['fx'],(x,-1.1*data['minmax'],1.1*data['minmax']), (y,-1*data['minmax'],data['minmax']),color="gray",gridlines='minor')+polygon(data['pc'][0],fill=False,color='blue',thickness=2)+polygon(data['pc'][1],fill=False,color='blue',thickness=2)+polygon(data['pc'][2],fill=False,color='blue',thickness=2)+arrow2d(data['ar'][0][0],data['ar'][0][1],color='blue',thickness=1)+arrow2d(data['ar'][1][0],data['ar'][1][1],color='blue',thickness=1)+arrow2d(data['ar'][2][0],data['ar'][2][1],color='blue',thickness=1)+text('$C_1$',data['ar'][0][0],color='blue',vertical_alignment='top',fontsize=18)+text('$C_2$',data['ar'][1][0],color='blue',vertical_alignment='bottom',fontsize=18)+text('$C_3$',data['ar'][2][0],color='blue',vertical_alignment='top',fontsize=18)
                }