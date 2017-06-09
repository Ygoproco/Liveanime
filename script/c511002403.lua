--時の魔術師
function c511002403.initial_effect(c)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DICE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c511002403.target)
	e2:SetOperation(c511002403.activate)
	c:RegisterEffect(e2)
end
function c511002403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>0 end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002403.activate(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	local p=1
	for i=1,6 do t[i]=i end
	local a1=Duel.AnnounceNumber(tp,table.unpack(t))
	for i=1,6 do 
		if a1~=i then t[p]=i p=p+1 end
	end
	t[p]=nil
	local a2=Duel.AnnounceNumber(tp,table.unpack(t))
	local dc=Duel.TossDice(tp,1)
	if dc==a1 or dc==a2 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-1500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
		Duel.RaiseEvent(e:GetHandler(),71625222,e,0,0,tp,0)
		Duel.RaiseEvent(e:GetHandler(),71625222,e,0,0,1-tp,0)
	else
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		g:AddCard(e:GetHandler())
		Duel.Destroy(g,REASON_EFFECT)
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum/2,REASON_EFFECT)
	end
end
