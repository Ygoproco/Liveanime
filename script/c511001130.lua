--Necromancy
function c511001130.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001130.target)
	e1:SetOperation(c511001130.activate)
	c:RegisterEffect(e1)
end
function c511001130.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001130.tgfilter(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end
function c511001130.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-t) and c511001130.filter(chkc) end
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c511001130.filter,tp,0,LOCATION_GRAVE,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(c511001130.tgfilter,tp,0,LOCATION_GRAVE,nil,e)
	local sg=Group.CreateGroup()
	repeat
		local tc=g:RandomSelect(tp,1):GetFirst()
		g:RemoveCard(tc)
		sg:AddCard(tc)
		ft=ft-1
	until sg:GetCount()>=4 or g:FilterCount(c511001130.filter,nil,e,tp)<=0 
		or ft<=0 or Duel.IsPlayerAffectedByEffect(tp,59822133) or not Duel.SelectYesNo(tp,210)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,sg:GetCount(),0,0)
end
function c511001130.spfilter(c,e,tp)
	return c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001130.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local g=tg:Filter(c511001130.spfilter,nil,e,tp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) and g:GetCount()>1 then return end
	if g:GetCount()<=0 then return end
	local fid=e:GetHandler():GetFieldID()
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
    	tc:RegisterFlagEffect(51101130,RESET_EVENT+0x5020000,0,1,fid)
    	tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetLabel(fid)
	e2:SetLabelObject(g)
	e2:SetCondition(c511001130.descon)
	e2:SetOperation(c511001130.desop)
	Duel.RegisterEffect(e2,tp)
end
function c511001130.desfilter(c,fid)
	return c:GetFlagEffectLabel(51101130)==fid and c:IsReason(REASON_DESTROY)
end
function c511001130.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(aux.FilterEqualFunction(Card.GetFlagEffectLabel,e:GetLabel(),51101130),1,nil) then
		g:DeleteGroup()
		e:Reset()
		return false
	end
	return eg:IsExists(aux.FilterEqualFunction(Card.GetFlagEffectLabel,e:GetLabel(),51101130),1,nil)
end
function c511001130.desop(e,tp,eg,ep,ev,re,r,rp)
	local resetg=eg:Filter(aux.FilterEqualFunction(Card.GetFlagEffectLabel,e:GetLabel(),51101130),nil,e:GetLabel())
	local ct=eg:FilterCount(c511001130.desfilter,nil,e:GetLabel())
	local rc=resetg:GetFirst()
	while rc do
		rc:ResetFlagEffect(51101130)
		rc=resetg:GetNext()
	end
	if ct<=0 then return end
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	Duel.Hint(HINT_CARD,0,511001130)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UPDATE_ATTACK)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetValue(-ct*600)
		tc:RegisterEffect(e3)
		tc=g:GetNext()
	end
end
