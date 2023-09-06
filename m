Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DE7934DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIFFa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjIFFa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:30:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B59EA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:30:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD8F3C433C7;
        Wed,  6 Sep 2023 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693978223;
        bh=7uyWBllcX8juLpVZ9yQI4JLq+dGY8Kiny/DYNrnQlcM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jU9ybsYJ+aLrmxuB0DLq3hqWMBqj+xaLr2nafg6AADdcx4sLTXqTR3LGmPZj0yRV1
         zKdd7wK1XsE5mMn2uOFBr3wE9iKex080ZPSqI5lbLQmSHjf7/YGO/Tr2/qpBSSzHgR
         sfyjsAdPhTajsYiKi71Iq5gdUfaEo72D9t2n9qKqCnCyWZNZjLoa1q4KsczHgYw9qP
         J4OP3XY4d9qJE22DOKipnyyGzHaItVv1l8M3bMuO4UH9yoi5pPEEHtEJjtLTyT7cBo
         JVGt6DyYBnBaYu9wGuxrb2SpDUqSB/wp/KZjKhduJwNykcoqp0jEsS1u+eOulS+gYE
         LBm7T17mmg5KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93096E22B01;
        Wed,  6 Sep 2023 05:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] tc-cbs offload fixes for SJA1105 DSA
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169397822359.31592.6905327253561237778.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 05:30:23 +0000
References: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, xiaoliang.yang_1@nxp.com,
        andrew@lunn.ch, f.fainelli@gmail.com, yanan.yang@nxp.com,
        vinicius.gomes@intel.com, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Sep 2023 00:53:35 +0300 you wrote:
> Yanan Yang has pointed out to me that certain tc-cbs offloaded
> configurations do not appear to do any shaping on the LS1021A-TSN board
> (SJA1105T).
> 
> This is due to an apparent documentation error that also made its way
> into the driver, which patch 1/3 now fixes.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
    https://git.kernel.org/netdev/net/c/954ad9bf13c4
  - [net,2/3] net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
    https://git.kernel.org/netdev/net/c/894cafc5c62c
  - [net,3/3] net: dsa: sja1105: complete tc-cbs offload support on SJA1110
    https://git.kernel.org/netdev/net/c/180a7419fe4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


