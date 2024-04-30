classdef board < handle
    properties
        positions = [0, 3, 0, 3, 0, 3, 0, 3;
             3, 0, 3, 0, 3, 0, 3, 0;
             0, 3, 0, 3, 0, 3, 0, 3;
             0, 0, 0, 0, 0, 0, 0, 0;
             0, 0, 0, 0, 0, 0, 0, 0;
             2, 0, 2, 0, 2, 0, 2, 0;
             0, 2, 0, 2, 0, 2, 0, 2;
             2, 0, 2, 0, 2, 0, 2, 0];
    end
    methods
        function blank(board)
            board.positions = zeros(8);
        end
        function reset(board)
            board.positions = [0, 3, 0, 3, 0, 3, 0, 3;
             3, 0, 3, 0, 3, 0, 3, 0;
             0, 3, 0, 3, 0, 3, 0, 3;
             0, 0, 0, 0, 0, 0, 0, 0;
             0, 0, 0, 0, 0, 0, 0, 0;
             2, 0, 2, 0, 2, 0, 2, 0;
             0, 2, 0, 2, 0, 2, 0, 2;
             2, 0, 2, 0, 2, 0, 2, 0];
        end
    end
end