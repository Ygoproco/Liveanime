--V・HERO トリニティー
function c511017002.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511017002.fscon)
	e0:SetOperation(c511017002.fsop)
	c:RegisterEffect(e0)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511017002.regcon)
	e1:SetOperation(c511017002.regop)
	c:RegisterEffect(e1)
end
c511017002.material_setcode=0x5008
function c511017002.ffilter(c)
	return c:IsFusionSetCard(0x5008) and not c:IsHasEffect(6205579)
end
function c511017002.check1(c,mg,chkf)
	return mg:IsExists(c511017002.check2,1,c,c,chkf)
end
function c511017002.check2(c,c2,chkf)
	local g=Group.FromCards(c,c2)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,chkf) then return false end
	local g1=g:Filter(c511017002.ffilter,nil)
	if chkf~=PLAYER_NONE then
		return g1:FilterCount(aux.FConditionCheckF,nil,chkf)~=0 and g1:GetCount()>=2
	else return g1:GetCount()>=2 end
end
function c511017002.fscon(e,g,gc,chkfnf)
	if g==nil then return false end
	local chkf=bit.band(chkfnf,0xff)
	local mg=g:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return c511017002.check1(gc,mg,chkf)
	end
	return mg:IsExists(c511017002.check1,1,nil,mg,chkf)
end
function c511017002.fsop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local mg=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler())
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if mg:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	if gc then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=mg:FilterSelect(p,c511017002.check2,1,1,gc,gc,chkf)
		mg:Sub(g1)
		while mg:IsExists(Auxiliary.FConditionFilterExtraMaterial,1,nil,mg,c511017002.ffilter) and Duel.SelectYesNo(p,93) do
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
			local g2=mg:FilterSelect(p,Auxiliary.FConditionFilterExtraMaterial,1,1,nil,mg,c511017002.ffilter)
			g1:Merge(g2)
			mg:Sub(g2)
		end
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(g1)
		return
	end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(p,c511017002.check1,1,1,nil,mg,chkf)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(p,c511017002.check2,1,1,tc1,tc1,chkf)
	g1:Merge(g2)
	mg:Sub(g1)
	if mg:IsExists(Auxiliary.FConditionFilterExtraMaterial,1,nil,mg,c511017002.ffilter) and Duel.SelectYesNo(p,93) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g3=mg:FilterSelect(p,Auxiliary.FConditionFilterExtraMaterial,1,1,nil,mg,c511017002.ffilter)
		g1:Merge(g3)
		mg:Sub(g3)
	end
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(g1)
end
function c511017002.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_FUSION and e:GetHandler():GetMaterialCount()==3
end
function c511017002.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(c:GetBaseAttack()*2)
	c:RegisterEffect(e1)
end
