classdef(HandleCompatible,Abstract) Codegeneratable
    % CODEGENERATABLE interface that allows to generate code for this
    % item.
    methods(Abstract)
        % function [str, tag, cind] = gencode(item, tag, ctagx)
        [str, sts] = gencode_rvalue(item)
        % function [str] = gencode_substruct(subs, name)
    end
end

