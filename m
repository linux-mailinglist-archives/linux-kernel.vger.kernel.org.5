Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2287F4483
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjKVLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjKVLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A17192
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E45BCC433C9;
        Wed, 22 Nov 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700650823;
        bh=ZlVrbo7UOGX/XECpfOoC/hZSnQldeVUXm8zcILIQOX8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P8771H0L+uW8zB2+LqpDnin5KRjLm0a1rixyuC33wmi4WrGlnWUZ7qBf2m/tIchgB
         kz4EMBkT9bzjOFihUJLl90nLXX4VphtWvzPXFGdL4sDTSrnBZ/5RE1edo3aGo1jlsX
         br6j3zNPzD9bMzSHuzWciHlyC8px+OpV6EOMhWl9cJlWnfqYMzupDWkA5lKd6K6kNN
         JdVG4ehv5u3mFVQtx0JvcCZjy3D4bBskyIfsP7rNm4BLjs0CvvPT1qOsEGgj0cqNy1
         YxMhmOMLXjubGkGUa1KtzFBrRa0u5MPFKEyXdpPoTvmyDQwenMq/57i36/da4j2ByI
         WBDyqTqLKdgwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBFA7C3959E;
        Wed, 22 Nov 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] nfc: virtual_ncidev: Add variable to check if ndev is
 running
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170065082383.4259.6871325798764809034.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Nov 2023 11:00:23 +0000
References: <20231121075357.344-1-phind.uet@gmail.com>
In-Reply-To: <20231121075357.344-1-phind.uet@gmail.com>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>
Cc:     bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
        syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 15:53:57 +0800 you wrote:
> syzbot reported an memory leak that happens when an skb is add to
> send_buff after virtual nci closed.
> This patch adds a variable to track if the ndev is running before
> handling new skb in send function.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
> 
> [...]

Here is the summary with links:
  - [v2] nfc: virtual_ncidev: Add variable to check if ndev is running
    https://git.kernel.org/netdev/net/c/84d2db91f14a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


