Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE57B7D0772
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJTEvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjJTEvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:51:39 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9FD5B;
        Thu, 19 Oct 2023 21:51:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39K4pOMc012511;
        Thu, 19 Oct 2023 23:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697777484;
        bh=T4d4FQKRT37iCD3D4hdv+cgb70K74rfgzoKjp7ZVVX0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BPaBT+q+xV54SuNN46CLP7IrbSb7r+zT8FuFpSJ2QS6x/u6y9lgGV64KB7csOcQ1p
         hXOlQmM/ztiRg6/OifX6l3PfKATG7ErthZdsDddblIuVOp2kH5CT8ZfMadccNTPqk3
         A6D5+pM0yosi68RJ0DP3TRBMZFGOYk5oIyPpjeRE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39K4pOcC011350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 23:51:24 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 23:51:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 23:51:24 -0500
Received: from [172.24.227.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39K4pKHR064185;
        Thu, 19 Oct 2023 23:51:21 -0500
Message-ID: <2c22999d-be7b-fad4-d13c-4e978d971749@ti.com>
Date:   Fri, 20 Oct 2023 10:21:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Add alias for MCU
 CPSW2G
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20231019102043.3044295-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231019102043.3044295-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 3:50 PM, Siddharth Vadapalli wrote:
> Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
> for the port directly from U-Boot.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20231019. I hope that the
> patch can be reviewed so that I can post it again when the merge window
> opens implementing any feedback received and collecting the tags if any.
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 1e1a82f9d2b8..d0cfdeac21fb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -31,6 +31,7 @@ aliases {
>  		can1 = &mcu_mcan1;
>  		can2 = &main_mcan6;
>  		can3 = &main_mcan7;
> +		ethernet0 = &cpsw_port1;
>  	};
>  
>  	vusb_main: regulator-vusb-main5v0 {

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
