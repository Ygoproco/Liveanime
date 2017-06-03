--Dis-swing Fusion
function c511003002.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511003002.condition)
	e1:SetTarget(c511003002.target)
	e1:SetOperation(c511003002.activate)
	c:RegisterEffect(e1)
	if not c511003002.global_check then
		c511003002.global_check=true
		c511003002[0]=nil
		c511003002[1]=nil
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetOperation(c511003002.setup)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511003002.setup(e,tp,eg,ep,ev,re,r,rp)
	c511003002[0]=Duel.CreateToken(0,419)
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(511002961)
	c511003002[0]:RegisterEffect(e0)
	c511003002[1]=Duel.CreateToken(1,419)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(511002961)
	c511003002[1]:RegisterEffect(e1)
end
function c511003002.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsType(TYPE_PENDULUM)
end
function c511003002.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsControlerCanBeChanged() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,tg,1,0,0)
end
function c511003002.filter1(c,e)
	return not c:IsImmuneToEffect(e)
end
function c511003002.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and (not f or f(c)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
		and (c:CheckFusionMaterial(m,c511003002[0],chkf) or c:CheckFusionMaterial(m,c511003002[1],chkf))
end
function c511003002.activate(e,tp,eg,ep,ev,re,r,rp)
	local tgc=Duel.GetFirstTarget()
	if tgc and tgc:IsRelateToEffect(e) and Duel.NegateAttack() then
		Duel.GetControl(tgc,tp)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tgc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
		e2:SetOperation(c511003002.damop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tgc:RegisterEffect(e2)
	end
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetFusionMaterial(tp):Filter(c511003002.filter1,nil,e)
	local sg1=Duel.GetMatchingGroup(c511003002.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511003002.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if (sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0)) and Duel.SelectYesNo(tp,aux.Stringid(6205579,0)) then
		Duel.BreakEffect()
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1
			if tc:CheckFusionMaterial(mg1,c511003002[0],chkf) then
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c511003002[0])
				mat1:RemoveCard(c511003002[0])
			else
				mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c511003002[1])
				mat1:RemoveCard(c511003002[1])
			end
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end
function c511003002.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetOwner()
	Duel.ChangeBattleDamage(p,ev,false)
	Duel.ChangeBattleDamage(1-p,0,false)
end
