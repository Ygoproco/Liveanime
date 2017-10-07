--The Sun of God Dragon
--マイケル・ローレンス・ディーによってスクリプト
--scripted by MLD
--credit to TPD & Cybercatman
--updated by Larry126
function c513000134.initial_effect(c)
	--Summon with 3 Tribute
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c513000134.sumoncon)
	e1:SetOperation(c513000134.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c513000134.setcon)
	c:RegisterEffect(e2)
	--Summon Cannot be Negated
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e3)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c513000134.sumsuc)
	c:RegisterEffect(e4)
	--resurrection
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCountLimit(1)
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetCondition(c513000134.egpcon)
	e5:SetTarget(c513000134.immortal)
	c:RegisterEffect(e5)
	--unstoppable attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_UNSTOPPABLE_ATTACK)
	e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c513000134.imcon)
	c:RegisterEffect(e6)
	--[[tribute check
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_MATERIAL_CHECK)
	ea:SetValue(c513000134.valcheck)
	c:RegisterEffect(ea)
	--give atk effect only when summon
	local ex=Effect.CreateEffect(c)
	ex:SetType(EFFECT_TYPE_SINGLE)
	ex:SetCode(EFFECT_SUMMON_COST)
	ex:SetOperation(c513000134.facechk)
	ex:SetLabelObject(ea)
	c:RegisterEffect(ex)]]
	--chant
	local sum1=Effect.CreateEffect(c)
	sum1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	sum1:SetCode(EVENT_SUMMON_SUCCESS)
	sum1:SetOperation(c513000134.sumop)
	c:RegisterEffect(sum1)
	local sum2=sum1:Clone()
	sum2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(sum2)
	local sum3=sum1:Clone()
	sum3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(sum3)
	local sum=Effect.CreateEffect(c)
	sum:SetType(EFFECT_TYPE_SINGLE)
	sum:SetCode(513000134)
	sum:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(sum)
	if not c513000134.global_check then
		c513000134.global_check=true
	--De-Fusion
		local df=Effect.CreateEffect(c)
		df:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		df:SetCode(EVENT_ADJUST)
		df:SetOperation(c513000134.dfop)
		Duel.RegisterEffect(df,0)
	--hierarchy
		if Duel.GetFlagEffect(0,513000065)==0 and Duel.GetFlagEffect(1,513000065)==0 then
			Duel.RegisterFlagEffect(0,513000065,0,0,1)
			Duel.RegisterFlagEffect(1,513000065,0,0,1)
		--rank
			local rank1=Effect.CreateEffect(c)
			rank1:SetType(EFFECT_TYPE_FIELD)
			rank1:SetCode(513000065)
			rank1:SetTarget(c513000134.rank1)
			rank1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
			Duel.RegisterEffect(rank1,0) 
			local rank2=Effect.CreateEffect(c)
			rank2:SetType(EFFECT_TYPE_FIELD)
			rank2:SetCode(513000065)
			rank2:SetTarget(c513000134.rank2)
			rank2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IGNORE_RANGE)
			Duel.RegisterEffect(rank2,0)
			local immunity=Effect.CreateEffect(c)
			immunity:SetType(EFFECT_TYPE_FIELD)
			immunity:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			immunity:SetCode(EFFECT_IMMUNE_EFFECT)
			immunity:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			immunity:SetTarget(c513000134.hrtg)
			immunity:SetValue(c513000134.hrfilter)
			Duel.RegisterEffect(immunity,0)
			--control
			local control=Effect.CreateEffect(c)
			control:SetType(EFFECT_TYPE_FIELD)
			control:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			control:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			control:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
			control:SetTarget(c513000134.control)
			Duel.RegisterEffect(control,0)
		--last 1 turn
			local last=Effect.CreateEffect(c)
			last:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			last:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			last:SetCode(EVENT_ADJUST)
			last:SetTarget(c513000134.lasttg)
			last:SetOperation(c513000134.lastop)
			Duel.RegisterEffect(last,0)
			local check=Effect.CreateEffect(c)
			check:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			check:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			check:SetCode(EVENT_CHAINING)
			check:SetOperation(c513000134.sdop)
			Duel.RegisterEffect(check,0)
		end
	end
end
function c513000134.sdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=re:GetHandler()
	if tc:GetFlagEffect(1211920)>0 then
		tc:ResetFlagEffect(1211920)
	end
	tc:RegisterFlagEffect(1211920,RESET_EVENT+0x1fe0000,0,1,Duel.GetTurnCount()) 
	if re:IsHasProperty(EFFECT_FLAG_IGNORE_IMMUNE) then tc:RegisterFlagEffect(128,0,0,0) end
end
function c513000134.rank1(e,c)
	local code1,code2=c:GetOriginalCodeRule() 
	return c:IsFaceup()
		and (code1==10000000 or code1==10000010 or code1==10000020
		or code1==62180201 or code1==57793869 or code1==21208154
		or code2==10000000 or code2==10000010 or code2==10000020
		or code2==62180201 or code2==57793869 or code2==21208154)
end
function c513000134.rank2(e,c)
	local code1,code2=c:GetOriginalCodeRule() 
	return c:IsFaceup() and (code1==10000010 or code1==21208154 or code2==10000010 or code2==21208154)
end
function c513000134.hrtg(e,c)
	return c:IsHasEffect(513000065) and c:IsFaceup()
end
function c513000134.hrfilter(e,te,c)
	if not te then return false end
	if not c:IsHasEffect(513000065) or not c:IsFaceup() then return false end
	local tc=te:GetOwner()
	return (te:IsActiveType(TYPE_MONSTER) and c~=tc
		and c:GetEffectCount(513000065)>tc:GetEffectCount(513000065))
		or (te:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
		and te:IsActiveType(TYPE_SPELL+TYPE_TRAP))
		or (tc:GetFlagEffectLabel(1211920) 
		and te:GetType()==EFFECT_TYPE_EQUIP 
		and Duel.GetTurnCount()-tc:GetFlagEffectLabel(1211920)>=1
		and Duel.GetTurnCount()-c:GetTurnID()>=1)
end
function c513000134.control(e,c)
	return c:IsHasEffect(513000065) and c:IsFaceup() and not c:IsHasEffect(513000134)
end
function c513000134.lastfilter(c)
	return c:GetFlagEffect(51300065)>0
end
function c513000134.lasttg(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,LOCATION_MZONE,nil,513000065)
	return g:IsExists(aux.NOT(c513000134.lastfilter),1,nil)
end
function c513000134.lastop(e,tp,eg,ev,ep,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsHasEffect,tp,LOCATION_MZONE,LOCATION_MZONE,nil,513000065)
	local tg=g:Filter(aux.NOT(c513000134.lastfilter),nil)
	tg:ForEach(function(c)
		c:RegisterFlagEffect(51300065,RESET_EVENT+0x1fe0000,0,1)
		--If Special Summoned: Send to previous location
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(4010,8))
		e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_TOHAND+CATEGORY_TODECK)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_MZONE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetCondition(c513000134.stgcon)
		e1:SetTarget(c513000134.stgtg)
		e1:SetOperation(c513000134.stgop)
		c:RegisterEffect(e1)
		--ATK/DEF effects are only applied until the End Phase
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetCountLimit(1)
		e2:SetCondition(c513000134.atkdefresetcon)
		e2:SetOperation(c513000134.atkdefresetop)
		c:RegisterEffect(e2)
		--release limit
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_UNRELEASABLE_SUM)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		e3:SetValue(c513000134.recon)
		c:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCondition(c513000134.recon2)
		e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		c:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetDescription(aux.Stringid(4010,9))
		e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e5:SetCode(EVENT_BE_BATTLE_TARGET)
		e5:SetRange(LOCATION_MZONE)
		e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		e5:SetCondition(c513000134.negatkcon)
		e5:SetOperation(c513000134.negatkop)
		c:RegisterEffect(e5)
	end)
end
function c513000134.negatkcon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetAttacker()
	return ac:IsHasEffect(513000065) 
		and e:GetHandler():GetEffectCount(513000065)>ac:GetEffectCount(513000065)
end
function c513000134.negatkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c513000134.recon(e,c)
	return e:GetHandler():IsHasEffect(513000065) and c:GetControler()~=e:GetHandler():GetControler()
end
function c513000134.recon2(e)
	return e:GetHandler():IsHasEffect(513000065) and Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end
function c513000134.atkdefresetcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(513000065)
end
function c513000134.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(nil,tp,0xff,0xff,c)
	for tc in aux.Next(g) do
		if tc:GetOriginalCode()~=c:GetOriginalCode() and tc:GetFlagEffect(128)==0 then
			c:ResetEffect(tc:GetOriginalCode(),RESET_CARD)
			tc:ResetFlagEffect(128)
		end
	end
end
function c513000134.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and e:GetHandler():IsHasEffect(513000065)
end
function c513000134.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	if c:IsPreviousLocation(LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_DECK) then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_HAND) then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,c,1,0,0)
	elseif c:IsPreviousLocation(LOCATION_REMOVED) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,c,1,0,0)
	end
end
function c513000134.stgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		if c:IsPreviousLocation(LOCATION_GRAVE) then
			Duel.SendtoGrave(c,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_DECK) then
			Duel.SendtoDeck(c,nil,2,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_HAND) then
			Duel.SendtoHand(c,nil,REASON_EFFECT)
		elseif c:IsPreviousLocation(LOCATION_REMOVED) then
			Duel.Remove(c,POS_FACEUP,REASON_EFFECT)
		end
	end
end
-------------------------------------------
--De-Fusion
function c513000134.dfop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()  
	local g=Duel.GetMatchingGroup(Card.IsCode,c:GetControler(),0xff,0xff,nil,95286165)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(513000134)==0 then
			--Activate
			local e1=Effect.CreateEffect(tc)
			e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e1:SetDescription(aux.Stringid(4012,8))
			e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE+CATEGORY_RECOVER)
			e1:SetType(EFFECT_TYPE_ACTIVATE)
			e1:SetCode(EVENT_FREE_CHAIN)
			e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetHintTiming(0,TIMING_DRAW_PHASE+TIMING_END_PHASE)
			e1:SetTarget(c513000134.tg)
			e1:SetOperation(c513000134.op)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(513000134,0,0,1)   
		end
		tc=g:GetNext()
	end
end
function c513000134.dffilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and (c:IsCode(10000010) or c:IsCode(511000237))
end
function c513000134.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c513000134.dffilter2(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c513000134.dffilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c513000134.dffilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
end
function c513000134.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not (tc:IsRelateToEffect(e) and tc:IsFaceup()) then return end
	local atk=tc:GetAttack()
	tc:ResetEffect(RESET_LEAVE,RESET_EVENT)
	Duel.Recover(tp,atk,REASON_EFFECT)
	tc:RegisterFlagEffect(236,RESET_EVENT+0x1fe0000,0,1)
	if Duel.GetAttacker() and Duel.GetAttacker()==tc then Duel.NegateAttack() end
	if Duel.GetCurrentChain()<=1 then return end
	for i=1,Duel.GetCurrentChain()-1 do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local g=Duel.GetChainInfo(i,CHAININFO_TARGET_CARDS)
		if te:IsHasProperty(EFFECT_FLAG_CARD_TARGET) and g:IsContains(tc) then
			local rg=Group.CreateGroup()
			rg:Merge(g)
			rg:RemoveCard(tc)
			Duel.ChangeTargetCard(i,rg)
		end
	end
end
-------------------------------------------
function c513000134.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c513000134.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c513000134.setcon(e,c)
	if not c then return true end
	return false
end
function c513000134.imcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
-------------------------------------------
function c513000134.egpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c513000134.immortal(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c513000134.payatkcost(e,tp,eg,ep,ev,re,r,rp,0) then
		local op=Duel.SelectOption(tp,aux.Stringid(4012,3),aux.Stringid(4012,4),aux.Stringid(4012,5))
		if op==0 then
			c513000134.payatkcost(e,tp,eg,ep,ev,re,r,rp,1)
			e:SetOperation(c513000134.payatkop)
		elseif op==1 then
			e:SetOperation(c513000134.egpop)
		else
			e:SetOperation(nil)
		end
	else
		local op=Duel.SelectOption(tp,aux.Stringid(4012,4),aux.Stringid(4012,5))
		if op==0 then
			e:SetOperation(c513000134.egpop)
		else
			e:SetOperation(nil)
		end
	end
end
-------------------------------------------
--Point to Point Transfer
function c513000134.payatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2) end
	local lp=Duel.GetLP(tp)
	e:SetLabel(lp-1)
	Duel.PayLPCost(tp,lp-1)
end
function c513000134.payatkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lp=e:GetLabel()
	if c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c:GetBaseAttack()+lp)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(c:GetBaseDefense()+lp)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_ADD_TYPE)
		e3:SetValue(TYPE_FUSION)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3)
		local def=Effect.CreateEffect(c)
		def:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(def)
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(4012,6))
		e4:SetType(EFFECT_TYPE_QUICK_O)
		e4:SetCode(EVENT_FREE_CHAIN)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCost(c513000134.tatkcost)
		e4:SetOperation(c513000134.tatkop)
		e4:SetLabelObject(def)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e4)
		--gain atk/def
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e5:SetCode(EVENT_RECOVER)
		e5:SetRange(LOCATION_MZONE)
		e5:SetOperation(c513000134.atkop1)
		e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e5)
		--gain atk/def
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e6:SetCode(EVENT_CHAIN_END)
		e6:SetRange(LOCATION_MZONE)
		e6:SetOperation(c513000134.atkop2)
		e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e6)
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_FIELD)
		e7:SetRange(LOCATION_MZONE)
		e7:SetTargetRange(0,LOCATION_MZONE)
		e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e7:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e7:SetTarget(c513000134.valtg)
		e7:SetValue(c513000134.vala)
		e7:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e7)
		local e8=Effect.CreateEffect(c)
		e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e8:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
		e8:SetCode(EVENT_DAMAGE_STEP_END)
		e8:SetCondition(c513000134.dircon)
		e8:SetOperation(c513000134.dirop)
		e8:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e8)
		local e9=Effect.CreateEffect(c)
		e9:SetType(EFFECT_TYPE_SINGLE)
		e9:SetCode(EFFECT_EXTRA_ATTACK)
		e9:SetValue(9999)
		e9:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e9)
		local e10=Effect.CreateEffect(c)
		e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e10:SetCode(EVENT_DAMAGE_STEP_END)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e10:SetCondition(c513000134.uncon)
		e10:SetOperation(c513000134.unop)
		e10:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e10)
	end
end
function c513000134.atkop1(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end
function c513000134.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	if lp<=1 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end
function c513000134.tatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,10,e:GetHandler())
	local tc=g:GetFirst()
	local suma=0
	local sumd=0
	while tc do
		suma=suma+tc:GetAttack()
		sumd=sumd+tc:GetDefense()
		tc=g:GetNext()
	end
	e:SetLabel(suma)
	e:GetLabelObject():SetLabel(sumd)
	Duel.Release(g,REASON_COST)
end
function c513000134.tatkop(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetLabel()
	local def=e:GetLabelObject():GetLabel()
	local c=e:GetHandler()
	if c:GetFlagEffect(236)>0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(def)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c513000134.uncon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsRelateToBattle()
end
function c513000134.unop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	bc:RegisterFlagEffect(511000237,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c513000134.valtg(e,c)
	return c:GetFlagEffect(511000237)>0
end
function c513000134.vala(e,c)
	return c==e:GetHandler()
end
function c513000134.dircon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()==e:GetHandler()
end
function c513000134.dirop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	e:GetHandler():RegisterEffect(e1)
end
-------------------------------------------
--Egyption God Phoenix
function c513000134.egpop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+0x1fe1000+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(511000237)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetDescription(aux.Stringid(4012,7))
		e2:SetCategory(CATEGORY_DESTROY)
		e2:SetType(EFFECT_TYPE_QUICK_O)
		e2:SetCode(EVENT_FREE_CHAIN)
		e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCost(c513000134.descost)
		e2:SetTarget(c513000134.destg)
		e2:SetOperation(c513000134.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		--immune
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_INDESTRUCTABLE)
		c:RegisterEffect(e4)
		local e5=e3:Clone()
		e5:SetCode(EFFECT_UNRELEASABLE_EFFECT)
		c:RegisterEffect(e5)
		local e6=e3:Clone()
		e6:SetCode(EFFECT_CANNOT_REMOVE)
		c:RegisterEffect(e6)
		local e7=e3:Clone()
		e7:SetCode(EFFECT_CANNOT_TO_HAND)
		c:RegisterEffect(e7)
		local e8=e3:Clone()
		e8:SetCode(EFFECT_CANNOT_TO_DECK)
		c:RegisterEffect(e8)
		local e9=e3:Clone()
		e9:SetCode(EFFECT_CANNOT_TO_GRAVE)
		c:RegisterEffect(e9)
	end
end
function c513000134.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c513000134.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsDestructable(e) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c513000134.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetValue(c513000134.desfil)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e3)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		Duel.BreakEffect()
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c513000134.desfil(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c513000134.kek(e)
	return true
end
function c513000134.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
--[[	local chant=true
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(4012,9))
	local op=Duel.SelectOption(tp,aux.Stringid(4012,10),aux.Stringid(4012,11),aux.Stringid(4012,12),aux.Stringid(4012,13),aux.Stringid(4012,14),aux.Stringid(4012,15))
	if op~=3 then
		local op2=Duel.SelectOption(1-tp,aux.Stringid(4012,10),aux.Stringid(4012,11),aux.Stringid(4012,12),aux.Stringid(4012,13),aux.Stringid(4012,14),aux.Stringid(4012,15))
		if op2~=3 then
			chant=false
		else
			if not Duel.GetControl(c,1-tp) then
				chant=false
			end
		end
	end
	if chant==false then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCondition(c513000134.kek)
		c:RegisterEffect(e3)
	end
	Duel.BreakEffect()]]
	--control
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e6:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e6)
	if e:GetCode()~=EVENT_SUMMON_SUCCESS then return end
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	local def=0
	while tc do
		local catk=tc:GetPreviousAttackOnField()
		local cdef=tc:GetPreviousDefenseOnField()
		atk=atk+(catk>=0 and catk or 0)
		def=def+(cdef>=0 and cdef or 0)
		tc=g:GetNext()
	end
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_SET_BASE_ATTACK)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(atk)
	e4:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_BASE_DEFENSE)
	e5:SetValue(def)
	c:RegisterEffect(e5)
end
-------------------------------------------
--redundant
function c513000134.valcheck(e,c)
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	local def=0
	while tc do
		local catk=tc:GetTextAttack()
		local cdef=tc:GetTextDefense()
		atk=atk+(catk>=0 and catk or 0)
		def=def+(cdef>=0 and cdef or 0)
		tc=g:GetNext()
	end
	if e:GetLabel()==1 then
		e:SetLabel(0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0xff0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(def)
		c:RegisterEffect(e2)
	end
end
function c513000134.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end