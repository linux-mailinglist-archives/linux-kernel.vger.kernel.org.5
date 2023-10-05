Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81657BA2F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjJEPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjJEPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:12 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1E826D1;
        Thu,  5 Oct 2023 07:16:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395DHZAG123978;
        Thu, 5 Oct 2023 08:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696511855;
        bh=KD+7zlq75ALxwrYJZRVC4LR58yxzi4RfU5hU9XkaJsI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YT/XxjEKBvqXxNOGvNy1FBjSCwE4u4FJLpUpZ1Y66WgI0xK91X88ZHTYMnPpPCYnu
         4zee9ETdzOFd7mm7iLXQ1gTAQaa4/rlAQK8wqCHk3uPI6CFIn/PpjTygcEqh9sf8Xs
         33wZwUD2CAWyd7hiXDsGUTykr1BOXIyKRrC9mzek=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395DHZUK008994
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 08:17:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 08:17:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 08:17:35 -0500
Received: from [10.249.136.52] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395DHTaj118229;
        Thu, 5 Oct 2023 08:17:30 -0500
Message-ID: <3037051e-9665-4174-b545-5a91d146fb54@ti.com>
Date:   Thu, 5 Oct 2023 18:47:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/5] Enable Display for J784S4 and AM69-SK platform
To:     <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>
CC:     <afd@ti.com>, <rogerq@kernel.org>, <s-vadapalli@ti.com>,
        <conor+dt@kernel.org>, <r-ravikumar@ti.com>, <sabiya.d@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231005100027.228806-1-j-choudhary@ti.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20231005100027.228806-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/23 15:30, Jayesh Choudhary wrote:
> This series adds support for:
> - DisplayPort for J784S4-EVM
> - Displayport and HDMI for AM69-SK platform
> 


[...]

Oops! I faced some issue with my mailing server while sending these
patches. So had to send 4/5 patches again as '--in-reply-to' but
the hierarchy is off on mailing list. Will RESEND the series.

Please IGNORE this series.

Sorry for the noise!!!

Warm Regards,
Jayesh

> 
> Changelog v10->v11:
> - Added comment for disabling serdes-refclk (according to comments of v5)
> - Update commit message to document why serdes, wiz nodes (2/5) and mhdp-
>    bridge, tidss nodes (3/5) are disabled.
> - Keep only ports in board files and move common properties to main file
>    and document why ports are kept empty.
> 
> v10: https://lore.kernel.org/all/20230927121157.278592-1-j-choudhary@ti.com/
> 


[...]

> 
> Dasnavis Sabiya (1):
>    arm64: dts: ti: k3-am69-sk: Add DP and HDMI support
> 
> Rahul T R (2):
>    arm64: dts: ti: k3-j784s4-main: Add DSS and DP-bridge node
>    arm64: dts: ti: k3-j784s4-evm: Enable DisplayPort-0
> 
> Siddharth Vadapalli (2):
>    arm64: dts: ti: k3-j784s4-main: Add system controller and SERDES lane
>      mux
>    arm64: dts: ti: k3-j784s4-main: Add WIZ and SERDES PHY nodes
> 
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts      | 229 +++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 119 +++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 276 +++++++++++++++++++++
>   3 files changed, 624 insertions(+)
> 
