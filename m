Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD67DEF33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbjKBJud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbjKBJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0549A111
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE75C433C9;
        Thu,  2 Nov 2023 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698918628;
        bh=Jg4InaDJnH/oeoyaPxpJdEYyiTiu4StA4+931M+X2yc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jLQ1IDyAL59sFCSMvwjxPL5S1zVZ1hQ17kJxZYsRNVlaQnrD4vX3+SpV6s0QkvS6T
         kyZl56FuS9cIrp0itdLppgwqJ0a42Zr6SnP+vu7Eo5ui/k03+ztthAeYEnKH97MK++
         EBtpHRrK5dwoJA/HqLEG3FObyV9b3Ds57vR8wcEiMtexm5GSQ6SJ1pz7hTBjkBCOK6
         kPyLFyIo7Dh8rdKXiJ+HdvjV6lJBFccGDl+hI3cSjoL4iitAZpUg939PfANzMwoVEs
         E+xMwPbBihqvPfyTgPKq4RIJwm80RPrEB7aaHObl5hWv3Jaiy4yniBRgFKVZeWk1KG
         H9oQBkNI1Nm4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8721DC4316B;
        Thu,  2 Nov 2023 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/2] octeontx2-pf: Fix error codes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169891862854.20867.12440563910508147071.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 09:50:28 +0000
References: <20231027021953.1819959-1-rkannoth@marvell.com>
In-Reply-To: <20231027021953.1819959-1-rkannoth@marvell.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wojciech.drewek@intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Oct 2023 07:49:52 +0530 you wrote:
> Some of error codes were wrong. Fix the same.
> 
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] octeontx2-pf: Fix error codes
    https://git.kernel.org/netdev/net/c/96b9a68d1a6e
  - [net,v1,2/2] octeontx2-pf: Fix holes in error code
    https://git.kernel.org/netdev/net/c/7aeeb2cb7a25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


