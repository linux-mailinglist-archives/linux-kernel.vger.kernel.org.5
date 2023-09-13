Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E779DE7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjIMDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIMDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:13:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217341719;
        Tue, 12 Sep 2023 20:13:50 -0700 (PDT)
X-UUID: 8d7060e051e311eea33bb35ae8d461a2-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Ga6WzbU2EX3/1LsEHLxlUVVQi46V7tvm1QytTalPIlQ=;
        b=pzmDGzxmGqon8/XSLtoPYISaX1PHMtT/CEzmrBmAitoLR8nQ9AafWO5AYM64/cyDJHqIwMQheahPuFHfwT3tz7tTxlfQ/aIN2DQ4W2qC7ByMa3ZaAZb1GKdFqZzFIpALpdkt32e5NMrLIjK9LFh0CLC5C72TroWLkIphlzMYmkA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:f6ade93b-c85f-455e-aa4a-52a0803ea7a2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:989adf13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8d7060e051e311eea33bb35ae8d461a2-20230913
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 632929023; Wed, 13 Sep 2023 11:13:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 11:13:46 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 13 Sep 2023 11:13:45 +0800
Message-ID: <e858038c-b859-f837-f664-da309bc23c11@mediatek.com>
Date:   Wed, 13 Sep 2023 11:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm64: dts: mediatek: mt8365-evk:
 update compatible
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
References: <20230912092444.31635-1-macpaul.lin@mediatek.com>
 <f417f936-2f07-b8fd-2b7f-37f4cb287d63@linaro.org>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <f417f936-2f07-b8fd-2b7f-37f4cb287d63@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.412100-8.000000
X-TMASE-MatchedRID: 7ySqCuYCpfgOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
        qIY+/skQkABPgKBt/0ryHcpfdGNxl6NkxxcwzhmbwCZxkTHxccnL4OjAKYBEGiAWAsBm7Nh12d8
        mtRIRsUPTVXWIYq/e1h9l1zPMOb+6TX7PJ/OU3vKDGx/OQ1GV8khax4LkeV5t+gtHj7OwNO2Ohz
        Oa6g8KrXkM+I1SWhzt1MfQczQdgQ9FMvocH273MVeqLhNW4nzrM+tpFigz04o=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.412100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E62D5F078BEE7189156B8796CEB9D95F56472FA2B4E5C78C7338C4EF77741D982000:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 22:34, Krzysztof Kozlowski wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On 12/09/2023 11:24, Macpaul Lin wrote:
>> Update compatible of 'mediatek,mt8365-evk' from 'enum' to 'const'.
> 
> This we see from the diff. But why? Sorry, this change is pointless.
> Also not really helpful, as the entry soon should be converted back to
> enum...
>> 

Okay, then this patch can be dropped now.
Will send v5 patch for renaming mt8365-evk.dts.

> Best regards,
> Krzysztof
> 

Thanks
Macpaul Lin
