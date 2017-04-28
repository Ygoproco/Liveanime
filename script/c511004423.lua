--Odd-Eyes Phantasma Dragon
function Auxiliary.PConditionFilter(c,e,tp,lscale,rscale)
	local lv=0
	if c.pendulum_level then
		lv=c.pendulum_level
	else
		lv=c:GetLevel()
	end
	return (c:IsLocation(LOCATION_HAND) or (c:IsFaceup() and c:IsType(TYPE_PENDULUM)))
		and ((lv>lscale and lv<rscale) or c:IsHasEffect(511004423)) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_PENDULUM,tp,false,false)
		and not c:IsForbidden()
end
function c511004423.initial_effect(c)
	--pendulum sokan (pendulum e0/e1+can bypass scale e2)
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(1160)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetRange(LOCATION_HAND)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC_G)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,10000000)
	e1:SetCondition(c511004423.condition())
	e1:SetOperation(c511004423.operation())
	e1:SetValue(SUMMON_TYPE_PENDULUM)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(511004423)
	e2:SetCondition(c511004423.ospcondition)
	c:RegisterEffect(e2)
	--attack
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511004423.con)
	e3:SetTarget(c511004423.tg)
	e3:SetOperation(c511004423.op)
	c:RegisterEffect(e3)
end
function c511004423.ospcondition(c)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_EXTRA,0,1,nil,0x99)
end
function c511004423.condition()
	return  function(e,c,og)
				if c==nil then return true end
				local tp=c:GetControler()
				local lpz=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
				if lpz==nil then return false end
				local rpz=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
				if rpz==nil then return false end
				local lscale=lpz:GetLeftScale()
				local rscale=rpz:GetRightScale()
				if lscale>rscale then lscale,rscale=rscale,lscale end
				local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
				if ft<=0 then return false end
				if og then
					return og:IsExists(Auxiliary.PConditionFilter,1,nil,e,tp,lscale,rscale)
				else
					return Duel.IsExistingMatchingCard(Auxiliary.PConditionFilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,lscale,rscale)
				end
			end
end
function c511004423.operation()
	return  function(e,tp,eg,ep,ev,re,r,rp,c,sg,og)
				local lpz=Duel.GetFieldCard(tp,LOCATION_SZONE,6)
				local rpz=Duel.GetFieldCard(tp,LOCATION_SZONE,7)
				local lscale=lpz:GetLeftScale()
				local rscale=rpz:GetRightScale()
				if lscale>rscale then lscale,rscale=rscale,lscale end
				local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
				if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
				local tg=nil
				if og then
					tg=og:Filter(tp,Auxiliary.PConditionFilter,nil,e,tp,lscale,rscale)
				else
					tg=Duel.GetMatchingGroup(Auxiliary.PConditionFilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,nil,e,tp,lscale,rscale)
				end
				local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
				if ect and (ect<=0 or ect>ft) then ect=nil end
				if ect==nil or tg:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA)<=ect then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
					local g=tg:Select(tp,1,ft,nil)
					sg:Merge(g)
				else
					repeat
						local ct=math.min(ft,ect)
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
						local g=tg:Select(tp,1,ct,nil)
						tg:Sub(g)
						sg:Merge(g)
						ft=ft-g:GetCount()
						ect=ect-g:FilterCount(Card.IsLocation,nil,LOCATION_EXTRA)
					until ft==0 or ect==0 or not Duel.SelectYesNo(tp,210)
					local hg=tg:Filter(Card.IsLocation,nil,LOCATION_HAND)
					if ft>0 and ect==0 and hg:GetCount()>0 and Duel.SelectYesNo(tp,210) then
						Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
						local g=hg:Select(tp,1,ft,nil)
						sg:Merge(g)
					end
				end
				Duel.HintSelection(Group.FromCards(c))
				Duel.HintSelection(Group.FromCards(rpz))
			end
end
function c511004423.con(e,tp,eg,ev,ep,re,r,rp)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	return a==c
end
function c511004423.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c511004423.filter2(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and not c:IsImmuneToEffect(e)
end
function c511004423.tg(e,tp,eg,ev,ep,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511004423.filter2,tp,0,LOCATION_ONFIELD,1,nil,e,tp) and Duel.IsExistingMatchingCard(c511004423.filter1,tp,LOCATION_EXTRA,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511004423.filter2,tp,0,LOCATION_ONFIELD,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,g:GetCount(),0,0)
end
function c511004423.op(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.GetMatchingGroupCount(c511004423.filter1,tp,LOCATION_EXTRA,0,nil)
	local gc=g:GetFirst()
	while gc and ct>0 do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-ct*1000)
		gc:RegisterEffect(e1)
		gc=g:GetNext()
	end
end
