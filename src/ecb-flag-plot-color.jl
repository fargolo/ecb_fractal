using Cairo, Compose
# https://github.com/douuu/BoxCount
set_default_graphic_size(17.3376cm, 17.3376cm)

function plot_ecb_crest(n)
    L_0 = 1
    L_1 = L_0*1/2
    R_1 = L_1*1/2
    L_2 = 1/(2*sqrt(2))
    xy_new = R_1 - L_2/2 
    
    if n == 0
        compose(context(),#0,1/2,1/2,1/2), 
        (context(0,0,1/2,1/2),
        Compose.circle(1/2,1/2,1/2),
        (context(),Compose.rectangle(),Compose.fill("blue")),  
        Compose.fill("white"),Compose.stroke("black")),
        (context(),
        Compose.rectangle(0,3/4,1,1/4),Compose.rectangle(1/2,1/4,1/2,1/4),
        Compose.stroke("black"),Compose.fill("red")),
        (context(),
        Compose.rectangle(),
        fill("white"),Compose.stroke("black")))
    else
        t = plot_ecb_crest(n-1)
        compose(context(),
        (context(xy_new,xy_new,L_2,L_2),t), 
        plot_ecb_crest(0))
    end
end

ecb_crest = plot_ecb_crest(10)
ecb_crest |> PNG("ecb_bw-n15-27mmx27mm-300dpi.png", 0.2709cm, 0.2709cm,dpi=300)