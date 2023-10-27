Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737527D9F29
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346094AbjJ0R5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjJ0R5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:57:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB81AD;
        Fri, 27 Oct 2023 10:57:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698429462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCqnF8tdiSzXrkWRZWP57lvyo1MUb2GIYlUOd343qS4=;
        b=PGWexmfRM/2TEUOSrK+HsNczBVzbibItnW+ilemIFDRGz24XswlG0KPJuaCs45xmx0GnbZ
        X8B0R6oDn/6AKLzb39H0WosRRdX7EOQTopYJ4bLIM0R0aXO6XrVLzznhyWaC62jCdUg/Nv
        5OOTnd4QIE1WbFtRJzj8dxWYzMBnFdTW6dc/m6FR9SWS20et65VwWBYuG35VYfJ2+k8GKT
        oj1IKFIKPZr1jmFOgBaqi+ufajYBIgQ4ZSANH6NE8EP8Y5XvsnZxLMxj7bsRar6iFzB70n
        jmOBpVrTA4AWZns6DiO3XjnI3a3O7DNFZIsWQKJMXpMgjTHwNn0k21xNgHx98A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698429462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCqnF8tdiSzXrkWRZWP57lvyo1MUb2GIYlUOd343qS4=;
        b=Jekz+x5Nqppl3XpdyShxtU4jCvvzPHhfCnjZSp4RxZdxTBZaVoPYoC2jmZJQDt+D3Q8Y0W
        HSzt//btUKckQ5Dw==
To:     Claudiu <claudiu.beznea@tuxon.dev>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 6/7] irqchip/renesas-rzg2l: use tabs instead of spaces
In-Reply-To: <20231023102223.1309614-7-claudiu.beznea.uj@bp.renesas.com>
References: <20231023102223.1309614-1-claudiu.beznea.uj@bp.renesas.com>
 <20231023102223.1309614-7-claudiu.beznea.uj@bp.renesas.com>
Date:   Fri, 27 Oct 2023 19:57:41 +0200
Message-ID: <87edhg2bje.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23 2023 at 13:22, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
> and TINT_EXTRACT_GPIOINT() macros.

Wrong ordering. Cleanups first, features last.

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> index e5e158bf028d..ce50745bba87 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -56,8 +56,8 @@
>  #define IITSR_IITSEL_EDGE_BOTH		3
>  #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
>  
> -#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
> -#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
> +#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
> +#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
>  
>  /**
>   * struct rzg2l_irqc_reg_cache - register cache
