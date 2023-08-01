Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284176A637
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjHABVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHABVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:21:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF01712;
        Mon, 31 Jul 2023 18:21:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7EE917FD3;
        Tue,  1 Aug 2023 09:21:37 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 09:21:37 +0800
Received: from [192.168.125.107] (183.27.98.54) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 1 Aug
 2023 09:21:36 +0800
Message-ID: <c03886ed-f39e-09c4-6435-7a0e63341da7@starfivetech.com>
Date:   Tue, 1 Aug 2023 09:21:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: correct file entry in STARFIVE JH7110 DPHY
 RX DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731114856.14401-1-lukas.bulwahn@gmail.com>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230731114856.14401-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/31 19:48, Lukas Bulwahn wrote:
> Commit f8aa660841bc ("phy: starfive: Add mipi dphy rx support") adds the
> MAINTAINERS section STARFIVE JH7110 DPHY RX DRIVER referring to
> 'phy-starfive-dphy-rx.c', but the file actually added in this commit is
> named 'phy-jh7110-dphy-rx.c'.
> 
> Correct the file entry in STARFIVE JH7110 DPHY RX DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thank you for your correcting.

Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Thanks,
Changhuang

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 733bcfa0209a..003b0461641a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20345,7 +20345,7 @@ M:	Jack Zhu <jack.zhu@starfivetech.com>
>  M:	Changhuang Liang <changhuang.liang@starfivetech.com>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> -F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
> +F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
>  
>  STARFIVE JH7110 MMC/SD/SDIO DRIVER
>  M:	William Qiu <william.qiu@starfivetech.com>
