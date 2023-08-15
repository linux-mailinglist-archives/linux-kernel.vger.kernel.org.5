Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFDF77CEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbjHOPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjHOPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:11:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A029173C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3Cjg/cBdoQIzYX4bGVBGLhLgvCo7gGuKtDH+1xcjGRU=; b=Daulotj9eY7Hghzy6Wz83NdbmG
        JoA8SPJ0eiL+EOegc5fXAowgCCpsqzx7y9nlrMrpTL9L/POa6qV/FE5ptCrjX/fKEa0HXPJkqZUsz
        mMc6TzHfgwxUtVgNi8Ig7dRztkSvRvIFkpLH8AVl+ju3ztKp1oE0+6qp/p40bMFl163fH2NBEuor0
        K82CorMWzYhmnJkZtVYlyk0mZ1LovAzsQTQ/bbtk5KOJ+PuhVL0Nzn0ZkeJHe1oeYxiQi6EU5voAh
        WyCLV2HmLd1vgwTQAwtJZRJ88AHkOevONc5N4zaWirtWRYeb1BqBjBkWXXu3OQ7ODvqFEgggFGfLC
        IZMh1ZhQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVvht-001pHp-0h;
        Tue, 15 Aug 2023 15:11:41 +0000
Message-ID: <0b3363b7-03aa-b8fa-1ed9-05db35f1779b@infradead.org>
Date:   Tue, 15 Aug 2023 08:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1] MAINTAINERS: Add entries for TEXAS INSTRUMENTS ASoC
 DRIVERS
Content-Language: en-US
To:     Kevin-Lu <kevin-lu@ti.com>, broonie@kernel.org, peeyush@ti.com,
        navada@ti.com, baojun.xu@ti.com, shenghao-ding@ti.com
Cc:     linux-kernel@vger.kernel.org
References: <20230815095631.1655-1-kevin-lu@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230815095631.1655-1-kevin-lu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 02:56, Kevin-Lu wrote:
> Add the MAINTAINERS entries for TEXAS INSTRUMENTS ASoC DRIVERS.
> ---
> Changes in v1:
> Add maintian team members to support TEXAS INSTRUMENTS AUDIO DRIVER
> 
> Signed-off-by: Kevin-Lu <kevin-lu@ti.com>
> ---
>  MAINTAINERS | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0903d87b17cb..65d57925fe22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21051,6 +21051,39 @@ T:	git https://github.com/jcmvbkbc/linux-xtensa.git
>  F:	arch/xtensa/
>  F:	drivers/irqchip/irq-xtensa-*
>  
> +TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
...

The new entry should follow the one below to keep them in
alphabetical order.

> +
>  TEXAS INSTRUMENTS ASoC DRIVERS
>  M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)

-- 
~Randy
