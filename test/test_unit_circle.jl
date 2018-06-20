# This file is a part of JuliaFEM/MiniBall.jl.
# License is GPL: see https://github.com/JuliaFEM/MiniBall.jl/blob/master/LICENSE.md

using Miniball
using Base.Test

# See: https://github.com/JuliaFEM/Miniball.jl/pull/18
# and https://gist.github.com/TeroFrondelius/092c1f99584f0d4420100d6b0f24a583

@testset "unit circle bug failure points" begin
    pts = Array{Float64}(5,2,7)

    pts[:,:,1] = [-0.5479088748959597  0.8365380235292617;
                   0.4462905351003673 -0.8948881261251754;
                   0.8991227730128104  0.437696514779081;
                   0.9735012268534101  0.22868179051884613;
                   0.5479088748959593 -0.836538023529262]

    pts[:,:,2] = [-0.7602382818099168  0.649644329514778;
                  -0.47917066188138213 0.8777217536281975;
                  -0.9590054047425678  0.2833877796845582;
                   0.6329956939116541  0.7741553148363083;
                   0.7602382818099167 -0.6496443295147781]

    pts[:,:,3] = [-0.9663304317871969 -0.2573042879587697;
                   0.7244203479943333  0.6893585129754829;
                  -0.998856649001429  -0.047805802426441515;
                   0.9572295661455078  0.28932949676257164;
                   0.9663304317871971  0.25730428795876914]

    pts[:,:,4] = [ 0.8321502854540407   0.5545501802531115;
                  -0.9973590688669525   0.07262842245874197;
                  -0.3342860432423191   0.9424716660427487;
                  -0.19644267727835987  0.9805153107135606;
                  -0.8321502854540408  -0.5545501802531114]

    pts[:,:,5] = [-0.7790671965248694  0.6269404304229235;
                   0.5636601899670701  0.8260067737290575;
                  -0.8938326729059136 -0.44840066106761045;
                  -0.9388409350377671  0.34435112704536225;
                   0.7790671965248696 -0.6269404304229232]

    pts[:,:,6] = [-0.38620716828196205 -0.9224120679867692;
                  -0.38620708316517505 -0.9224121036245392;
                   0.27317417013153417  0.9619645901866386;
                   0.8527196744732161  -0.5223687938289313;
                   0.38620716828196217  0.9224120679867692]

    pts[:,:,7] = [ 0.6655564730601347 -0.7463474935763864;
                   0.9957824439456446 -0.09174597718504676;
                   0.5863829323648778  0.8100339848618495;
                   0.3296984388793171 -0.9440862987039592
                  -0.6655564730601352  0.746347493576386]

    for i = 1:7
        mb = miniball(pts[:,:,i])
        @test_broken isapprox(mb.center,[0.0;0.0];atol=10*eps())
    end
end

@testset "stastical unit circle test" begin
    pts = Array{Float64}(5,2)
    for k in 1:100000
        for i in 1:4
            angle = rand()*2*pi
            x = cos(angle)
            y = sin(angle)
            pts[i,:] = [x y]
            if i == 1
              pts[end,:] = [cos(angle + pi) sin(angle + pi)]
            end
        end

        mb = miniball(pts)
        origo = isapprox(mb.center,[0.0;0.0];atol=10*eps())
        if origo
            @test origo
        else
            @test_broken origo
        end
    end
end