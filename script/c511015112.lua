--Performapal Odd-Eyes Dissolver
--scripted by Sahim & Cybercatman 
function c511015112.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--pendulum fusion
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCost(c511015112.fuscost)
	e1:SetTarget(c511015112.fustg)
	e1:SetOperation(c511015112.fusop)
	c:RegisterEffect(e1)
	
	--fusion
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511015112.target)
	e2:SetOperation(c511015112.operation)
	c:RegisterEffect(e2)
		
	--summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511015112,0))
	e3:SetCategory(CATEGORY_DISABLE+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetRange(LOCATION_HAND)
	e3:SetCountLimit(1)
	e3:SetCondition(c511015112.sumcon)
	e3:SetTarget(c511015112.sumtarget)
	e3:SetOperation(c511015112.sumop)
	c:RegisterEffect(e3)
end

function c511015112.fuscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable() end
	Duel.Destroy(e:GetHandler(),REASON_COST)
end
function c511015112.filter1(c,e)
	return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end
function c511015112.filter2(c,e,tp,m,f,chkf,c2)
	return c:IsType(TYPE_FUSION) and (not f or f(c))
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,c2,chkf)
end
function c511015112.filter3(c)
	return c:IsCanBeFusionMaterial() 
end
function c511015112.fustg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c511015112.filter3,tp,LOCATION_MZONE,0,nil)
		local res=Duel.IsExistingMatchingCard(c511015112.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp):Filter(c511015112.filter3,nil)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c511015112.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015112.fusop(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c511015112.filter1,tp,LOCATION_MZONE,0,nil,e)
	local sg1=Duel.GetMatchingGroup(c511015112.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp):Filter(c511015112.filter3,nil)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511015112.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
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

function c511015112.filter0(c,e,dissolver)
	local seq=c:GetSequence()
	local tp = e:GetHandler():GetControler()
	return (seq==6 or seq==7) and c:IsCanBeFusionMaterial() 
		and Duel.IsExistingMatchingCard(c511015112.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(c,dissolver),nil,true,dissolver)
end
function c511015112.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 
		local res = Duel.IsExistingMatchingCard(c511015112.filter0,tp,LOCATION_SZONE,0,1,nil,e,e:GetHandler()) 
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg3=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c89181134.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg3,mf,true,e:GetHandler())
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511015112.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsImmuneToEffect(e) then return end
	local mg1=Duel.GetMatchingGroup(c511015112.filter0,tp,LOCATION_SZONE,0,nil,e,c)
	mg1:AddCard(c)
	local sg1=Duel.GetMatchingGroup(c511015112.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,true,c)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c511015112.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,true,c)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,c)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,c)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	end
end

function c511015112.sumcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:GetControler()~=d:GetControler()
end
function c511015112.sumtarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:GetControler()~=tp and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,g:GetCount(),0,0)
end
function c511015112.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	
	local tc=Duel.GetAttacker()
	if Duel.GetAttackTarget():IsControler(tp) then tc = Duel.GetAttackTarget() end
	
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
	tc:RegisterEffect(e1)
	--damage to 0
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c511015112.dop)
	e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e2,tp)
	
	tc=Duel.GetFirstTarget()	
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and Duel.SpecialSummon(c,SUMMON_TYPE_SPECIAL,tp,tp,false,false,POS_FACEUP) then
		--negate effects
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DISABLE_EFFECT)
		e4:SetValue(RESET_TURN_SET)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e4)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e5=Effect.CreateEffect(c)
			e5:SetType(EFFECT_TYPE_SINGLE)
			e5:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e5:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e5)
		end
		
		--dissolver indes
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e6:SetValue(1)
		e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e6)
		local e7=e6:Clone()
		e7:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e7)
	end
end
function c511015112.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end