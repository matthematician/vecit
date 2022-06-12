class Generator(BaseGenerator):
    def data(self):
        x=var("x")
        y=var("y")
        t=var("t")
        
        
        
        mag=0
        
        while(mag==0 or mag==1):
            v=[randint(-5,5), randint(-5,5), randint(-5,5)]
            w=[randint(-5,5), randint(-5,5), randint(-5,5)]
            
            a=randint(1,3)*choice([-1,1])
            b=randint(1,3)*choice([-1,1])
        
            case = choice([-1,1])
        
            if case == 1:
                op = '+'
        
            if case == -1:
                op = '-'
            
            u= [0,0,0]
            for i in range(3):
                u[i]=a*v[i]+case*b*w[i]
            mag=(u[0]^2+u[1]^2+u[2]^2)^(1/2)
            if mag!=0:
                unitu=[u[0]/mag, u[1]/mag, u[2]/mag]
        
        
        #surface = x^2+y^2
        return {
            "v0": v[0],
            "v1": v[1],
            "v2": v[2],
            "w0": w[0],
            "w1": w[1],
            "w2": w[2],
            "u0": u[0],
            "u1": u[1],
            "u2": u[2],
            "unitu0": unitu[0],
            "unitu1": unitu[1],
            "unitu2": unitu[2],
            "a": a,
            "b": b,
            "mag": mag,
            "op": op,
            "vecvx": a*v[0]*t,
            "vecvy": a*v[1]*t,
            "vecvz": a*v[2]*t,
            "vecux": u[0]*t,
            "vecuy": u[1]*t,
            "vecuz": u[2]*t,
            "vecwx": a*v[0]+case*b*w[0]*t,
            "vecwy": a*v[1]+case*b*w[1]*t,
            "vecwz": a*v[2]+case*b*w[2]*t,
            
            #"slope": m,
            #"intercept": b,
        }

    @provide_data
    def graphics(data):
        return {
            "plot": (parametric_plot3d([data['vecvx'], data['vecvy'], data['vecvz']], (t, 0, 1), color='blue')+parametric_plot3d([data['vecwx'], data['vecwy'], data['vecwz']], (t, 0, 1), color='red'))+parametric_plot3d([data['vecux'], data['vecuy'], data['vecuz']], (t, 0, 1), color='purple')
        }

