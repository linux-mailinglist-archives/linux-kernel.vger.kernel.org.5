Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1A806DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377615AbjLFLaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377514AbjLFLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE1DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:30:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7120C433C9;
        Wed,  6 Dec 2023 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701862227;
        bh=M5PE+I3iOxOqz4yQhh1YIppM8QP5eSuBOerGveyfL/s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DG8iY05vyCNPB5a6repzCZdcJ0tbHS1v3pa5++zHBsMaGsiVmnGf4ELbonH0h2lhg
         z+hP8wK5vonQ31NYALuu7jK18X+LAehB2HPNklZLgk5eZivaxKcjUDeT15vp3R+HYP
         pdV1bqwvF8PZ5ECh6A5Hh27KEZo1Z3mw0aZeU1bh42G2KGwTvgvaHTvp3u67L22PU8
         eajdmvlpR0DsCXrN1CsQ1gbSGfTupjdr51NRy7ku+k05W7MTeIdTNIpPp3vIfucKmA
         Ll11LTdA3phIUpgVJNXBy5yTG7+RfZxKKcO6LvZSChJdjmoONmq9kXBi5uY2gErH8x
         KdHauom2yry4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADFD1C395DC;
        Wed,  6 Dec 2023 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3 net 0/2] There are some bugfix for the HNS ethernet driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170186222770.5890.6220803421445351509.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 11:30:27 +0000
References: <20231204143232.3221542-1-shaojijie@huawei.com>
In-Reply-To: <20231204143232.3221542-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wojciech.drewek@intel.com,
        shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 4 Dec 2023 22:32:30 +0800 you wrote:
> There are some bugfix for the HNS ethernet driver
> 
> ---
> changeLog:
> v2 -> v3:
>   - Refine the commit msg as Wojciech suggestions
>   - Reconstruct the "hns_mac_link_anti_shake" function suggested by Wojciech
>   v2: https://lore.kernel.org/all/20231204011051.4055031-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Fixed the internal function is not decorated with static issue, suggested by Jakub
>   v1: https://lore.kernel.org/all/20231201102703.4134592-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V3,net,1/2] net: hns: fix wrong head when modify the tx feature when sending packets
    https://git.kernel.org/netdev/net/c/84757d083945
  - [V3,net,2/2] net: hns: fix fake link up on xge port
    https://git.kernel.org/netdev/net/c/f708aba40f9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


