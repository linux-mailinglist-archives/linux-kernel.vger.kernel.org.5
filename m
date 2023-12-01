Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF77080049F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377714AbjLAHUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjLAHUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:20:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB04131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FEDC433C8;
        Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701415227;
        bh=vTjtMuTcR9tfuBLdztPV147PSAy8Z/tak0LnQysHFgI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OUWwyHgIEIghw9Jtcz2q8j/1bOM6y+rwwvviuAvrRpK/ambeL8n1hLyfjHGg+D9pf
         +VT33cGbI6mke+zrXHKW7AxK+qVNQD+9Z9ziMoD9JcRXy1Ihjy0T/ADIVaFULxgHiP
         fE180DHDC+85OTFFQoSfQEbYJZAsHIW/0MKPxQ/ChP441dzGiZ6OBOxG1WLmSHQsR1
         l5YMcteVKN7iyZ3V1FmTBfZacMmm28YBRX2jV2gyqGDh3+oHDArEBmszfPpb5D3wFs
         OaOer0CJ36D5rC3LTeOLQG+ONIt1Sn+iIeD9Fa4r6RiPG7YHPH25lmgy+MRdnq7wOf
         FaiR96IZ8OXHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2E10C64459;
        Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net/sched: cbs: Use units.h instead of the
 copy of a definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170141522679.3845.12131849353944729756.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 07:20:26 +0000
References: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128174813.394462-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vinicius.gomes@intel.com, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
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

On Tue, 28 Nov 2023 19:48:13 +0200 you wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  net/sched/sch_cbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net/sched: cbs: Use units.h instead of the copy of a definition
    https://git.kernel.org/netdev/net-next/c/000db9e9ad42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


