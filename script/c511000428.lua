--Limit Tribute
function c511000428.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
    --Restrict Release
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
    e2:SetCondition(c511000428.con)
	e2:SetLabel(0)
	c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetTargetRange(0,1)
    e3:SetLabel(1)
	e3:SetCondition(c511000428.con)
    c:RegisterEffect(e3)
    --Responding
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_RELEASE)
	e4:SetRange(LOCATION_SZONE)
    e4:SetCondition(c511000428.regcon)
	e4:SetOperation(c511000428.regop)
	c:RegisterEffect(e4)
end
function c511000428.con(e)
	local p
	if e:GetLabel()==0 then p=e:GetHandlerPlayer() else p=1-e:GetHandlerPlayer() end
    return e:GetHandler():GetFlagEffect(511000428+p)~=0
end
function c511000428.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_MONSTER)
end
function c511000428.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511000428+rp,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
