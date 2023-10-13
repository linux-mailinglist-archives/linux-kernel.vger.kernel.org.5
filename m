Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5B7C8306
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJMKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B64AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:30:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8325DC433CB;
        Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697193025;
        bh=wwKBCj+1hmngLDq3xWTr2aIZpq1KXGxcuekl/LhvyVU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jfY4FYnGp7HUmoQardzEnuaa3zbxSx4Pm096Y8X5SGk7AWDN3TQL3B+erJCEK3BhJ
         Jl1UdXr6+2YEHOcIQxUEMCk7ymSywL6eg+y3KLtEXFm1ATpGGY0aOMEZLfUPlSYJ63
         2y20g0uB8R0No03PVv9oTPBKCKZgZoS3pYw8aViY95D1nWu1+jWTtzFq6ch+P19gEm
         PXvVwFzlBx1Q2nWnNxtO44P+/v/m9rMdmh42Sz4ogq/EI9Em/D/GObPi15ww3aAASb
         kQj4tAExTfzp6ESOMv6JOYS4q9KkHfnhe5f09R7XHK+8Uk5+bsN63prQqTCS2E9Wd5
         I9OwsHfaJpNYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65D76E1F66B;
        Fri, 13 Oct 2023 10:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169719302541.12798.2477725074861291176.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 10:30:25 +0000
References: <20231010172415.552748-1-j.zink@pengutronix.de>
In-Reply-To: <20231010172415.552748-1-j.zink@pengutronix.de>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        richardcochran@gmail.com, patchwork-jzi@pengutronix.de,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 19:24:15 +0200 you wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: stmmac: fix typo in comment
    https://git.kernel.org/netdev/net-next/c/895359b8c1e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


