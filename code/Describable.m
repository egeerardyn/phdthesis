classdef(HandleCompatible,Abstract) Describable
    %DESCRIBABLE Class with a description (describe method)

    methods(Abstract,Access=protected)
        str = describe_(obj)
    end

    methods(Sealed)
        function str = describe(obj)
            % DESCRIBE description of the object
            %
            % Usage:
            %  str = describe(obj)
            %  describe(obj)
            %
            % When no output argument is provided, the description is
            % displayed in the console.
            str = describe_(obj);
            if nargout == 0
                disp(str);
                clear('str');
            end
        end
    end

end

