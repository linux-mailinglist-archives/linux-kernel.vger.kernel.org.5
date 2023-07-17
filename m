Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F807757078
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGQXYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGQXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:24:02 -0400
X-Greylist: delayed 663 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 16:23:27 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DFC410C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:23:27 -0700 (PDT)
Received: from [192.168.178.27] (p57bc9ef6.dip0.t-ipconnect.de [87.188.158.246])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 879B8280150;
        Mon, 17 Jul 2023 23:11:02 +0000 (UTC)
Message-ID: <c4ee5ba4-5338-45f0-3d88-97a0e81bca74@zonque.org>
Date:   Tue, 18 Jul 2023 01:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ARM: pxa: Drop unused includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225534.3213044-1-robh@kernel.org>
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20230717225534.3213044-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.23 00:55, Rob Herring wrote:
> Several includes are not needed, so drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Daniel Mack <daniel@zonque.org>

> ---
>   arch/arm/mach-pxa/pxa-dt.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
> index 5e5d543fdf46..a292de91dce5 100644
> --- a/arch/arm/mach-pxa/pxa-dt.c
> +++ b/arch/arm/mach-pxa/pxa-dt.c
> @@ -5,13 +5,7 @@
>    *  Copyright (C) 2012 Daniel Mack
>    */
>   
> -#include <linux/irq.h>
> -#include <linux/irqdomain.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_platform.h>
>   #include <asm/mach/arch.h>
> -#include <asm/mach/time.h>
> -#include "irqs.h"
>   
>   #include "generic.h"
>   

