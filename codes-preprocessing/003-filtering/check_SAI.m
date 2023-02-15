function condition = check_SAI(SBP, DBP, PP)

idx = SBP < 300;
condition = idx;

idx = DBP > 20;
condition = and(condition,idx);

idx = PP > 35 & PP < 100;
condition = and(condition,idx);

for i=2:length(PP)
    
    if abs(SBP(i)-SBP(i-1)) > 20
        condition(i) = false;
    elseif abs(DBP(i)-DBP(i-1)) > 20
        condition(i) = false;
    elseif abs(PP(i)-PP(i-1)) > 20
        condition(i) = false;
    end
    
end

end

