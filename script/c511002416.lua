--Dark eye illusionist
--scripted by GameMaster(GM)
function c511002416.initial_effect(c)
      --negate attack and monster cannot declare attack
    local e2=Effect.CreateEffect(c)
    e2:SetType( EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetRange(LOCATION_MZONE)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    e2:SetLabel(0)
    e2:SetCondition(c511002416.condition)
    e2:SetOperation(c511002416.activate)
    c:RegisterEffect(e2)
end

function c511002416.condition(e,tp,eg,ep,ev,re,r,rp)
 local c=e:GetHandler()
local bc=c:GetBattleTarget(38247752)
 if  bc:IsFaceup() and bc:IsRelateToBattle() and Duel.GetAttackTarget()==c and not bc:IsStatus(STATUS_CHAINING) then return true
else  return false end
end

function c511002416.activate(e,tp,eg,ep,ev,re,r,rp)
     local c=e:GetHandler()
     local bc=c:GetBattleTarget()
 if not bc:IsRelateToBattle() then end	 
	Duel.NegateAttack()
 if bc and bc==Duel.GetAttacker() then
        Duel.Hint(HINT_CARD,0,511002416)
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_ATTACK)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        bc:RegisterEffect(e1)
       end
end
