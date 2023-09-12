Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64CB79DC38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbjILWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjILWu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:50:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210310EB;
        Tue, 12 Sep 2023 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=otC68GLRk8Y3xp0cO9IhUS5amOCNre8RwT/bxHW6Ex0=; b=MbKg9e1SGJkADwvQIpPZqj6qix
        sLzUKpIkVmK5HCTWpRHDSW7GBqqeVKGlLnGYwzeDxV187IgLYF+Al9TJc+MHRrlFcpLeW5EfKutyl
        cXE1IORrO4P0ickmwENsOlXPOpxdtmtmLhYTRcYvO2FVlJFvDVTeL7gT6+lodqo6/unM0cbTjfMtS
        T8UBvjSYLPWmOPgSmgiVb9UqfphiOYB4nRxCJCIxRj2HFkV+SAscnf/xwVQqRp1wsDac8WXPW4HcT
        rhtw/0RFh5vDZQzYp+Jsm1Rs4U/nE6uMBzdvc/+ojOktXZzEq6etJlYupNpW9e4OyR4xgMkMWorBZ
        lD2yVXcg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgCD7-004ENZ-2F;
        Tue, 12 Sep 2023 22:50:21 +0000
Message-ID: <418813e6-9efe-4f55-8d53-dc46d7a22f6d@infradead.org>
Date:   Tue, 12 Sep 2023 15:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 12
 [drivers/pinctrl/nuvoton/pinctrl-npcm8xx.ko]
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tomer.maimon@nuvoton.com, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
References: <20230912152645.0868a96a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230912152645.0868a96a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 22:26, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230911:
> 
> New tree: bcachefs
> 
> The bcachefs tree gained a semantic conflict against Linus' tree for
> which I applied a patch.
> 
> The wireless-next tree gaind a conflict against the wireless tree.
> 
> Non-merge commits (relative to Linus' tree): 4095
>  1552 files changed, 346893 insertions(+), 22945 deletions(-)
> 
> ----------------------------------------------------------------------------

on x86_64:

when
# CONFIG_OF is not set

ERROR: modpost: "pinconf_generic_dt_node_to_map" [drivers/pinctrl/nuvoton/pinctrl-npcm8xx.ko] undefined!


Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
