Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190167E9929
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjKMJid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjKMJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:38:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A07910D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:38:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7B14C433C7;
        Mon, 13 Nov 2023 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699868308;
        bh=U4t+9g3AWgJvV8hcFy83sDq5KYyDYw3cn+Q6uLyPbxQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TjBb3sQQpA1Nl319mYdQppRCerLPZYE5OjBamuXQAleoBKU+bkYRaHlB8jPik3NNF
         jvNLND3erOLA2AcIdhXw/RsTPGgbqak7h4WjCpOK2mwwvMQDzOxVU1gZoU6mTxldil
         r7lqzQxHTBFENoCQ8hcFKGDus+9F54iF6wzyF0NR38OOahGmVRQhjI7Z83gS1TBXoR
         i2w6VTcefuocN/YWX1ybLFoOD/xPvCeEEqUHpPN7SF4wQL10et4pjG8j1pZH3mFhEE
         wDR910SspmJDSaXP+xYwlTPxwpghsunQyrBhLUCegJQQgZyBMCTK5WLw/qbz3YOdA4
         E7kmN0VhClJZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E3A3E00088;
        Mon, 13 Nov 2023 09:38:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/7] There are some bugfix for the HNS3 ethernet driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169986830857.24663.16656088717775298434.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 09:38:28 +0000
References: <20231110093713.1895949-1-shaojijie@huawei.com>
In-Reply-To: <20231110093713.1895949-1-shaojijie@huawei.com>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 17:37:06 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v1 -> v2:
>   - net: hns3: fix add VLAN fail issue, net: hns3: fix VF reset fail issue
>     are modified suggested by Paolo
>   v1: https://lore.kernel.org/all/20231028025917.314305-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/7] net: hns3: fix add VLAN fail issue
    https://git.kernel.org/netdev/net/c/472a2ff63efb
  - [V2,net,2/7] net: hns3: add barrier in vf mailbox reply process
    https://git.kernel.org/netdev/net/c/ac92c0a9a060
  - [V2,net,3/7] net: hns3: fix incorrect capability bit display for copper port
    https://git.kernel.org/netdev/net/c/75b247b57d8b
  - [V2,net,4/7] net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
    https://git.kernel.org/netdev/net/c/53aba458f238
  - [V2,net,5/7] net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()
    https://git.kernel.org/netdev/net/c/dbd2f3b20c6a
  - [V2,net,6/7] net: hns3: fix VF reset fail issue
    https://git.kernel.org/netdev/net/c/65e98bb56fa3
  - [V2,net,7/7] net: hns3: fix VF wrong speed and duplex issue
    https://git.kernel.org/netdev/net/c/dff655e82faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


