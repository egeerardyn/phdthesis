function val = foldOver(func, vals)
    
    if numel(vals) <= 1
        val = vals;
        return;
    end
    val = func(vals(1), vals(2));
    for ii = 3:numel(vals)
        val = func(val, vals(ii));
    end
end
