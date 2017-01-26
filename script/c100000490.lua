--デステニー・オーバーレイ
function c100000490.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000490.target)
	e1:SetOperation(c100000490.activate)
	c:RegisterEffect(e1)
end
function c100000490.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e) and not c:IsType(TYPE_TOKEN)
end
function c100000490.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg,mg:GetCount(),mg:GetCount())
end
function c100000490.cfilter(c)
	return not c:IsHasEffect(EFFECT_XYZ_MATERIAL)
end
function c100000490.xyzfilter2(c,g,matg,tp)
	local tg=matg:Clone()
	local mg=g:Clone()
	tg:AddCard(c)
	mg:RemoveCard(c)
	local g=tg:Filter(c100000490.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCode(EFFECT_XYZ_MATERIAL)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local res=Duel.IsExistingMatchingCard(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,tg) or mg:IsExists(c100000490.xyzfilter2,1,nil,mg,tg,tp)
	tc=g:GetFirst()
	while tc do
		tc:ResetEffect(EFFECT_XYZ_MATERIAL,RESET_CODE)
		tc=g:GetNext()
	end
	return res
end
function c100000490.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c100000490.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e)
	local g=Group.CreateGroup()
	if chk==0 then return mg:IsExists(c100000490.xyzfilter2,1,nil,mg,g,tp) end
	local tg=Group.CreateGroup()
	while not Duel.IsExistingMatchingCard(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,g) 
		or (mg:IsExists(c100000490.xyzfilter2,1,nil,mg,g,tp) and Duel.SelectYesNo(tp,513)) do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local sg=mg:FilterSelect(tp,c100000490.xyzfilter2,1,1,nil,mg,g,tp)
		local tc=sg:GetFirst()
		mg:RemoveCard(tc)
		g:AddCard(tc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_MATERIAL)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000490.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_MATERIAL)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local xyzg=Duel.GetMatchingGroup(c100000490.xyzfilter,tp,LOCATION_EXTRA,0,nil,g)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.XyzSummon(tp,xyz,g)
	end
end
