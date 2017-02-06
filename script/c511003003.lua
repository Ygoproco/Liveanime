--ジェムナイトレディ・ブリリアント・ダイヤ
function c511003003.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c511003003.ffilter,3,true)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511003003.sptg)
	e2:SetOperation(c511003003.spop)
	c:RegisterEffect(e2)
	if not c511003003.global_check then
		c511003003.global_check=true
		c511003003[0]=Group.CreateGroup()
		c511003003[0]:KeepAlive()
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511003003.setop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511003003.setop(e,tp,eg,ep,ev,re,r,rp)
	if c511003003[0]:GetCount()>0 then return end
	for i=1,5 do
		local tc=Duel.CreateToken(0,419)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511002961)
		tc:RegisterEffect(e1)
		c511003003[0]:AddCard(tc)
	end
	for i=1,5 do
		local tc=Duel.CreateToken(1,419)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511002961)
		tc:RegisterEffect(e1)
		c511003003[0]:AddCard(tc)
	end
end
function c511003003.ffilter(c)
	return c:IsRace(RACE_ROCK) and c:IsFusionSetCard(0x1047)
end
function c511003003.filter(c,e,tp)
	return c:IsCanBeFusionMaterial() and Duel.IsExistingMatchingCard(c511003003.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c511003003.spfilter(c,e,tp,tc)
	return c:IsType(TYPE_FUSION) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and c:CheckFusionMaterial(c511003003[0],tc,tp)
end
function c511003003.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and c511003003.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 
		and Duel.IsExistingTarget(c511003003.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511003003.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511003003.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511003003.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc)
		local sc=g:GetFirst()
		if g:GetCount()>0 then
			sc:SetMaterial(Group.CreateGroup(tc))
			Duel.SendtoGrave(tc,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(sc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
