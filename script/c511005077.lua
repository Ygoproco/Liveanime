--Power Change Barrier
--パサー・チェンジ・バリア
--  By Shad3
--cleaned up and fixed by MLD
function c511005077.initial_effect(c)
	aux.AddPersistentProcedure(c,0,aux.FilterBoolFunction(Card.IsPosition,POS_FACEUP_ATTACK))
	--Negate, Decrease ATK
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetCondition(c511005077.discon)
	e2:SetTarget(c511005077.distg)
	e2:SetOperation(c511005077.disop)
	c:RegisterEffect(e2)
	--selfdes
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511005077.destg)
	e3:SetOperation(c511005077.desop)
	c:RegisterEffect(e3)
end
function c511005077.discon(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and g:IsContains(tc) and Duel.IsChainDisablable(ev)
end
function c511005077.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetFirstCardTarget()
	if chk==0 then return tc end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c511005077.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateEffect(ev) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-600)
		tc:RegisterEffect(e1)
	end
end
function c511005077.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511005077.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
