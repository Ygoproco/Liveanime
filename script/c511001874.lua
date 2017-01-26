--Rescue Xyz
function c511001874.initial_effect(c)
	--xyz effect
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001874.target)
	e1:SetOperation(c511001874.activate)
	c:RegisterEffect(e1)
end
function c511001874.filter(c)
	return c:IsFaceup() and c:GetOwner()~=c:GetControler()
end
function c511001874.cfilter(c)
	return not c:IsHasEffect(EFFECT_XYZ_MATERIAL)
end
function c511001874.xyzfilter(c,mg)
	local g=mg:Filter(c511001874.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_MATERIAL)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local res=c:IsXyzSummonable(mg)
	tc=g:GetFirst()
	while tc do
		tc:ResetEffect(EFFECT_XYZ_MATERIAL,RESET_CODE)
		tc=g:GetNext()
	end
	return res
end
function c511001874.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(c511001874.filter,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511001874.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,mg) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001874.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c511001874.filter,tp,0,LOCATION_MZONE,nil)
	local g=Duel.GetMatchingGroup(c511001874.xyzfilter,tp,LOCATION_EXTRA,0,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=g:Select(tp,1,1,nil):GetFirst()
		local g2=mg:Filter(c511001874.cfilter,nil)
		local tc=g2:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_XYZ_MATERIAL)
			e1:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e1)
			tc=g2:GetNext()
		end
		mg:KeepAlive()
		xyz:RegisterFlagEffect(999,RESET_CHAIN,0,0)
		Duel.XyzSummon(tp,xyz,mg,1,63)
	end
end
