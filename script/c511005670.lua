--Tremedous Fire (DOR)
--scrtipted by GameMaster (GM)
function c511005670.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DAMAGE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c511005670.target)
e1:SetOperation(c511005670.activate)
c:RegisterEffect(e1)
end

function c511005670.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end

function c511005670.activate(e,tp,eg,ep,ev,re,r,rp)
Duel.Damage(1-tp,1000,REASON_EFFECT,true)
Duel.RDComplete()
end
