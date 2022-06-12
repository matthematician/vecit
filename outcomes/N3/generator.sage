class Generator(BaseGenerator):
    def data(self):
        # Randomly choose components of v and w. One or two of them should be zeroes.
        vwcoords = [0,0,0,0,0,0]
        while(vwcoords.count(0) == 0 or vwcoords.count(0) > 2):
            vwcoords = [randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6),randrange(-6,6)]
        v = vector([vwcoords[i] for i in [0,1,2]])
        w = vector([vwcoords[i] for i in [3,4,5]])
        vw = v.inner_product(w)
        
        # Choose between dot/cross in (a) and the opposite for (c).
        if(choice([True,False])):
            [optext,optext2] = ["cross","dot"]
            [op,op2] = ["\\times", "\mathbf{v}\cdot\mathbf{x}"]
            optrig = "\cos"
            opf = cos
            u = v.cross_product(w)
        else:
            [optext,optext2] = ["dot","magnitude of the cross"]
            [op,op2] = ["\cdot", "\|\mathbf{v}\\times\mathbf{x}\|"]
            optrig = "\sin"
            opf = sin
            u = v.inner_product(w)
            
        

        wp = v.inner_product(w)/v.inner_product(v)*v
        
        if( vw > 0 ):
            [vws, orient] = ["positive","parallel"]
        if( vw < 0 ):
            [vws, orient] = ["negative","anti-parallel"]
        if( vw == 0 ):
            [vws,orient] = ["zero", "the zero vector"]
            
        angles = [pi/6, pi/4, pi/3, 2*pi/3, 3*pi/4, 5*pi/6, 30, 45, 60, 120, 135, 150]
        j = randrange(0,12)
        if(j<6):
            [theta, thetaunit, thetatrig] = [angles[j],"radians",opf(angles[j])]
        else:
            [theta, thetaunit, thetatrig] = [angles[j],"degrees",opf(angles[j]*pi/180)]
            
        mx = randrange(2,12)

        prod2 = sqrt(v.inner_product(v))*mx*thetatrig
        
        vv = var('b','d','h','k','m','r','s','t')
        vard = vv[randrange(0,8)]
        varval = choice([-1,1])*randrange(1,3)
        if(choice([True,False])): 
            zv = vector([2*randrange(-3,3),vard,2*randrange(-3,3)])
            z = vector([zv[0],2*varval,zv[2]])
        else:
            zv = vector([2*randrange(-3,3),2*randrange(-3,3),vard])
            z = 2*vector([zv[0],zv[1],2*varval]) 
        
        gchoi = ["area of the triangle spanned by w and z", "area of the parallelogram spanned by w and z", "volume of the tetrahedron spanned by v, w, and z", "volume of the parallelepiped spanned by v, w, and z"]
        k = randrange(0,4)
        geom = gchoi[k]

        if( k==0 ):
            geomval = w.cross_product(z).norm()/2
        if( k==1 ):
            geomval = w.cross_product(z).norm()
        if( k==2 ):
            geomval = abs( v.inner_product( w.cross_product(z) ) )/6
        if( k==3 ):
            geomval = abs( v.inner_product( w.cross_product(z) ) )
        #if( randrange(0,10) < 3 ):
        #    if( k < 2 ):
        #        geomval = ceil( w.norm()*z.norm() + 1 )
        #        varval = "\\text{nonexistent}"
        #    else:
        #        geomval = ceil( v.norm()*w.norm()*z.norm() + 2 )
        #        varval = "\\text{nonexistent}"

    
        
        #surface = x^2+y^2
        return {
           "v_1": v[0],
            "v_2": v[1],
            "v_3": v[2],
            "w_1": w[0],
            "w_2": w[1],
            "w_3": w[2],
            "u": u,
            "wp_1": wp[0],
            "wp_2": wp[1],
            "wp_3": wp[2],
            "op_text": optext,
            "op": op,
            "orient": orient,
            "vdotw": vw,
            "vdotw_sign": vws,
            "mx": mx,
            "theta": theta,
            "unit": thetaunit,
            "op_text_2": optext2,
            "op2": op2,
            "op_trig": optrig,
            "prod2": prod2,
            "z_1": zv[0],
            "z_2": zv[1],
            "z_3": zv[2],
            "var": vard,
            "geom": geom,
            "geomval": geomval,
            "varval": 2*varval
        }

    @provide_data
    def graphics(data):
        return {

        }

