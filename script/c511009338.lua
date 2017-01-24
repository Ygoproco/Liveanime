--Parasite Magic
--fixed by MLD
function c511009338.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCondition(c511009338.condition)
	e1:SetTarget(c511009338.target)
	e1:SetOperation(c511009338.activate)
	c:RegisterEffect(e1)
end
--OCG Parasite collection
c511009338.collection={
	[6205579]=true;
}
function c511009338.cfilter(c)
	return c:IsFaceup() and (c511009338.collection[c:GetCode()] or c:IsSetCard(0x410))
end
function c511009338.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009338.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009338.acfilter(c,e,tp,eg,ep,ev,re,r,rp)
	local te=c:GetActivateEffect()
	if not te then return false end
	if not c:IsType(TYPE_SPELL) or not c:IsSSetable(true) then return false end
	if not c:IsType(TYPE_FIELD) and Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return false end
	if te:IsActivatable(tp) then return true end
	local condition=te:GetCondition()
	local cost=te:GetCost()
	local target=te:GetTarget()
	return (not condition or condition(te,tp,eg,ep,ev,re,r,rp)) and (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0))
		and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
function c511009338.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511009338.acfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009338.acfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,eg,ep,ev,re,r,rp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000770,1))
	local g=Duel.SelectTarget(tp,c511009338.acfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,eg,ep,ev,re,r,rp)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c511009338.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) then
		local tpe=tc:GetType()
		if bit.band(tpe,TYPE_FIELD)~=0 then
			local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
			if Duel.IsDuelType(DUEL_OBSOLETE_RULING) then
				if fc then Duel.Destroy(fc,REASON_RULE) end
				fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			else
				fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
				if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
			end
		end
		Duel.SSet(tp,tc)
		if not tc:IsLocation(LOCATION_SZONE) then return end
		local te=tc:GetActivateEffect()
		if not te then return end
		Duel.ChangePosition(tc,POS_FACEUP)
		local tg=te:GetTarget()
		local co=te:GetCost()
		local op=te:GetOperation()
		e:SetCategory(te:GetCategory())
		e:SetProperty(te:GetProperty())
		Duel.ClearTargetCard()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Hint(HINT_CARD,0,tc:GetCode())
		tc:CreateEffectRelation(te)
		if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
			tc:CancelToGrave(false)
		end
		if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
		if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
		Duel.BreakEffect()
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
		if g then
			local etc=g:GetFirst()
			while etc do
				etc:CreateEffectRelation(te)
				etc=g:GetNext()
			end
		end
		if op then op(te,tp,eg,ep,ev,re,r,rp) end
		if g and tc:IsType(TYPE_EQUIP) and not tc:GetEquipTarget() then
			Duel.Equip(tp,tc,g:GetFirst())
		end
		tc:ReleaseEffectRelation(te)
		if etc then	
			etc=g:GetFirst()
			while etc do
				etc:ReleaseEffectRelation(te)
				etc=g:GetNext()
			end
		end
	end
end
