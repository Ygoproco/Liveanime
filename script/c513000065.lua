--神の進化
--Divine Evolution
--updated by Larry126
function c513000065.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetTarget(c513000065.target)
    e1:SetOperation(c513000065.activate)
    c:RegisterEffect(e1)
    if not c513000065.global_check then
        c513000065.global_check=true
    --hierarchy
        if Duel.GetFlagEffect(0,513000065)==0 and Duel.GetFlagEffect(1,513000065)==0 then
            Duel.RegisterFlagEffect(0,513000065,0,0,1)
            Duel.RegisterFlagEffect(1,513000065,0,0,1)
        --rank
            local rank1=Effect.CreateEffect(c)
            rank1:SetType(EFFECT_TYPE_FIELD)
            rank1:SetCode(513000065)
            rank1:SetTarget(c513000065.rank1)
            rank1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
            Duel.RegisterEffect(rank1,0) 
            local rank2=Effect.CreateEffect(c)
            rank2:SetType(EFFECT_TYPE_FIELD)
            rank2:SetCode(513000065)
            rank2:SetTarget(c513000065.rank2)
            rank2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
            Duel.RegisterEffect(rank2,0)
            local immunity=Effect.CreateEffect(c)
            immunity:SetType(EFFECT_TYPE_FIELD)
            immunity:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
            immunity:SetCode(EFFECT_IMMUNE_EFFECT)
            immunity:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
            immunity:SetTarget(c513000065.hrtg)
            immunity:SetValue(c513000065.hrfilter)
            Duel.RegisterEffect(immunity,0)
            --control
            local control=Effect.CreateEffect(c)
            control:SetType(EFFECT_TYPE_FIELD)
            control:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
            control:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
            control:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
            control:SetTarget(c513000065.control)
            Duel.RegisterEffect(control,0)
        --last 1 turn
            local last=Effect.CreateEffect(c)
            last:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
            last:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
            last:SetCode(EVENT_ADJUST)
            last:SetTarget(c513000065.lasttg)
            last:SetOperation(c513000065.lastop)
            Duel.RegisterEffect(last,0)
            local check=Effect.CreateEffect(c)
            check:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
            check:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
            check:SetCode(EVENT_CHAINING)
            check:SetOperation(c513000065.sdop)
            Duel.RegisterEffect(check,0)
        end
    end
end
function c513000065.sdop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local tc=re:GetHandler()
    if tc:GetFlagEffect(1211920)>0 then
        tc:ResetFlagEffect(1211920)
    end
    tc:RegisterFlagEffect(1211920,RESET_EVENT+0x1fe0000,0,1,Duel.GetTurnCount()) 
    if re:IsHasProperty(EFFECT_FLAG_IGNORE_IMMUNE) then tc:RegisterFlagEffect(128,0,0,0) end
end
function c513000065.rank1(e,c)
    local code1,code2=c:GetOriginalCodeRule() 
    return c:IsFaceup()
        and (code1==10000000 or code1==10000010 or code1==10000020
        or code1==62180201 or code1==57793869 or code1==21208154
        or code2==10000000 or code2==10000010 or code2==10000020
        or code2==62180201 or code2==57793869 or code2==21208154)
end
function c513000065.rank2(e,c)
    local code1,code2=c:GetOriginalCodeRule() 
    return c:IsFaceup() and (code1==10000010 or code1==21208154 or code2==10000010 or code2==21208154)
end
function c513000065.hrtg(e,c)
    return c:IsHasEffect(513000065) and c:IsFaceup()
end
function c513000065.hrfilter(e,te,c)
    if not te then return false end
    if not c:IsHasEffect(513000065) or not c:IsFaceup() then return false end
    local tc=te:GetOwner()
    return (te:IsActiveType(TYPE_MONSTER) and c~=tc
        and c:GetEffectCount(513000065)>tc:GetEffectCount(513000065))
        or (te:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
        and te:IsActiveType(TYPE_SPELL+TYPE_TRAP))
        or (tc:GetFlagEffectLabel(1211920) 
        and te:GetType()==EFFECT_TYPE_EQUIP 
        and Duel.GetTurnCount()-tc:GetFlagEffectLabel(1211920)>=1
        and Duel.GetTurnCount()-c:GetTurnID()>=1)
end
function c513000065.control(e,c)
    return c:IsHasEffect(513000065) and c:IsFaceup() and not c:IsHasEffect(513000134)
end
function c513000065.lastfilter(c)
    return c:GetFlagEffect(51300065)>0
end
function c513000065.lasttg(e,tp,eg,ev,ep,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,LOCATION_MZONE,nil,513000065)
    return g:IsExists(aux.NOT(c513000065.lastfilter),1,nil)
end
function c513000065.lastop(e,tp,eg,ev,ep,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,LOCATION_MZONE,nil,513000065)
    local tg=g:Filter(aux.NOT(c513000065.lastfilter),nil)
    tg:ForEach(function(c)
        c:RegisterFlagEffect(51300065,RESET_EVENT+0x1fe0000,0,1)
        --If Special Summoned: Send to previous location
        local e1=Effect.CreateEffect(c)
        e1:SetDescription(aux.Stringid(4010,8))
        e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_TOHAND+CATEGORY_TODECK)
        e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
        e1:SetRange(LOCATION_MZONE)
        e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
        e1:SetCountLimit(1)
        e1:SetCode(EVENT_PHASE+PHASE_END)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e1:SetCondition(c513000065.stgcon)
        e1:SetTarget(c513000065.stgtg)
        e1:SetOperation(c513000065.stgop)
        c:RegisterEffect(e1)
        --ATK/DEF effects are only applied until the End Phase
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
        e2:SetRange(LOCATION_MZONE)
        e2:SetCode(EVENT_PHASE+PHASE_END)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        e2:SetCountLimit(1)
        e2:SetCondition(c513000065.atkdefresetcon)
        e2:SetOperation(c513000065.atkdefresetop)
        c:RegisterEffect(e2)
        --release limit
        local e3=Effect.CreateEffect(c)
        e3:SetType(EFFECT_TYPE_SINGLE)
        e3:SetCode(EFFECT_UNRELEASABLE_SUM)
        e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
        e3:SetRange(LOCATION_MZONE)
        e3:SetReset(RESET_EVENT+0x1fe0000)
        e3:SetValue(c513000065.recon)
        c:RegisterEffect(e3)
        local e4=e3:Clone()
        e4:SetCondition(c513000065.recon2)
        e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
        c:RegisterEffect(e4)
        local e5=Effect.CreateEffect(c)
        e5:SetDescription(aux.Stringid(4010,9))
        e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
        e5:SetCode(EVENT_BE_BATTLE_TARGET)
        e5:SetRange(LOCATION_MZONE)
        e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
        e5:SetReset(RESET_EVENT+0x1fe0000)
        e5:SetCondition(c513000065.negatkcon)
        e5:SetOperation(c513000065.negatkop)
        c:RegisterEffect(e5)
    end)
end
function c513000065.negatkcon(e,tp,eg,ep,ev,re,r,rp)
    local ac=Duel.GetAttacker()
    return ac:IsHasEffect(513000065) 
        and e:GetHandler():GetEffectCount(513000065)>ac:GetEffectCount(513000065)
end
function c513000065.negatkop(e,tp,eg,ep,ev,re,r,rp)
    Duel.NegateAttack()
end
function c513000065.recon(e,c)
    return e:GetHandler():IsHasEffect(513000065) and c:GetControler()~=e:GetHandler():GetControler()
end
function c513000065.recon2(e)
    return e:GetHandler():IsHasEffect(513000065) and Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c513000065.atkdefresetcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsHasEffect(513000065)
end
function c513000065.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local g=Duel.GetMatchingGroup(nil,tp,0xff,0xff,c)
    for tc in aux.Next(g) do
        if tc:GetOriginalCode()~=c:GetOriginalCode() and tc:GetFlagEffect(128)==0 then
            c:ResetEffect(tc:GetOriginalCode(),RESET_CARD)
            tc:ResetFlagEffect(128)
        end
    end
end
function c513000065.stgcon(e,tp,eg,ep,ev,re,r,rp)
    return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
        and e:GetHandler():IsHasEffect(513000065)
end
function c513000065.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local c=e:GetHandler()
    if c:IsPreviousLocation(LOCATION_GRAVE) then
        Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
    elseif c:IsPreviousLocation(LOCATION_DECK) then
        Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
    elseif c:IsPreviousLocation(LOCATION_HAND) then
        Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
    elseif c:IsPreviousLocation(LOCATION_REMOVED) then
        Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
    end
end
function c513000065.stgop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsFaceup() then
        if c:IsPreviousLocation(LOCATION_GRAVE) then
            Duel.SendtoGrave(c,REASON_EFFECT)
        elseif c:IsPreviousLocation(LOCATION_DECK) then
            Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
        elseif c:IsPreviousLocation(LOCATION_HAND) then
            Duel.SendtoHand(c,nil,REASON_EFFECT)
        elseif c:IsPreviousLocation(LOCATION_REMOVED) then
            local pos
            Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
        end
    end
end
-------------------------------------------------------------------
function c513000065.filter(c)
    return c:IsFaceup() and c:IsHasEffect(513000065) and c:GetFlagEffect(5130000650)==0
end
function c513000065.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c513000065.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c513000065.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local g=Duel.GetMatchingGroup(c513000065.filter,tp,LOCATION_MZONE,0,nil)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(c)
        e1:SetDescription(aux.Stringid(4010,7))
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(513000065)
        e1:SetProperty(EFFECT_FLAG_CLIENT_HINT+EFFECT_FLAG_IGNORE_IMMUNE)
        e1:SetValue(1)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        e2:SetCode(EVENT_ADJUST)
        e2:SetCountLimit(1)
        e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
        e2:SetRange(LOCATION_MZONE)
        e2:SetOperation(c513000065.atkup)
        e2:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e2)
        local code1,code2=tc:GetOriginalCodeRule()
        if code1==10000000 or code2==10000000 then
            --change name
            local e3=Effect.CreateEffect(c)
            e3:SetType(EFFECT_TYPE_SINGLE)
            e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
            e3:SetCode(EFFECT_CHANGE_CODE)
            e3:SetValue(511600030)
            tc:RegisterEffect(e3)
        end
        tc:RegisterFlagEffect(5130000650,RESET_EVENT+0x1fe0000,0,1)
        tc=g:GetNext()
    end
end
function c513000065.atkup(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    --Atk/Def up
    local e2=Effect.CreateEffect(e:GetOwner())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e2:SetValue(1000)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EFFECT_UPDATE_DEFENSE)
    c:RegisterEffect(e3)
end
