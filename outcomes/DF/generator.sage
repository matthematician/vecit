class Generator(BaseGenerator):
    def data(self):
       
        var('L')
        
        scenario=choice(['box', 'silo', 'sphere', 'investment'])
    
        
        if scenario=='box':
            var('x y z')
            constraint=randint(15, 40)*6
            f(x,y,z)=x*y*z
            g(x,y,z)=2*x+2*y+z
            fx(x,y,z)=derivative(f(x,y,z),x)
            fy(x,y,z)=derivative(f(x,y,z),y)
            fz(x,y,z)=derivative(f(x,y,z),z)
            gx(x,y,z)=derivative(g(x,y,z),x)
            gy(x,y,z)=derivative(g(x,y,z),y)
            gz(x,y,z)=derivative(g(x,y,z),z)
            zeroes=solve([fx(x,y,z)==L*gx(x,y,z), fy(x,y,z)==L*gy(x,y,z), fz(x,y,z)==L*gz(x,y,z), g(x,y,z)==constraint],x,y,z,L)
            
            #initial critical points
            cp=[]
        
            #find solutions
            for i in range(len(zeroes)):
                xi=zeroes[i][0].rhs()
                yi=zeroes[i][1].rhs()
                zi=zeroes[i][2].rhs()
                Li=zeroes[i][3].rhs()
                cp.append((xi, yi, zi, Li))
                
                
            #compute min value
        
            minvalue=f(cp[0][0],cp[0][1], cp[0][2])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])<minvalue:
                    minvalue=f(cp[i][0], cp[i][1], cp[i][2])
            
            #find solutions for min value
        
            minsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])==minvalue:
                    minsolns.append(cp[i])
        
            #compute max value
        
            maxvalue=f(cp[0][0],cp[0][1], cp[0][2])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])>maxvalue:
                    maxvalue=f(cp[i][0], cp[i][1], cp[i][2])
        
            #find solutions for max value
        
            maxsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])==maxvalue:
                    maxsolns.append(cp[i])
        
           
                
            return {
                scenario: True,
                "constraint": constraint,
                "f": f(x,y,z),
                "g": g(x,y,z),
                "minvalue": minvalue,
                "maxvalue": maxvalue,
                "minsolns": minsolns,
                "maxsolns": maxsolns,
            
            }
        
        
        if scenario=='silo':
            var('r h')
            
            floor=1#
            wall=randint(2,4)*floor#
            dome=5#randint(5,7)*floor
            #floor=randint(2,4)*wall#
            constraint=9*(6*dome+3-4*wall)*wall^2*randint(1,3)^3#wall^2*((dome+floor)+dome)^2#randint(15, 40)*6
            
            f(r,h)=wall*2*r*h+dome*2*r^2+floor*r^2
            g(r,h)=r^2*h+(2/3)*r^3
            fr(r,h)=derivative(f(r,h),r)
            fh(x,y,z)=derivative(f(r,h),h)
            gr(r,h)=derivative(g(r,h),r)
            gh(x,y,z)=derivative(g(r,h),h)
            zeroes=solve([fr(r,h)==L*gr(r,h), fh(r,h)==L*gh(r,h), g(r,h)==constraint],r,h,L)
            
            #initial critical points
            cp=[]
        
            #find solutions
            for i in range(len(zeroes)):
                ri=zeroes[i][0].rhs()
                hi=zeroes[i][1].rhs()
                Li=zeroes[i][2].rhs()
                if ri in RR and hi in RR:
                    cp.append((ri, hi, Li))
                
                
            #compute min value
        
            minvalue=f(cp[0][0],cp[0][1])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])<minvalue:
                    minvalue=f(cp[i][0], cp[i][1])
            
            #find solutions for min value
        
            minsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])==minvalue:
                    minsolns.append(cp[i])
        
            #compute max value
        
            maxvalue=f(cp[0][0],cp[0][1])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])>maxvalue:
                    maxvalue=f(cp[i][0], cp[i][1])
        
            #find solutions for max value
        
            maxsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])==maxvalue:
                    maxsolns.append(cp[i])
        
           
                
            return {
                scenario: True,
                "constraint": constraint,
                "f": f(r,h),
                "g": g(r,h),
                "dome": dome,
                "floor": floor,
                "wall": wall,
                "minvalue": minvalue,
                "maxvalue": maxvalue,
                "minsolns": minsolns,
                "maxsolns": maxsolns,
            
            }
        
        
        
        if scenario=='sphere':
            var('x y z')
            #constraint=randint(5, 20)
            
            vartemp=[x,y,z]
            
            shuffle(vartemp)
            
            a=randint(1,3)
            b=randint(1,3)+a
            c=randint(1,3)+b
            
            k=randint(1,4)*choice([-1,1])
            
            g(x,y,z)=a*(vartemp[0]-k)^2+b*vartemp[1]^2+c*vartemp[2]^2
            
            lower=a*k^2
            
            constraint=randint(lower+1, 2*lower)
            
            
            f(x,y,z)=x^2+y^2+z^2
            fx(x,y,z)=derivative(f(x,y,z),x)
            fy(x,y,z)=derivative(f(x,y,z),y)
            fz(x,y,z)=derivative(f(x,y,z),z)
            gx(x,y,z)=derivative(g(x,y,z),x)
            gy(x,y,z)=derivative(g(x,y,z),y)
            gz(x,y,z)=derivative(g(x,y,z),z)
            zeroes=solve([fx(x,y,z)==L*gx(x,y,z), fy(x,y,z)==L*gy(x,y,z), fz(x,y,z)==L*gz(x,y,z), g(x,y,z)==constraint],x,y,z,L)
            
            #initial critical points
            cp=[]
        
            #find solutions
            for i in range(len(zeroes)):
                xi=zeroes[i][0].rhs()
                yi=zeroes[i][1].rhs()
                zi=zeroes[i][2].rhs()
                Li=zeroes[i][3].rhs()
                if(xi in RR and yi in RR and zi in RR):
                    cp.append((xi, yi, zi, Li))
                
                
            #compute min value
        
            minvalue=f(cp[0][0],cp[0][1], cp[0][2])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])<minvalue:
                    minvalue=f(cp[i][0], cp[i][1], cp[i][2])
            
            #find solutions for min value
        
            minsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])==minvalue:
                    minsolns.append(cp[i])
        
            #compute max value
        
            maxvalue=f(cp[0][0],cp[0][1], cp[0][2])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])>maxvalue:
                    maxvalue=f(cp[i][0], cp[i][1], cp[i][2])
        
            #find solutions for max value
        
            maxsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1], cp[i][2])==maxvalue:
                    maxsolns.append(cp[i])
        
           
                
            return {
                scenario: True,
                "constraint": constraint,
                "f": f(x,y,z),
                "g": g(x,y,z),
                "minvalue": minvalue,
                "maxvalue": maxvalue,
                "minsolns": minsolns,
                "maxsolns": maxsolns,
            
            }
        
        if scenario=='investment':
            var('K R')
            #constraint=randint(5, 20)
            
            denom=5 #randint(3,10)
            num=randint(1,denom-1)
            a=num/denom
            b=(denom-num)/denom
            
            C=randint(5,20)*denom
            
            constraint=randint(10,50)*denom
            
            f(K,R)=C*K^a*R^b*1
            g(K,R)=K+R
            
            
            fK(K,R)=derivative(f(K,R),K)
            fR(K,R)=derivative(f(K,R),R)
            gK(K,R)=derivative(g(K,R),K)
            gR(K,R)=derivative(g(K,R),R)
            
            
            zeroes=solve([fK(K,R)==L*gK(K, R), fR(K,R)==L*gR(K, R), g(K, R)==constraint],K,R,L)
            
            #initial critical points
            cp=[]
        
            #find solutions
            for i in range(len(zeroes)):
                Ki=zeroes[i][0].rhs()
                Ri=zeroes[i][1].rhs()
                Li=zeroes[i][1].rhs()
                if(Ki in RR and Ri in RR):
                    cp.append((Ki, Ri, Li))
                
                
            #compute min value
        
            minvalue=f(cp[0][0],cp[0][1])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])<minvalue:
                    minvalue=f(cp[i][0], cp[i][1])
            
            #find solutions for min value
        
            minsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])==minvalue:
                    minsolns.append(cp[i])
        
            #compute max value
        
            maxvalue=f(cp[0][0],cp[0][1])
        
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])>maxvalue:
                    maxvalue=f(cp[i][0], cp[i][1])
        
            #find solutions for max value
        
            maxsolns=[]
            for i in range(len(cp)):
                if f(cp[i][0], cp[i][1])==maxvalue:
                    maxsolns.append(cp[i])
        
           
                
            return {
                scenario: True,
                "constraint": constraint,
                "f": f(K, R),
                "g": g(K, R),
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

