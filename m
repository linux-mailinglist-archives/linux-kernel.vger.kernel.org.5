Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6617AAD83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjIVJOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVJOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:14:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD499;
        Fri, 22 Sep 2023 02:14:06 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M3QAYg003949;
        Fri, 22 Sep 2023 11:13:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=8tru55dK21kkrZooBZ20jTZ5oFa3mpckA4DEAk2YLTw=; b=YN
        Gcz8rEqiXT7ThAGppxSZ321Y8tLtvjLbVPPIdY8Ot9eDR0jpalZJB9EitfJLgom0
        O9ooHfOf6TJAZR+9m9SyV7QUTHo6lVZuXWiBQ5B28g8UxJjw8/lEKdlLUDRvIywD
        w6t9eSgQvrqj7XUKzm+xmijK9tGzNubL9e3H7BRzFGzwng2BQ5kTjDr3NhtdensG
        H2/dp1M2L6nvx9ZZX/3zF/0d4YeS30/qY/sX3EN6gquvXVARMHnMEEqZhTWzJr/9
        qHvmxEfQjRfcM181GTixXibqmP+zHID0XREB12k5OkCWFhnz3QwNs1AhQUNYdwGK
        M+ds3Ur5LEghOXZKiU5w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt7akx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:13:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5289100051;
        Fri, 22 Sep 2023 11:13:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C8837215BEA;
        Fri, 22 Sep 2023 11:13:54 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 11:13:54 +0200
Message-ID: <cb996f8a-16ad-96ec-11ed-993f494ef6b9@foss.st.com>
Date:   Fri, 22 Sep 2023 11:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: dts: stm32: stm32f7-pinctrl: don't use multiple
 blank lines
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-amarula@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= 
        <raphael.gallais-pou@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230904180341.923038-1-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230904180341.923038-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_07,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 9/4/23 20:03, Dario Binacchi wrote:
> The patch fixes the following warning:
> 
> arch/arm/dts/stm32f7-pinctrl.dtsi:380: check: Please don't use multiple blank lines
> 
> Fixes: ba287d1a0137 ("ARM: dts: stm32: add pin map for LTDC on stm32f7")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
> index 65480a9f5cc4..842f2b17c4a8 100644
> --- a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
> @@ -376,7 +376,6 @@ pins2 {
>   				};
>   			};
>   
> -
>   			ltdc_pins_a: ltdc-0 {
>   				pins {
>   					pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */


Applied on stm32-next.

Thanks.
Alex
