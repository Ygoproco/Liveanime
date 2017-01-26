--Dimension Xyz
function c511000698.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000698.condition)
	e1:SetTarget(c511000698.target)
	e1:SetOperation(c511000698.operation)
	c:RegisterEffect(e1)
end
function c511000698.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1000
end
function c511000698.filter(c,g,matg,ct,tp)
	local tg=matg:Clone()
	local mg=g:Filter(Card.IsCode,nil,c:GetCode())
	mg:RemoveCard(c)
	tg:AddCard(c)
	local ctc=ct+1
	if ctc==3 then
		return Duel.IsExistingMatchingCard(c511000698.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,tg)
	else
		return mg:IsExists(c511000698.filter,1,nil,mg,tg,ctc,tp)
	end
end
function c511000698.xyzfilter(c,g)
	return c:IsXyzSummonable(g,3,3)
end
function c511000698.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0x1e,0,nil)
	if chk==0 then return g:IsExists(c511000698.filter,1,nil,g,Group.CreateGroup(),0,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000698.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0x1e,0,nil)
	local matg=Group.CreateGroup()
	for i=1,3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local sg=g:FilterSelect(tp,c511000698.filter,1,1,nil,g,matg,i-1,tp)
		local tc=sg:GetFirst()
		g=g:Filter(Card.IsCode,nil,tc:GetCode())
		matg:AddCard(tc)
		g:RemoveCard(tc)
	end
	local xyzg=Duel.GetMatchingGroup(c511000698.xyzfilter,tp,LOCATION_EXTRA,0,nil,matg)
	if xyzg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		matg:KeepAlive()
		Duel.XyzSummon(tp,xyz,matg)
	end
end
