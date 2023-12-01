Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F4D800AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378807AbjLAMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378778AbjLAMUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A410F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AE11C43391;
        Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701433224;
        bh=GxOpMes2kicKpLodY8rnfocgHs/5AC98YnYsa3etZ/A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bHcxvloa6YL4WLEjc8AlxQ/I0B8CB6Hyf1SYzLUz+KIPtwVjdkz5wM+erkMZq3FqC
         URV75MFCRZ4bEUGEcXRFApWvc0JXXOBJrXxz5QuXejGRGQhBkI6lXkhjEu709lfscT
         OAIELFCBsCap7Haddcb2+53IZIvFlWBw1YBjZ6BPltRteWLBjFhutsmrK9PtdYksO4
         +SsXdPRtHDnQLbRNSWuA5P3DKtK5j43R+d//WHSdVcCpEl5GxmkgL8WzVBJF+/FqOJ
         6pTSouY4WC/sEIWTMRowHJbjBDq1AUgJTUa0a+pV5S2cjf6UADkfCuFhnVCkxa3+kv
         jiVg7vpjRKuhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15A0FE11F66;
        Fri,  1 Dec 2023 12:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] octeon_ep: set backpressure watermark for RX
 queues
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170143322408.17347.17756295348406257934.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 12:20:24 +0000
References: <20231129053131.2539669-1-srasheed@marvell.com>
In-Reply-To: <20231129053131.2539669-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, vburru@marvell.com, sedara@marvell.com,
        edumazet@google.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 28 Nov 2023 21:31:31 -0800 you wrote:
> Set backpressure watermark for hardware RX queues. Backpressure
> gets triggered when the available buffers of a hardware RX queue
> falls below the set watermark. This backpressure will propagate
> to packet processing pipeline in the OCTEON card, so that the host
> receives fewer packets and prevents packet dropping at host.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] octeon_ep: set backpressure watermark for RX queues
    https://git.kernel.org/netdev/net-next/c/15bc81212f59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


