Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967C7DD485
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjJaRT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJaRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:19:58 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA6C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:19:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xsP9qZpDKcvbdxsP9q9sMe; Tue, 31 Oct 2023 18:19:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698772792;
        bh=gOvLKUUag0d3vBxqjVPBuMzzM9LuqmjbX/h+8+EFUfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pgX94945nD2/0iNdOw7mQkY3FpWMK/3YYSobQnpNFmc3Bubdl2Oqd0QACT3869MAe
         pgDtWfIX1g1uU9siqCgNHcSYQYDQYxpMyQFs5+ZOVKVsbQIVBAT8nTUaex0mn52me6
         X0iG8xDoyr0roMlgg1knX4/0hiyCRkeTTVGsISzbmCS1zq3mAUx2oNvjG0CFg6D8LN
         AW1+XpMAqeES5Oj+pPkwC+bNzKYgHi11GoMyhq7cU4N45vBJaMg2yjOuWUZktclh5P
         4m7Bt5uQ902n12PolBecRUN/AIUVansMUAmabxFEyK0EFVyay8AL2LPIQ8r6G76Ir4
         rxXhRBVtD3Z6g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 31 Oct 2023 18:19:52 +0100
X-ME-IP: 86.243.2.178
Message-ID: <d5dace72-093d-4bed-b02b-ed05401b34aa@wanadoo.fr>
Date:   Tue, 31 Oct 2023 18:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: comedi: drivers: ssv_dnp: fixed a brace coding
 style issue
Content-Language: fr
To:     dimadrumspro@yahoo.com, dimadrumspro@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20231031162554.4189-1-dimadrumspro@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231031162554.4189-1-dimadrumspro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/10/2023 à 17:25, dimadrumspro@yahoo.com a écrit :
> From: dimaaac <dimadrumspro@gmail.com>
> 
> Fixed a coding style issue, as well as a typo (lowercased word)
> and removed unnecessary filename comment.
> 
> Signed-off-by: dimaaac <dimadrumspro@gmail.com>
> ---
>   drivers/comedi/drivers/ssv_dnp.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ssv_dnp.c b/drivers/comedi/drivers/ssv_dnp.c
> index 813bd0853b0b..d0747767810b 100644
> --- a/drivers/comedi/drivers/ssv_dnp.c
> +++ b/drivers/comedi/drivers/ssv_dnp.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * ssv_dnp.c
> - * generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
> + * Generic comedi driver for SSV Embedded Systems' DIL/Net-PCs
>    * Copyright (C) 2001 Robert Schwebel <robert@schwebel.de>
>    *
>    * COMEDI - Linux Control and Measurement Device Interface
> @@ -91,13 +90,13 @@ static int dnp_dio_insn_config(struct comedi_device *dev,
>   	if (ret)
>   		return ret;
>   
> -	if (chan < 8) {			/* Port A */
> +	if (chan < 8)			/* Port A */
>   		mask = 1 << chan;
>   		outb(PAMR, CSCIR);
> -	} else if (chan < 16) {		/* Port B */
> +	else if (chan < 16)		/* Port B */
>   		mask = 1 << (chan - 8);
>   		outb(PBMR, CSCIR);
> -	} else {			/* Port C */
> +	else				/* Port C */

Hi,

did you compile your change?

I don't think that it compiles. The {} looks needed here.

CJ

>   		/*
>   		 * We have to pay attention with port C.
>   		 * This is the meaning of PCMR:
> @@ -109,7 +108,6 @@ static int dnp_dio_insn_config(struct comedi_device *dev,
>   		 */
>   		mask = 1 << ((chan - 16) * 2);
>   		outb(PCMR, CSCIR);
> -	}
>   
>   	val = inb(CSCDR);
>   	if (data[0] == COMEDI_OUTPUT)

