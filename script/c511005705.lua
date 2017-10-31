--Candle of Fate (DOR)
--scripted by GameMaster(GM)
function c511005705.initial_effect(c)
--atkdown
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_TRIGGER_F)
e3:SetCode(EVENT_PHASE+PHASE_END)
e3:SetRange(LOCATION_MZONE)
e3:SetCondition(c511005705.atkcon)
e3:SetOperation(c511005705.atkop)
e3:SetCountLimit(1)
c:RegisterEffect(e3)
end

function c511005705.atkcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==1-tp and e:GetHandler():IsDefensePos()
end

function c511005705.atkop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsOnfield,tp,0,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetValue(-100)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
 local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
end