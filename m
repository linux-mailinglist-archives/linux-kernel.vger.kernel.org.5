Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208F79DE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjIMDKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjIMDKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:10:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20159170E;
        Tue, 12 Sep 2023 20:10:45 -0700 (PDT)
X-UUID: 1e3a765251e311eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=mnH3VYybHNPCFza4U3Lo++PBqNXZHBqFibompUbKTp0=;
        b=EKzO/poZ/IRnJ5lFweVNuaxZ5VfkVkMW/YjjMkBvLoFlVnOhJ5ikAUcdBB+PjyWzJYHaicKOWB2gZGoXtlo6VfP3jcIGztVD7CzpHnw6uFTVg0QUt7VlwXKxc21ZcZJnj/4Wv6RGLGU80gcac0v29BoeOQzD8F+zPvyWfU29su0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:7f11b923-34fc-48ba-9060-6ae852dbf2bb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:fa63c5be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1e3a765251e311eea33bb35ae8d461a2-20230913
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2019945274; Wed, 13 Sep 2023 11:10:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 11:10:36 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 13 Sep 2023 11:10:36 +0800
Message-ID: <3798208e-3c88-eb85-b69a-8e7599e01f7f@mediatek.com>
Date:   Wed, 13 Sep 2023 11:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230911115717.26184-1-macpaul.lin@mediatek.com>
 <8404a761-8d13-e2c7-1655-e465377867c4@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <8404a761-8d13-e2c7-1655-e465377867c4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.870000-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0qbqzDH9G7eTOrVjATjwK5bO6NhettUZJv4bPjfm0hIQRWGsjXB+VCMVES
        8z7FeWoPp8a7XvR4Uq/Lv5gdZDUvRpfOBymEN+bx0BEBFOTiHnxNzcbBs7azL3M5CjuZOAD7PnM
        Ai6bw5xAhP7+OpDg1qPnHe0LR0k+SnqXaX6120o2cJkKl3v/LDfS0Ip2eEHny+qryzYw2E8LLn+
        0Vm71Lcq7rFUcuGp/EgBwKKRHe+rxQYtHYPyslFZGR/E4dAWWRUWR3er7KFk7XkcXbfQhRRD7W1
        NapBQEk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.870000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 168DD0E809F654E907C82DA2B890FD5815DDE6338F3A4104D49F10009C1247152000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 22:36, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 11/09/2023 13:57, Macpaul Lin wrote:
>> 1. Add compatible for MT8395.
>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>> as the "Genio 1200-EVK".
>> 
>> The MT8195 and MT8395 belong to the same SoC family,
>> with only minor differences in their physical characteristics.
>> They utilize unique efuse values for differentiation.
>> 
>> The booting process and configurations are managed by boot
>> loaders, firmware, and TF-A. Consequently, the part numbers
>> and procurement channels vary.
>> 
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> Changes for v2:
>>  - add more detail description for mt8395.
>>  - add bindings for mt8395, and mt8395-evk.
>> 
>> Changes for v3:
>>  - add back bindings for mt8195 compatible.
>> 
>> Changes for v4:
>> Changes for v5:
>> Changes for v6:
>>  - No change, update Reviewed-by tag only. Thanks.
>> 
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> index ae12b1cab9fb..2e8ad49c3479 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>> @@ -248,6 +248,12 @@ properties:
>>            - enum:
>>                - mediatek,mt8365-evk
>>            - const: mediatek,mt8365
>> +      - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
> 
> Drop description. This is an entry for multiple boards, not only for
> this one.
> 
> Best regards,
> Krzysztof
> 

Ok, will drop this line and send v7 series.

Thanks
Macpaul Lin
