--Montage Fusion
function c511015113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--fusion
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511015113,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511015113.target)
	e2:SetOperation(c511015113.operation)
	c:RegisterEffect(e2)
end
function c511015113.filter0(c)
	return c:IsFaceup() and c:IsCanBeFusionMaterial()
end
function c511015113.filter1(c,fc)
	local m = Duel.GetMatchingGroup(c511015113.filter0,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	return c:IsFaceup() and c:IsCanBeFusionMaterial(fc) and fc:CheckFusionMaterial(m,c)
end
function c511015113.filter2(c,e,tp)
	return c:IsType(TYPE_FUSION)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and Duel.IsExistingMatchingCard(c511015113.filter1,tp,LOCATION_MZONE,0,1,nil,c) 
		and Duel.IsExistingMatchingCard(c511015113.filter1,tp,0,LOCATION_MZONE,1,nil,c)
end
function c511015113.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511015113.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015113.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c511015113.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)

	if tg then
		local tc=tg:GetFirst()
		local mat1 = Group.CreateGroup()
		local mat2 = Group.CreateGroup()
		local m1 = Duel.GetMatchingGroup(c511015113.filter1,tp,LOCATION_MZONE,0,nil,tc)
		local m2 = Duel.GetMatchingGroup(c511015113.filter1,tp,0,LOCATION_MZONE,nil,tc)
		while not tc:CheckFusionMaterial(mat2) do	
			local c1 = m1:Select(tp,1,1,nil):GetFirst()
			mat1:AddCard(c1)
			m1:RemoveCard(c1)
			mat2=mat1:Clone()
			mat2:Merge(m2)
		end
		tc:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(511015113,RESET_EVENT+0x1fe0000,0,1)
		tc:CompleteProcedure()
			
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511015113.descon)
		e2:SetOperation(c511015113.desop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511015113.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:GetFlagEffect(511015113)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function c511015113.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end