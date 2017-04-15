--Speed Duel
--Scripted by Edo9300
--fixed by MLD
function c511004001.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xff)
	e1:SetCondition(c511004001.con)
	e1:SetOperation(c511004001.op)
	c:RegisterEffect(e1)
	--protection
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_TO_DECK) 
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e6)
end
function c511004001.con(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnCount()==1
end
function c511004001.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,511004001) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Hint(HINT_CARD,0,511004001)
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		--todeck
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		local hct=g:GetCount()-math.ceil(g:GetCount()/5)
		g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
		Duel.SendtoDeck(g,nil,2,REASON_RULE)
		Duel.ShuffleDeck(tp)
		Duel.ShuffleDeck(1-tp)
		--halve LP
		local lp1=Duel.GetLP(tp)
		Duel.SetLP(tp,math.ceil(lp1/2))
		local lp2=Duel.GetLP(1-tp)
		Duel.SetLP(1-tp,math.ceil(lp2/2))
		--half deck
		local dg1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_DECK,0,nil)
		if dg1:GetCount()>30 then
			local rg1=dg1:Select(tp,dg1:GetCount()-30,dg1:GetCount()-20,nil)
			Duel.SendtoDeck(rg1,nil,-2,REASON_RULE)
		end
		local dg2=Duel.GetMatchingGroup(aux.TRUE,1-tp,LOCATION_DECK,0,nil)
		if dg2:GetCount()>30 then
			local rg2=dg2:Select(1-tp,dg2:GetCount()-30,dg2:GetCount()-20,nil)
			Duel.SendtoDeck(rg2,nil,-2,REASON_RULE)
		end
		--reduce extra
		local eg1=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_EXTRA,0,nil)
		if eg1:GetCount()>5 and eg1:GetCount()<=15 then
			rg1=eg1:Select(tp,eg1:GetCount()-5,eg1:GetCount(),nil)
			Duel.SendtoDeck(rg1,nil,-2,REASON_RULE)
		elseif eg1:GetCount()>15 then
			rg1=eg1:Select(tp,10,15,nil)
			Duel.SendtoDeck(rg1,nil,-2,REASON_RULE)
		end
		local eg2=Duel.GetMatchingGroup(aux.TRUE,1-tp,LOCATION_EXTRA,0,nil)
		if eg2:GetCount()>5 and eg2:GetCount()<=15 then
			rg2=eg2:Select(1-tp,eg2:GetCount()-5,eg2:GetCount(),nil)
			Duel.SendtoDeck(rg2,nil,-2,REASON_RULE)
		elseif eg2:GetCount()>15 then
			rg2=eg2:Select(1-tp,10,15,nil)
			Duel.SendtoDeck(rg2,nil,-2,REASON_RULE)
		end
		--draw
		Duel.Draw(tp,hct,REASON_EFFECT)
		Duel.Draw(1-tp,hct,REASON_EFFECT)
		local seq=-4
		while seq~=28 do
			seq=seq+4
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_DISABLE_FIELD)
			e1:SetLabel(seq)
			e1:SetOperation(c511004001.disop)
			e1:SetReset(0)
			Duel.RegisterEffect(e1,tp)
		end
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,1)
		e2:SetCode(EFFECT_SKIP_M2)
		Duel.RegisterEffect(e2,tp)
	end
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
	
end
function c511004001.disop(e,tp)
	return bit.lshift(0x1,e:GetLabel())
end
