--Deep-Eyes White Dragon (Anime)
function c511247010.initial_effect(c)
    --special summon
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(511247010,0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e1:SetRange(LOCATION_HAND)
    e1:SetCode(EVENT_DESTROYED)
    e1:SetCondition(c511247010.spcon)
    e1:SetTarget(c511247010.sptg)
    e1:SetOperation(c511247010.spop)
    c:RegisterEffect(e1)
    --atk
    local e2=Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(511247010,1))
    e2:SetCategory(CATEGORY_ATKCHANGE)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetTarget(c511247010.atktg)
    e2:SetOperation(c511247010.atkop)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e3)
    --destroy
    local e4=Effect.CreateEffect(c)
    e4:SetCategory(CATEGORY_DESTROY)
    e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e4:SetCode(EVENT_DESTROYED)
    e4:SetCondition(c511247010.descon)
    e4:SetTarget(c511247010.destg)
    e4:SetOperation(c511247010.desop)
    c:RegisterEffect(e4)
    --summon success
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(511247010,2))
    e5:SetCategory(CATEGORY_DAMAGE)
    e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e5:SetCode(EVENT_SUMMON_SUCCESS)
    e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e5:SetTarget(c511247010.damtg)
    e5:SetOperation(c511247010.damop)
    c:RegisterEffect(e5)
    local e6=e5:Clone()
    e6:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e6)
end
function c511247010.spfilter(c,tp)
    return c:IsRace(RACE_DRAGON) and c:IsLevelAbove(8) and c:IsPreviousLocation(LOCATION_MZONE) and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT))
end
function c511247010.spcon(e,tp,eg,ep,ev,re,r,rp)
    return eg:IsExists(c511247010.spfilter,1,nil,tp)
end
function c511247010.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,RACE_DRAGON)*600
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g)
end
function c511247010.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
        local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_GRAVE,0,nil,RACE_DRAGON)*600
        Duel.Damage(1-tp,g,REASON_EFFECT)
    elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
        and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
        Duel.SendtoGrave(c,REASON_RULE)
    end
end
function c511247010.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsRace(RACE_DRAGON) end
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    Duel.SelectTarget(tp,Card.IsRace,tp,LOCATION_GRAVE,0,1,1,nil,RACE_DRAGON)
end
function c511247010.atkop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=Duel.GetFirstTarget()
    if not tc or not tc:IsRelateToEffect(e) then return end
    local atk=tc:GetAttack()
    if atk>0 and c:IsRelateToEffect(e) and c:IsFaceup() then
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetValue(atk)
        e1:SetReset(RESET_EVENT+0x1ff0000)
        c:RegisterEffect(e1)
    end
end
function c511247010.descon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511247010.destg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511247010.desop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
    Duel.Destroy(g,REASON_EFFECT)
end
function c511247010.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,RACE_DRAGON) end
    Duel.SetTargetPlayer(1-tp)
    local dam=Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,RACE_DRAGON)*600
    Duel.SetTargetParam(dam)
    Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511247010.damop(e,tp,eg,ep,ev,re,r,rp)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
    local dam=Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,RACE_DRAGON)*600
    Duel.Damage(p,dam,REASON_EFFECT)
end
