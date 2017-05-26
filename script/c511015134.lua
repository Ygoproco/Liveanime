--Rank-Up-Magic Admiration of the Thousands (Anime)
function c511015134.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511015134.target)
	e1:SetOperation(c511015134.activate)
	c:RegisterEffect(e1)
end
function c511015134.filter(c)
	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073)) and c:IsType(TYPE_XYZ) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c511015134.xyzfilter(c,e,mg)
	local g=mg:Clone()
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_XYZ_LEVEL)
		e1:SetValue(tc:GetRank()+1)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end

	return (c:IsSetCard(0x1048) or c:IsSetCard(0x1073)) and c:IsXyzSummonable(g)
end

function c511015134.mfilter1(c,e,mg,exg)
	return Duel.IsExistingMatchingCard(c511015134.mfilter3,e:GetHandlerPlayer(),LOCATION_EXTRA,0,1,nil,c,mg)
end
function c511015134.mfilter2(c,e,mg,exg)
	local g = mg:Clone()
	g:AddCard(c)
	return exg:IsExists(Card.IsXyzSummonable,1,nil,g,g:GetCount(),g:GetCount())
end
function c511015134.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local mg=Duel.GetMatchingGroup(c511015134.filter,tp,LOCATION_GRAVE+LOCATION_ONFIELD,LOCATION_GRAVE+LOCATION_ONFIELD,nil)
	local exg=Duel.GetMatchingGroup(c511015134.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,mg)
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,1)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and exg:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local ex1=Duel.SelectMatchingCard(tp,c511015134.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,mg):GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local sg1=Duel.SelectXyzMaterial(tp, ex1, c511015134.filter, ex1:GetRank(), 1, 99, mg)

	Duel.SetTargetCard(sg1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,ex1,1,0,0)
end
function c511015134.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)	
	local b,ex = Duel.GetOperationInfo(0, CATEGORY_SPECIAL_SUMMON)
	local ex1=ex:GetFirst()
	if ex1:IsLocation(LOCATION_EXTRA) and ex1:IsXyzSummonable(g, g:GetCount(), g:GetCount()) then
		Duel.Overlay(ex1,g)
		Duel.SpecialSummon(ex1,0,tp,tp,false,false,POS_FACEUP)
		ex1:CompleteProcedure()
		
		ex1:RegisterFlagEffect(511015134, RESET_EVENT+0x1fe0000,0,0)
	end
end
