Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B007EEA58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbjKQAa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjKQAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:30:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB03182;
        Thu, 16 Nov 2023 16:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 517BCC43391;
        Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700181023;
        bh=HlypnzxeE3S9lFFNCAPZqir+lGEfON+V4ihvlsSuaB4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CUZcgwo/BdCJXTHjVctNu3MZOGJd1/HCRmPM9ZqC+UnMm9FXsQf4wzrwntzL/SYPR
         4lSyyRw60HMadKhEnTOt/svDNZHQAghfwcEgi1RmiRss/0H1pzPcH6IFpxOK940G/f
         tyvn9WPVNn78WtvIcNqmn2HiFJSzlJ0zn6WqKExG8XbyA4+0OFbsrTbnGqQc/+WtYd
         ZffCjMi9ECydsuxcnaQRJn7kz7ywYye6iEkD+r2+oqLVUGTNbr2pKy91yc5W9rkIRE
         PZq/nL4aNjxnaTwLGtUN8Wy6mDhbrx5+CkIhoj4hhX2uQyvmDQiLLkc1FFVeyPeD7a
         xYq2PtCqwepOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 307A3E00092;
        Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170018102319.11691.12519242645299739953.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 00:30:23 +0000
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, sergei.shtylyov@gmail.com,
        magnus.damm@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 21:04:48 +0000 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
> 
> [...]

Here is the summary with links:
  - dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
    https://git.kernel.org/netdev/net-next/c/7c93d177d913

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


