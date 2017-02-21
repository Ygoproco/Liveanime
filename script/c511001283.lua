--Booby Trap E
function c511001283.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001283.cost)
	e1:SetTarget(c511001283.target)
	e1:SetOperation(c511001283.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(511001283)
	c:RegisterEffect(e2)
end
function c511001283.cfilter1(c)
	return c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsFacedown() and not c:IsHasEffect(511001283) 
		and c:CheckActivateEffect(true,true,false)~=nil
end
function c511001283.cfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsType(TYPE_CONTINUOUS) and c:IsFacedown() and c:CheckActivateEffect(true,true,false)~=nil
end
function c511001283.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001283.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001283.cfilter1,tp,LOCATION_SZONE,0,1,e:GetHandler())
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c511001283.cfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	local tc=g:GetFirst()
	if not tc then return end
	local te,teg,tep,tev,tre,tr,trp=tc:CheckActivateEffect(true,true,true)
	e:SetLabelObject(te)
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg and tg(e,tp,teg,tep,tev,tre,tr,trp,0) then tg(e,tp,teg,tep,tev,tre,tr,trp,1) end
end
function c511001283.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=e:GetLabelObject()
	local code=te:GetHandler():GetOriginalCode()
	c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
