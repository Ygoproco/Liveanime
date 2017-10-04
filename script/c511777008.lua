function c511777008.initial_effect(c)
    --activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetCondition(c511777008.condition)
    e1:SetTarget(c511777008.target)
    e1:SetOperation(c511777008.activate)
    c:RegisterEffect(e1)
end
function c511777008.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
        and Duel.IsExistingMatchingCard(c511777008.cfilter,tp,LOCATION_HAND,0,1,nil)
end
function c511777008.cfilter(c)
    return c:IsAbleToGrave() and c:IsType(TYPE_MONSTER)
end
function c511777008.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c511777008.cfilter,tp,LOCATION_HAND,0,1,nil) end
    local g=Duel.SelectMatchingCard(tp,c511777008.cfilter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
    local atk=g:GetAttack()
    Duel.SendtoGrave(g,REASON_EFFECT)
    Duel.SetTargetParam(atk)
end
function c511777008.activate(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
    e1:SetCountLimit(1)
    e1:SetOperation(c511777008.rdop)
    e1:SetLabel(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
    Duel.RegisterEffect(e1,tp)
end
function c511777008.rdop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ChangeBattleDamage(ep,math.max(0,ev-e:GetLabel()))
end