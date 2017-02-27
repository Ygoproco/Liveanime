--Ancient Gear Triple Bite Hound Dog
function c511001544.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	c511001544.material_count=2
	c511001544.material={42878636,511001540}
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_FUSION_MATERIAL)
	e0:SetCondition(c511001544.fcon)
	e0:SetOperation(c511001544.fop)
	c:RegisterEffect(e0)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c511001544.aclimit)
	e1:SetCondition(c511001544.actcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(2)
	c:RegisterEffect(e2)
end
function c511001544.matchk1(c,g,matg,fc,tp,chkf,ct)
	local mg=g:Clone()
	local tg=matg:Clone()
	tg:AddCard(c)
	mg:RemoveCard(c)
	local ctc=ct+1
	if ctc==3 then
		return c511001544.matchk3(tg,fc,tp,chkf)
	elseif ctc==2 then
		return c511001544.matchk2(tg,fc,tp,chkf) 
			or mg:IsExists(c511001544.matchk1,1,nil,mg,tg,fc,tp,chkf,ctc)
	else
		return mg:IsExists(c511001544.matchk1,1,nil,mg,tg,fc,tp,chkf,ctc)
	end
end
function c511001544.matchk2(g,fc,tp,chkf)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,tp) then return false end
	if chkf~=PLAYER_NONE and not g:IsExists(aux.FConditionCheckF,1,nil,chkf) then return false end
	local tc1=g:GetFirst()
	local tc2=g:GetNext()
	if tc1:IsHasEffect(511002961) then return tc2:IsFusionCode(511001540,42878636) or tc2:CheckFusionSubstitute(fc)
	elseif tc1:IsFusionCode(511001540) then return tc2:IsFusionCode(42878636) or tc2:CheckFusionSubstitute(fc)
	elseif tc1:IsFusionCode(42878636) then return tc2:IsFusionCode(511001540) or tc2:CheckFusionSubstitute(fc)
	elseif tc1:CheckFusionSubstitute(fc) then return tc2:IsFusionCode(511001540,42878636)
	else return false end
end
function c511001544.matchk3(g,fc,tp,chkf)
	if g:IsExists(aux.TuneMagFusFilter,1,nil,g,tp) then return false end
	local mg=g:Filter(c511001544.valfilter,nil)
	local sg=g:Filter(c511001544.subfilter,nil,fc)
	return (mg:GetCount()==3 or (mg:GetCount()==2 and sg:GetCount()==1)) and (chkf==PLAYER_NONE or g:IsExists(aux.FConditionCheckF,1,nil,chkf))
end
function c511001544.valfilter(c)
	return c:IsFusionCode(42878636) or c:IsHasEffect(511002961)
end
function c511001544.subfilter(c,fc)
	return c:CheckFusionSubstitute(fc) and not c:IsHasEffect(511002961) and not c:IsFusionCode(42878636)
end
function c511001544.fcon(e,g,gc,chkf)
	if g==nil then return true end
	local mg=g:Filter(Card.IsCanBeFusionMaterial,gc,e:GetHandler()):Filter(aux.FFilterCodeOrSub,nil,511001540,42878636,nil,nil,true,e:GetHandler())
	if gc then
		if not gc:IsCanBeFusionMaterial(e:GetHandler()) then return false end
		return c511001544.matchk1(gc,mg,Group.CreateGroup(),e:GetHandler(),tp,chkf,0)
	end
	return mg:IsExists(c511001544.matchk1,1,nil,mg,Group.CreateGroup(),e:GetHandler(),tp,chkf,0)
end
function c511001544.fop(e,tp,eg,ep,ev,re,r,rp,gc,chkfnf)
	local chkf=bit.band(chkfnf,0xff)
	local notfusion=bit.rshift(chkfnf,8)~=0
	local sub=sub or notfusion
	local g=eg:Filter(Card.IsCanBeFusionMaterial,nil,e:GetHandler()):Filter(aux.FFilterCodeOrSub,nil,511001540,42878636,nil,nil,true,e:GetHandler())
	local p=tp
	local sfhchk=false
	if Duel.IsPlayerAffectedByEffect(tp,511004008) and Duel.SelectYesNo(1-tp,65) then
		p=1-tp Duel.ConfirmCards(1-tp,g)
		if g:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then sfhchk=true end
	end
	local matg=Group.CreateGroup()
	if gc then
		g:RemoveCard(gc)
		matg:AddCard(gc)
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(p,c511001544.matchk1,1,1,nil,g,matg,e:GetHandler(),tp,chkf,1)
		matg:Merge(g1)
		g:Sub(g1)
		if not c511001544.matchk2(matg,e:GetHandler(),tp,chkf) 
			or (g:IsExists(c511001544.matchk1,1,nil,g,matg,e:GetHandler(),tp,chkf,2) and Duel.SelectYesNo(p,93)) then
			local g2=g:FilterSelect(p,c511001544.matchk1,1,1,nil,g,matg,e:GetHandler(),tp,chkf,2)
			matg:Merge(g2)
			g:Sub(g2)
		end
		matg:RemoveCard(gc)
		if sfhchk then Duel.ShuffleHand(tp) end
		Duel.SetFusionMaterial(matg)
		return
	end
	for i=1,2 do
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_FMATERIAL)
		local g1=g:FilterSelect(p,c511001544.matchk1,1,1,nil,g,matg,e:GetHandler(),tp,chkf,i-1)
		matg:Merge(g1)
		g:Sub(g1)
	end
	if not c511001544.matchk2(matg,e:GetHandler(),tp,chkf) 
		or (g:IsExists(c511001544.matchk1,1,nil,g,matg,e:GetHandler(),tp,chkf,2) and Duel.SelectYesNo(p,93)) then
		local g2=g:FilterSelect(p,c511001544.matchk1,1,1,nil,g,matg,e:GetHandler(),tp,chkf,2)
		matg:Merge(g2)
		g:Sub(g2)
	end
	if sfhchk then Duel.ShuffleHand(tp) end
	Duel.SetFusionMaterial(matg)
end
function c511001544.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511001544.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
