Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807C8796F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 06:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIGEH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 00:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbjIGEHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 00:07:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE8199A;
        Wed,  6 Sep 2023 21:07:39 -0700 (PDT)
X-UUID: 12bd62de4d3411eea33bb35ae8d461a2-20230907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=C/+fmgeuErAUmUURu6+eSlmaEzlVyX07VG9PJZuuB9c=;
        b=CpwojtPiB3tOws/E2ouIFZZ+cakca/p/N3urbGAxdTPyH+EA+7zyr6oz2jv0lN9CMTJLQBUdybvM4tkN6QsT3qOHo1Zej/x3uOJtdi+aV3DrkKW9iXq9oMX2PMtjE4BqB99muPBxNrHRShc7he+G4hmc/vlqnHovoW81SsLGdPs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:052d709b-b95d-4f4b-90f2-18b35ce4b5ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:18e33620-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 12bd62de4d3411eea33bb35ae8d461a2-20230907
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 987898152; Thu, 07 Sep 2023 12:07:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Sep 2023 12:07:33 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 7 Sep 2023 12:07:32 +0800
Message-ID: <8db8823d-8313-5515-78ca-effc8d6bc47f@mediatek.com>
Date:   Thu, 7 Sep 2023 12:07:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
 <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
 <f343b6e2-6106-47eb-71cb-f391aff6cb7f@collabora.com>
 <50f7fbdd-8592-7a47-b2d8-a1af8ed93b92@linaro.org>
 <c951f693-b219-4745-be20-a8e1fee0099d@mediatek.com>
 <E3DEDA34-C203-4560-B07D-8BCB44204FF3@public-files.de>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <E3DEDA34-C203-4560-B07D-8BCB44204FF3@public-files.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/23 20:19, Frank Wunderlich wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> Can you please only target Reviewers/Maintainers and mailinglists reported by get_maintainers script?
> 
> I have only sent patches for mediatek and did some tests. So i'm not interested in patches for hardware i do not have here :). I guess i'm not alone...
> regards Frank

I'm sorry for bothering you and other contributors.
I've indeed run get_maintainers.sh script for these 2 patches.
Here's the result.

Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
DEVICE TREE BINDINGS)
Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN 
FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:3/4=75%)
Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND 
FLATTENED DEVICE TREE BINDINGS)
Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC 
support,commit_signer:3/4=75%,in file)
...
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
(reviewer:ARM/Mediatek SoC 
support,commit_signer:2/4=50%,authored:1/4=25%,added_lines:1/12=8%)
Frank Wunderlich <frank-w@public-files.de> 
(commit_signer:1/4=25%,authored:1/4=25%,added_lines:1/12=8%)
...
[striped...]

You've contributed the similar percentage as Angelo for these files.
So I think both of you could be important reviewers.
I'll try to skip contributors who add lines less then 10% next time and see
if this will help.

Thanks!
Macpaul Lin
