function StartCheckers(Board,moves,taken)

    Game = figure('Name', 'Checkers Game', 'NumberTitle', 'off','WindowState','fullscreen');
    hold on
        
    axis off; 
    txt=["Welcome to Checkers!","Rules:","1. Red goes first.","2. Pieces move diagonally forward into the highlighted yellow squares.","3. A piece becomes a king when it reaches the opposite edge.","4. Kings can move diagonally forward and backward.","5. Capturing moves are allowed (double click a piece to capture it).","6. The game ends when a player can make no more legal rules or a player runs out of pieces","Enjoy the game!"]
    
    ann = annotation("textbox",[0.25 0.7 0.5 0.3],"String",txt,"EdgeColor","None","VerticalAlignment","middle","HorizontalAlignment","center");
   

    
    startButton = uicontrol('Style', 'pushbutton', 'String', 'Start Game', ...
        'Units', 'normalized', 'Position', [0.4, 0.1, 0.2, 0.2], ...
        'Callback', @startGame);

    
    uiwait(Game);

    startButton.Visible = "off"
    ann.Visible = "off"

    checkers(Board,moves,taken);
    
    function checkers(Board,moves,taken)
        % Initialize variables and create the initial Board
        currentTurn = 1; % 1 for red, 2 for black
    
        % Add a reset button to the figure
        uicontrol('Style', 'pushbutton', 'String', 'Reset Board', ...
            'Units', 'normalized', 'Position', [0.85 0.95 0.15 0.05], ...
            'Callback', @resetBoard);
        movegui(Game, 'center');
        
        % Game loop
        while currentTurn > 0
            DrawBoard();
            [x, y] = ginputc(1);
            clicked_row = ceil(y);
            clicked_col = ceil(x);
            % Check if the clicked position has a checker piece
            
            if (clicked_row<=8)&&(clicked_row>=1)&&(clicked_col<=8)&&(clicked_col>=1)
                if Board.positions(clicked_row, clicked_col) == 0
                    disp('No checker piece at the clicked position.');
                end
                mmoves(x, y);
            end
            
        end
        function resetBoard(~,~)
                reset(Board)
                Board.positions;
                blank(moves)
                blank(taken)
                DrawBoard();
        end
        %################Nested_Functions##################
        function DrawBoard()
    
    % Create the main figure window
        
        
    
    
    
    
    
        
            %##########Initial_Plot##########
            startButton=plot(0,0);
            hold on
            axis square
            axis([0,8,0,8])
            i=1;
            j=1;
    
            %##########Populate_Board##########
            while i <=8
    
                if j > 8 
                    j = 1;
                    i = i+1;
                end
    
                if i>8
                    break
                end
    
                %##########Draw_Squares##########
                moves.positions;
                if moves.positions(j,i)==2
                    rectangle('Position',[i-1,j-1,1,1],'FaceColor','1 0.5 0.1')
                else
                    if mod(j+i,2) == 0
                        if moves.positions(j,i)==0
                            rectangle('Position',[i-1,j-1,1,1],'FaceColor','k')
                        else
                            rectangle('Position',[i-1,j-1,1,1],'FaceColor','1 0.9 0.6')
                        end
                    else
                      if moves.positions(j,i)==0
                            rectangle('Position',[i-1,j-1,1,1],'FaceColor','0.8 0.8 0.8')
                      else
                            rectangle('Position',[i-1,j-1,1,1],'FaceColor','1 0.9 0.6')
                      end
                    end
                end
    
                %##########Draw_Pieces##########
    
                if Board.positions(j,i)~=0
                    if mod(Board.positions(j,i),2)==0&&Board.positions(j,i)<5 %##########Even And Less Than Five
                        if Board.positions(j,i) <4 &&(j~=1)
                            DrawX(i,j,'k',0)
                        else
                            DrawX(i,j,'k',1)
                            Board.positions(j,i)=4
                        end
                    elseif mod(Board.positions(j,i),3)==0 %##########Divisible By 3 
                        if Board.positions(j,i) <4 &&(j~=8)
                            DrawX(i,j,'r',0)
                        else
                            DrawX(i,j,'r',1)
                            Board.positions(j,i)=6;
                        end
                    end
                end
    
                j = j+1;        
            end 
        end
    
        function DrawX(i,j,c,k)
            r = 0.4;
            d = 0.5-r;
            % Draw x's
            if k == 0
                rectangle('Position', [i-1+d,j-1+d,2*r,r*2],'Curvature', [1 1], 'FaceColor', c,'EdgeColor',c);
            else
                if Board.positions(j,i)~=0
                    if mod(Board.positions(j,i),2)==0&&Board.positions(j,i)<5 %##########Even And Less Than Five
                      %black
                    elseif mod(Board.positions(j,i),3)==0 %##########Divisible By 3 
                      %red
                    end
                end
                rectangle('Position', [i-1+d,j-1+d,2*r,r*2],'Curvature', [1 1], 'FaceColor', '0.3 0.3 0.3','EdgeColor', c,'LineWidth',3);
            end
        end
            
    
        %##########Find_Moves##########
    
    
    
    
    
        %##########Find_Move_Piece##########
        function mmoves(x,y)
            i = ceil(x);
            j = ceil(y);
            %moves.positions(y,x)=2;
            ch = 0;
            %##########Evaluate_Color##########
            if mod(Board.positions(j,i),2)==0&&Board.positions(j,i)>3
                k=1;
            else
                k=0;
            end
    
            mover(i,j,k)
            %##########Evaluate_Color##########
            %Make one click multihop moves, check new position for valid moves
            %if there are pieces taken
    
            %if a piece is a king must check for all directions
            
            function mover(i,j,k)
                % Board.positions(j,i)
    
                %##########Find Movement Direction
                if Board.positions(j,i)~=0
                    if mod(Board.positions(j,i),2)==0&&Board.positions(j,i)<5 %##########Even And Less Than Five
                        ch=-1; %black
                    elseif mod(Board.positions(j,i),3)==0 %##########Divisible By 3 
                        ch=1; %red
                    end
                end
    
                %##########Check If Valid Position
                if k == 0
                    check(i,j)
                    moves.positions(j,i)=2;
                    DrawBoard
                else
                    ch = 1;
                    check(i,j)
                    ch=-1;
                    check(i,j)
                    moves.positions(j,i)=2;
                    DrawBoard
                end

            end
    
             function check(i,j)
                if j+ch<=8&&j+ch>=1
                    %##########################Right############################ 
                    if i<8%##########Cant Check Right If All The Way Right
        
                        %##########Check Forward And Right
                        if Board.positions(j+ch,i+1)==0
                            moves.positions(j+ch,i+1)=1;
                        end
        
                        if i<7%##########Cant Check 2 Right If One From Right
        
                            %##########Check Jump Piece And Right
                            if Board.positions(j+ch,i+1)~=Board.positions(j,i)&&Board.positions(j+ch,i+1)~=Board.positions(j,i)/2&&Board.positions(j+ch,i+1)~=Board.positions(j,i)*2&&Board.positions(j+ch,i+1)~=0
                                if Board.positions(j+2*ch,i+2)==0
                                    moves.positions(j+2*ch,i+2)=1;
                                    taken.positions(j+ch,i+1)=1;
                                    check2(i+2,j+2*ch);
                                end
                            end
                        end
                    end
        
                    %##########################Left#############################
                    if i>1%##########Cant Check Left If All The Way Left
        
                        %##########Check Forward And Left
                        if Board.positions(j+ch,i-1)==0
                            moves.positions(j+ch,i-1)=1;
                        end
        
                        if i>2%##########Cant Check 2 Left If One From Left
        
                            %##########Check Jump Piece And Left
                            if Board.positions(j+ch,i-1)~=Board.positions(j,i)&&Board.positions(j+ch,i-1)~=0&&Board.positions(j+ch,i-1)~=Board.positions(j,i)/2&&Board.positions(j+ch,i-1)~=Board.positions(j,i)*2
                                if Board.positions(j+2*ch,i-2)==0
                                    moves.positions(j+2*ch,i-2)=1;
                                    taken.positions(j+ch,i-1)=1;
                                    check2(i-2,j+2*ch);
                                end
                            end
                        end
                    end
                end
    
    
                function check2(i,j)
                    %##########################Right############################ 
                    if i<7&&j<7&&j>2%##########Cant Check 2 Right If One From Right
    
                        %##########Check Jump Piece And Right
                        if Board.positions(j+ch,i+1)~=Board.positions(j,i)&&Board.positions(j+ch,i+1)~=Board.positions(j,i)/2&&Board.positions(j+ch,i+1)~=Board.positions(j,i)*2&&Board.positions(j+ch,i+1)~=0
                            if Board.positions(j+2*ch,i+2)==0
                                moves.positions(j+2*ch,i+2)=1;
                                taken.positions(j+ch,i+1)=1;
                                moves.positions(j,i)=0;
                            end
                        end
                    end
    
                    %##########################Left#############################
                    if i>2&&j<7&&j>2%##########Cant Check 2 Left If One From Left
    
                        %##########Check Jump Piece And Left
                        if Board.positions(j+ch,i-1)~=Board.positions(j,i)&&Board.positions(j+ch,i-1)~=0&&Board.positions(j+ch,i-1)~=Board.positions(j,i)/2&&Board.positions(j+ch,i-1)~=Board.positions(j,i)*2
                            if Board.positions(j+2*ch,i-2)==0
                                moves.positions(j+2*ch,i-2)=1;
                                taken.positions(j+ch,i-1)=1;
                                moves.positions(j,i)=0;
                            end
                        end
                    end
                end
             end
    
    
            disp('Click on the position where you want to move the checker piece.');
            [x, y] = ginputc(1);
            if (((ceil(x)<=8)&&(ceil(x)>=1))&&(ceil(y)<=8))&&(ceil(y)>=1)
                Board.positions(ceil(y), ceil(x)) = Board.positions(clicked_row, clicked_col);
                Board.positions(clicked_row, clicked_col) = 0;
                % moves.positions(clicked_row,clicked_col) = 2;
                blank(moves)
                DrawBoard  
            end
                                                                                                  
        end
    end
    
    
    
    
    
    
    %##########################Copy_Paste-ables#############################
    %##########Check Piece Color
    % if Board.positions(j,i)~=0
    %     if mod(Board.positions(j,i),2)==0&&Board.positions(j,i)<5 %##########Even And Less Than Five
    %       %black
    %     elseif mod(Board.positions(j,i),3)==0 %##########Divisible By 3 
    %       %red
    %     end
    % end
    
    
    
    % if (clicked_row<=8)&&(clicked_row>=1)&&(clicked_col<=8)&&(clicked_col>=1)
    % 
    % end
end