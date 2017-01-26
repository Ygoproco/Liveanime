--銀河暴竜
function c511002848.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24658418,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002848.condition)
	e1:SetTarget(c511002848.target)
	e1:SetOperation(c511002848.operation)
	c:RegisterEffect(e1)
end
function c511002848.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsCode(93717133)
end
function c511002848.xyzfilter(c,e,tp,a,sc)
	return (c.minxyzct==3 or c.maxxyzct>=3) and c.xyz_filter(a) and c.xyz_filter(sc) and a:IsCanBeXyzMaterial(c) and sc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511002848.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttackTarget()
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511002848.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,a,c) end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511002848.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttackTarget()
	local c=e:GetHandler()
	if not a or not a:IsRelateToEffect(e) or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511002848.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,tp,a,c)
	if g:GetCount()>0 then
		local mg=Group.CreateGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local xyz=g:Select(tp,1,1,nil):GetFirst()
		mg:AddCard(c)
		mg:AddCard(a)
		xyz:SetMaterial(mg)
		Duel.Overlay(xyz,mg)
		Duel.SpecialSummon(xyz,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		xyz:CompleteProcedure()
	end
end
