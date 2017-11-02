--Pumpking (DOR)
--scripted by GameMaster(GM)
function c511005702.initial_effect(c)
--atkup
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_TRIGGER_F)
e3:SetCode(EVENT_PREDRAW)
e3:SetRange(LOCATION_MZONE)
e3:SetCondition(c511005702.atkcon)
e3:SetOperation(c511005702.atkop)
e3:SetCountLimit(1)
c:RegisterEffect(e3)
end

function c511005702.filter(c)	
return c:IsRace(RACE_ZOMBIE) and c:IsFaceup()
end

function c511005702.atkcon(e,tp,eg,ep,ev,re,r,rp)
return  e:GetHandler():IsDefensePos()
end

function c511005702.atkop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c511005702.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetValue(100)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end