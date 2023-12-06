Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FC80666A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 06:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbjLFFAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjLFFAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:00:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3C122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:00:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B809BC433C9;
        Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701838828;
        bh=zcDRQmSycTcrwMXlNRfpFfg66gWCywN9nB6ketOM6p8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RsZGf+2tOQ+jcEk8I4Sm8sNGr5iVfolagXNADQVfyINElnRDMmf2lGxwkC/kAHlB3
         eVp9qpbK0QUaCFpUbZce6LM83CC7jrBPanbrxIHN18VrO4MBvSPyzsid0eVApT/Rh+
         G+2eSHKXwFnhEpt6jAAaIJnlLAepwDDygiJEeBef8zy9DvHSatCLSQ1yDhMgOEzBqE
         wHw1/g33ec/vaCqHAR++8w79S1DQO1HYX7QsFSKug/lmGiHs6U+x9wEFZPEuG870RQ
         w83wPs0C0Suqrlbt+N8zxaE716/Jq1tPHttn3iYL5YvgGYce6y8DdoOTGwl5pCdCYt
         2UrmkGP8PIklA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D64BC395DC;
        Wed,  6 Dec 2023 05:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeon_ep: control net API framework to support
 offloads
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170183882864.31476.7857996414730874839.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 05:00:28 +0000
References: <20231204154940.2583140-1-srasheed@marvell.com>
In-Reply-To: <20231204154940.2583140-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, wizhao@redhat.com,
        konguyen@redhat.com, vburru@marvell.com, sedara@marvell.com,
        edumazet@google.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 07:49:39 -0800 you wrote:
> Inquire firmware on supported offloads, as well as convey offloads
> enabled dynamically to firmware. New control net API functionality is
> required for the above. Implement control net API framework for
> offloads.
> 
> Additionally, fetch/insert offload metadata from hardware RX/TX
> buffer respectively during receive/transmit.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeon_ep: control net API framework to support offloads
    https://git.kernel.org/netdev/net-next/c/5aa00e9e41f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


