--Parasite mind
--scripted by GameMaster(GM)
--fixed by MLD
function c511005601.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511005601.condition)
	e1:SetTarget(c511005601.target)
	e1:SetOperation(c511005601.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(511001408)
	c:RegisterEffect(e2)
end
function c511005601.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511005601.cfilter(c)
	return not c:IsHasEffect(511001283) and c511005601.filter(c)
end
function c511005601.filter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsType(TYPE_CONTINUOUS) and c:IsFaceup() and c:CheckActivateEffect(false,false,false)~=nil
end
function c511005601.target(e,tp,eg,ev,ep,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c511005601.filter(chkc) end 
	if chk==0 then return Duel.IsExistingTarget(c511005601.cfilter,tp,0,LOCATION_SZONE,1,e:GetHandler()) end
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	local g=Duel.SelectTarget(tp,c511005601.filter,tp,0,LOCATION_SZONE,1,1,e:GetHandler())
	local tc=g:GetFirst()
	if not tc then return end
	local te,teg,tep,tev,tre,tr,trp=tc:CheckActivateEffect(false,false,true)
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	local co=te:GetCost()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if co and co(e,tp,teg,tep,tev,tre,tr,trp,0) then co(e,tp,teg,tep,tev,tre,tr,trp,1) end
	if tg and tg(e,tp,teg,tep,tev,tre,tr,trp,0) then tg(e,tp,teg,tep,tev,tre,tr,trp,1) end
end
function c511005601.activate(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	local chk=c:IsRelateToEffect(e)
	local code=te:GetHandler():GetOriginalCode()
	if chk then
		c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	end
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
	if chk then
		c:CancelToGrave()
	end
end
