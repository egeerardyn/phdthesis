function val = vgcd(vals)
    
    val = foldOver(@gcd, vals);
end
