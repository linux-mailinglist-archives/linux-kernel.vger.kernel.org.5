Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D536E7977D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjIGQgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239206AbjIGQgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047547A96
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:22:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1E5CC433B6;
        Thu,  7 Sep 2023 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694078424;
        bh=eg664JVvulepbuVjHAcVo26wcKMFi3AZs+ECL6A2lJg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MdYgErh4Wt+yJh5kMNG7AQFPaLDSGy07WNqg1sC7QaBHIPXnqw7gWzJiEVVaOPBqI
         tDs9G8mkXdWFa/zFUpzk04JmoNwW8f1bEu1EV6NnvgjVdA98bhr5zPChUmLynCGR39
         9TIunO8NZokRxmlEGPBdU9B+oBNX7DE2s5Q7iSn5fNDnAExGSY+jVyX7O8Yy5LW+lV
         7jS+fxb34c2LP+kOrstAqFSBDmvmfIg6HSOyarQ1/jPgGU0EJ/2jVe5o/p6w0p8XSy
         JF02rEoYNcaAYL6wSExYS8KejoKneLtij+JNvsmknW/sQYpONyCV4CFpllPHGhgnyP
         dHkOtIPwltsNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6344C4166F;
        Thu,  7 Sep 2023 09:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/7] There are some bugfix for the HNS3 ethernet driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169407842467.2177.2525780122496274621.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Sep 2023 09:20:24 +0000
References: <20230906072018.3020671-1-shaojijie@huawei.com>
In-Reply-To: <20230906072018.3020671-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, chenhao418@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 6 Sep 2023 15:20:11 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Hao Chen (2):
>   net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
>   net: hns3: fix debugfs concurrency issue between kfree buffer and read
> 
> Jian Shen (1):
>   net: hns3: fix tx timeout issue
> 
> [...]

Here is the summary with links:
  - [net,1/7] net: hns3: fix tx timeout issue
    https://git.kernel.org/netdev/net/c/61a1deacc3d4
  - [net,2/7] net: hns3: Support query tx timeout threshold by debugfs
    https://git.kernel.org/netdev/net/c/dd2bbc2ef69a
  - [net,3/7] net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
    https://git.kernel.org/netdev/net/c/efccf655e99b
  - [net,4/7] net: hns3: fix debugfs concurrency issue between kfree buffer and read
    https://git.kernel.org/netdev/net/c/c295160b1d95
  - [net,5/7] net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue
    https://git.kernel.org/netdev/net/c/fa5564945f7d
  - [net,6/7] net: hns3: fix the port information display when sfp is absent
    https://git.kernel.org/netdev/net/c/674d9591a32d
  - [net,7/7] net: hns3: remove GSO partial feature bit
    https://git.kernel.org/netdev/net/c/60326634f6c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


