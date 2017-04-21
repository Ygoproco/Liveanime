--Cubic Mandala (movie)
function c511004440.initial_effect(c)
	local g=nil
	if not c511004440.g then
		g=Group.CreateGroup()
		c511004440.g=g
	else
		g=c511004440.g
	end  
	g:KeepAlive()
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511004440.target)
	e1:SetOperation(c511004440.operation)
	e1:SetLabelObject(g)
	c:RegisterEffect(e1)
	if not c511004440.global_check then
		c511004440.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROY)
		ge1:SetOperation(c511004440.gchk)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511004440.gclear)
		Duel.RegisterEffect(ge2,0)
		ge1:SetLabelObject(g)
		ge2:SetLabelObject(g)
	end
end
c511004440.g=nil
function c511004440.gchk(e,tp,eg,ev,ep,re,r,rp)
	local c=eg:GetFirst()
	local g=e:GetLabelObject()
	while c do
		if c:GetCounter(0x1038)~=0 then g:AddCard(c) end
		c=eg:GetNext()
	end
end
function c511004440.gclear(e,tp,eg,ev,ep,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()>0 then
		local c=g:GetFirst()
		while c do
			g:RemoveCard(c)
			c=g:GetNext()
		end
	end
end
function c511004440.sfilter(c,e,tp,g)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SPECIAL,tp,true,false) and (not g or g:IsContains(c))
end
function c511004440.target(e,tp,eg,ev,ep,re,r,rp,chk)
	local g=e:GetLabelObject()
	local sg=Duel.GetMatchingGroup(c511004440.sfilter,tp,0x30,0x30,nil,e,tp,g)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>=g:GetCount() and sg:GetCount()>0
		and g:GetCount()==sg:GetCount() and not (Duel.IsPlayerAffectedByEffect(tp,59822133) and sg:GetCount()>1) end
	Duel.SetTargetCard(sg)
end
function c511004440.operation(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local og=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if g:GetCount()>ft or (Duel.IsPlayerAffectedByEffect(tp,59822133) and g:GetCount()>1) then return end
	if not g:GetCount()==g:FilterCount(c511004440.sfilter,nil,e,tp) or not g:GetCount()==g:FilterCount(Card.IsRelateToEffect,nil,e) then return end
	local tc=g:GetFirst()
	local sg=Group.CreateGroup()
	while tc do
		if Duel.SpecialSummonStep(tc,SUMMON_TYPE_SPECIAL,tp,1-tp,true,false,POS_FACEUP) then
			--atk 0
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			--disable
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTargetRange(0x16,0)
			e2:SetTarget(c511004440.disable)
			e2:SetCode(EFFECT_DISABLE)
			e2:SetCondition(c511004440.disablecon)
			e2:SetLabel(1-tp)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
			sg:AddCard(tc)
		end
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	sg:KeepAlive()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetLabelObject(sg)
	e1:SetCondition(c511004440.descon)
	e1:SetOperation(c511004440.desop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	if g:GetCount()~=sg:GetCount() then return end
	tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1038,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetCondition(c511004440.lim)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE)
		tc:RegisterEffect(e2)
		c:SetCardTarget(tc)
		tc=g:GetNext()
	end
end
function c511004440.disable(e,c)
	return c:IsType(TYPE_MONSTER)
end
function c511004440.disablecon(e)
	return e:GetHandler():IsControler(e:GetLabel())
end
function c511004440.lim(e)
	return e:GetHandler():GetCounter(0x1038)>0
end
function c511004440.dfilter(c,sg)
	return sg:IsContains(c)
end
function c511004440.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCardTargetCount()==0 then return false end
	local sg=e:GetLabelObject()
	local lg=sg:Filter(c511004440.dfilter,nil,eg)
	sg:Sub(lg)
	return sg:GetCount()==0
end
function c511004440.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end