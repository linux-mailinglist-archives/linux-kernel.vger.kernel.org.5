Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388D3806EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377815AbjLFLu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377810AbjLFLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:50:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D71BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE774C433CA;
        Wed,  6 Dec 2023 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701863426;
        bh=xuzvP/4uuQrdDIFX25RKWq1eWWQ/XCeCYfneTOXQkZI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WkBke8Ey/5QaxiYSFWMJFgS1PRe2J6cPmeQtO5PpUAOFEnTSEtI92casKetQ0Dn5m
         /y6Qx/5VbLEWubpwBxL/NZjfQjAzzXdGJDJbHh+RdWVCOf9KtTh5bXl1DXpV7hV9zX
         W2Ox4TZMd3CtxeuodO/C6OjkWLmgzsGsWw+KwI8iVRZ87NEUl2ZZja3gRao52Eml4h
         72F5caMOHgD2uF5i4fDFAETeZqfqd2Q1l6+/zyvDtLhUBs5RkaO+tFYv6KxzNQXeT7
         UZGt+LxkbUV+zjEl8V4K00NRMZX613tiz0fXoCkqaa2ZsdNjqj33Saw3FbBRrGn9iQ
         rNMBFRYK6zsmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C92A4DD4F1F;
        Wed,  6 Dec 2023 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/5] Documentation/tcp: Fix an obvious typo
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170186342582.17663.13343107504768715339.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 11:50:25 +0000
References: <20231204190044.450107-2-dima@arista.com>
In-Reply-To: <20231204190044.450107-2-dima@arista.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
        kuba@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, fruggeri05@gmail.com, noureddine@arista.com,
        horms@kernel.org, netdev@vger.kernel.org, Markus.Elfring@web.de,
        corbet@lwn.net, linux-doc@vger.kernel.org
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

On Mon,  4 Dec 2023 19:00:40 +0000 you wrote:
> Yep, my VIM spellchecker is not good enough for typos like this one.
> 
> Fixes: 7fe0e38bb669 ("Documentation/tcp: Add TCP-AO documentation")
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Closes: https://lore.kernel.org/all/2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de/
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> [...]

Here is the summary with links:
  - [v5,1/5] Documentation/tcp: Fix an obvious typo
    https://git.kernel.org/netdev/net/c/714589c27422
  - [v5,2/5] net/tcp: Consistently align TCP-AO option in the header
    https://git.kernel.org/netdev/net/c/da7dfaa6d6f7
  - [v5,3/5] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
    https://git.kernel.org/netdev/net/c/965c00e4ea2e
  - [v5,4/5] net/tcp: Don't add key with non-matching VRF on connected sockets
    https://git.kernel.org/netdev/net/c/12083d728213
  - [v5,5/5] net/tcp: Don't store TCP-AO maclen on reqsk
    https://git.kernel.org/netdev/net/c/9396c4ee93f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


