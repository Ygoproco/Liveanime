--Numeron Chaos Ritual
function c511000295.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000295.condition)
	e1:SetTarget(c511000295.target)
	e1:SetOperation(c511000295.activate)
	c:RegisterEffect(e1)
	if not c511000295.global_check then
		c511000295.global_check=true
		c511000295[0]=false
		c511000295[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c511000295.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511000295.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000295.cfilter(c)
	return c:GetPreviousCodeOnField()==511000277
end
function c511000295.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000295.cfilter,nil)
	local tc=g:GetFirst()
	while tc do
		c511000295[tc:GetPreviousControler()]=true
		tc=g:GetNext()
	end
end
function c511000295.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000295[0]=false
	c511000295[1]=false
end
function c511000295.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511000295[tp]
end
function c511000295.filterchk1(c,mg,matg,tp)
	local g=mg:Clone()
	local tg=matg:Clone()
	g:RemoveCard(c)
	tg:AddCard(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(TYPE_MONSTER)
	e1:SetReset(RESET_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_XYZ_LEVEL)
	e2:SetValue(12)
	e2:SetReset(RESET_CHAIN)
	c:RegisterEffect(e2)
	local res=g:IsExists(c511000295.filterchk2,1,nil,g,tg,0,tp)
	e1:Reset()
	e2:Reset()
	return res
end
function c511000295.filterchk2(c,mg,matg,ct,tp)
	local g=mg:Clone()
	local tg=matg:Clone()
	g:RemoveCard(c)
	tg:AddCard(c)
	local ctc=ct+1
	local res=false
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_XYZ_LEVEL)
	e1:SetValue(12)
	e1:SetReset(RESET_CHAIN)
	c:RegisterEffect(e1)
	if ctc==4 then
		res=Duel.IsExistingMatchingCard(c511000295.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,tg)
	else
		res=g:IsExists(c511000295.filterchk2,1,nil,g,tg,ctc,tp)
	end
	e1:Reset()
	return res
end
function c511000295.xyzfilter(c,mg)
	return c:IsXyzSummonable(mg,5,5)
end
function c511000295.matfilter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_MONSTER)
end
function c511000295.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg1=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,0,nil,511000275)
	local mg2=Duel.GetMatchingGroup(c511000295.matfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg1:IsExists(c511000295.filterchk1,1,nil,mg2,Group.CreateGroup(),tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511000295.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local matg=Group.CreateGroup()
	local mg1=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,0,nil,511000275)
	local mg2=Duel.GetMatchingGroup(c511000295.matfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg1=mg1:FilterSelect(tp,c511000295.filterchk1,1,1,nil,mg2,matg,tp)
	local tc1=sg1:GetFirst()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(TYPE_MONSTER)
	e1:SetReset(RESET_CHAIN)
	tc1:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_XYZ_LEVEL)
	e2:SetValue(12)
	e2:SetReset(RESET_CHAIN)
	tc1:RegisterEffect(e2)
	matg:AddCard(tc1)
	mg2:RemoveCard(tc1)
	for i=1,4 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local sg2=mg2:FilterSelect(tp,c511000295.filterchk2,1,1,nil,mg2,matg,i-1,tp)
		local tc2=sg2:GetFirst()
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_XYZ_LEVEL)
		e2:SetValue(12)
		e2:SetReset(RESET_CHAIN)
		tc2:RegisterEffect(e2)
		matg:AddCard(tc2)
		mg2:RemoveCard(tc2)
	end
	local xyzg=Duel.GetMatchingGroup(c511000295.xyzfilter,tp,LOCATION_EXTRA,0,nil,matg)
	if xyzg:GetCount()>0 then
		Duel.HintSelection(matg)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=xyzg:Select(tp,1,1,nil):GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		Duel.XyzSummon(tp,xyz,matg)
	end
end
