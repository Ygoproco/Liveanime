--Dimension Magic
--Scripted by Edo9300
--updated by Larry126
function c511004004.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetCondition(c511004004.condition)
	e1:SetCost(c511004004.cost)
	e1:SetTarget(c511004004.target)
	e1:SetOperation(c511004004.activate)
	c:RegisterEffect(e1)
end
function c511004004.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c511004004.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511004004.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511004004.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511004004.rfilter(c,fid)
	return c:IsReleasable() and c:GetFieldID()~=fid
end
function c511004004.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		while tc do
			if Duel.CheckReleaseGroup(tp,Card.IsReleasable,2,tc) then
				ch=1
				tc=nil
			else
				ch=0
				tc=tg:GetNext()
			end
		end
	end
	if chk==0 then return ch==1 end
	local g1=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,nil)
	local ct=g1:GetCount()
	if ct>2 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasable,2,2,nil)
	elseif ct==1 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasable,2,2,g1:GetFirst())
	elseif ct==2 then
		g=Duel.SelectReleaseGroup(tp,Card.IsReleasable,1,1,nil)
		g1=Duel.GetMatchingGroup(c511004004.cfilter,tp,LOCATION_MZONE,0,g:GetFirst())
		if g1:GetCount()==2 then
			g:AddCard(Duel.SelectReleaseGroup(tp,Card.IsReleasable,1,1,g:GetFirst()):GetFirst())
		else
			g:AddCard(Duel.SelectReleaseGroup(tp,c511004004.rfilter,1,1,g:GetFirst(),g1:GetFirst():GetFieldID()):GetFirst())
		end
	end
	Duel.Release(g,REASON_COST)
end
function c511004004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c511004004.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	local g=Duel.GetMatchingGroup(c511004004.filter,tp,LOCATION_HAND,0,nil,e,tp)
	Duel.SetOperationInfo(g,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511004004.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511004004.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		if Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)>0 then
			local fid=e:GetHandler():GetFieldID()
			sg:KeepAlive()
			sg:GetFirst():RegisterFlagEffect(511004004,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCategory(CATEGORY_TOHAND)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetRange(LOCATION_MZONE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetLabel(fid)
			e1:SetLabelObject(sg)
			e1:SetCondition(c511004004.rmcon)
			e1:SetOperation(c511004004.rmop)
			Duel.RegisterEffect(e1,tp)
			if Duel.IsExistingMatchingCard(Card.IsRace,tp,LOCATION_MZONE,0,2,nil,RACE_SPELLCASTER) 
				and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				local dg=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
				Duel.HintSelection(dg)
				Duel.Destroy(dg,REASON_BATTLE)
			end
		end
	end
end
function c511004004.rmfilter(c,fid)
	return c:GetFlagEffectLabel(511004004)==fid
end
function c511004004.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511004004.rmfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511004004.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511004004.rmfilter,nil,e:GetLabel())
	Duel.SendtoHand(tg,tg:GetFirst():GetOwner(),REASON_EFFECT)
end