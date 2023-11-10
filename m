Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F97E81B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345962AbjKJScs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjKJSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:31:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E671CA274;
        Fri, 10 Nov 2023 00:51:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C6BC433C8;
        Fri, 10 Nov 2023 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699606278;
        bh=peSr/sRwOFewRWkDxG8KYeXEM6sSyB3N4H7+yu0gHMQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cmu4/nEtatRoyUILGZ8gNUO601cPJerdj7Tl0yEUWagoBHCXPcYy17ujIZWYx7ByN
         g953j469ObxWML+1XgwJKLdD1Onh40anFXJDRvyppOqh+6SISpC54MNf4hvJUG5cdV
         21MuPe2Xx+hezEGJk1SvnYLEo1usRrQ0H7sRyfJguBCSVcCTRiQgaNDLTeBEMi+FRJ
         uXXFsd3FAjey1KaJaZaLUi4DaqjlH/rLhSLYSMUoxh9kYSFH4peLdI/lQY0l8SAren
         2uDzYEuS9Rdipzj6bQMlwoj1yXqqoY6TXGLxFyIKUMYig/hiBWAVtHUXG9+w7GGdw8
         ge4KH4Kcgl1tw==
Message-ID: <78cf6806-0bdc-4b81-8d96-51a6f8fb168c@kernel.org>
Date:   Fri, 10 Nov 2023 10:51:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, netdev@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com, nm@ti.com, srk@ti.com,
        Md Danish Anwar <danishanwar@ti.com>
References: <20231110084227.2616-1-r-gunasekaran@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231110084227.2616-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 10/11/2023 10:42, Ravi Gunasekaran wrote:
> Grygorii is no longer associated with TI and messages addressed to
> him bounce.
> 
> Add Siddharth and myself as reviewers.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b151710e8c5..bd52c33bca02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21775,7 +21775,8 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
>  F:	drivers/counter/ti-eqep.c
>  
>  TI ETHERNET SWITCH DRIVER (CPSW)
> -R:	Grygorii Strashko <grygorii.strashko@ti.com>
> +R:	Siddharth Vadapalli <s-vadapalli@ti.com>
> +R:	Ravi Gunasekaran <r-gunasekaran@ti.com>

Could you please add me as Reviewer as well. Thanks!

>  L:	linux-omap@vger.kernel.org
>  L:	netdev@vger.kernel.org
>  S:	Maintained

> F:      drivers/net/ethernet/ti/cpsw*
> F:      drivers/net/ethernet/ti/davinci*

What about am65-cpsw*?

And drivers/net/ethernet/ti/icssg/*

I also see 

OMAP GPIO DRIVER
M:      Grygorii Strashko <grygorii.strashko@ti.com>

Maybe a separate patch to remove the invalid email-id?

-- 
cheers,
-roger
