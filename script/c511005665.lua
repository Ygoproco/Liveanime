--Tenderness (DOR)
--scripted by GameMaster (GM)
function c511005665.initial_effect(c)--avoid battle damage
local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_CHANGE_DAMAGE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetTargetRange(1,1)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(function(e) return e:GetHandler():IsDefensePos() end)
    e1:SetValue(c511005665.val)
    c:RegisterEffect(e1)
	end
	
function c511005665.val(e,re,dam,r,rp,rc)
    if bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0 then
        return dam/2
    else return dam end
end