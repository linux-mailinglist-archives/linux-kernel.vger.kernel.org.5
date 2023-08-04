Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EDE7704EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHDPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjHDPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:37:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AAF1735;
        Fri,  4 Aug 2023 08:37:46 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 374DxTYt016361;
        Fri, 4 Aug 2023 17:37:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=2MnJLd/cw+qk9zY3eSbS/WUEJw7QWsi5u4vo7z3Bjqk=; b=zC
        WsRTeAzXfTb9ZxdDjdGg2ZIBEvkHBeTXB4GbqUxHnZZ8IPh+V5izWoW7/WxO/WUH
        vPlNMzbEP7SWUxzVsmSC6WPdoYIt2WUh9DZ/8fJ7z+Fwxv84eGd5NFkVw3T6CnAa
        JdQnsKCAEP/DuTmxQySA/2K0NS1FvJxfJc4qYufkvzowMQbWBYFgncF4UWEc4g+X
        mE71KMfGu+dZX9DMw9892Jml8D9g3wIi57m9ghLocsHvRnqRLzF9OxduCFkQIMlt
        bgtjeDKxOhKI0fwuQuy8LoJi7Ff/M6MShvn5MC1SMdFd0GH/aNoHvP2BJaQtlAzR
        HhdKTf+2ffN2xd9DwNyg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s8xy89v4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 17:37:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 128AC10004F;
        Fri,  4 Aug 2023 17:37:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B47B2248AC;
        Fri,  4 Aug 2023 17:37:34 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 4 Aug
 2023 17:37:33 +0200
Message-ID: <a02b8501-d47f-77df-444a-a867a9438443@foss.st.com>
Date:   Fri, 4 Aug 2023 17:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] AMR: dts: st: stih407: drop max-duty-cycle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org>
 <20230726070353.103989-4-krzysztof.kozlowski@linaro.org>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230726070353.103989-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_15,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 09:03, Krzysztof Kozlowski wrote:
> "max-duty-cycle" property was removed in the commit f747a1fe7848
> ("regulator: pwm-regulator: Remove obsoleted property"):
> 
>   stih418-b2199.dtb: pwm-regulator: Unevaluated properties are not allowed ('max-duty-cycle' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/st/stih407-family.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
> index 3f58383a7b59..29302e74aa1d 100644
> --- a/arch/arm/boot/dts/st/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/st/stih407-family.dtsi
> @@ -111,7 +111,6 @@ pwm_regulator: pwm-regulator {
>  		regulator-min-microvolt = <784000>;
>  		regulator-max-microvolt = <1299000>;
>  		regulator-always-on;
> -		max-duty-cycle = <255>;
>  		status = "okay";
>  	};
>  
Acked-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
