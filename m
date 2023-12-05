Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C0980451C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376306AbjLECkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344050AbjLECkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:40:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB192B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:40:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CB3FC433C8;
        Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701744025;
        bh=Eq4A/LWka7uXN0IlYb+DI3bGBTJZiMJO4BXJOr8/xsk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H57n9yXcXz8gpZ1odXXFD56+T/z4NJwU4FdN961xWaAh83rJkobUXvE3bplJQUlNq
         xKsCWjvsYXjRbmL4FetF6R9mMk+jElZAO4aMC+Kx4ZolmJ5wD7FyLKBtZl61mYhesU
         OABZrrDQ3Wzi56xGxivlzsaRYq6xzJ+Sud6cox5QqX1g+5NkLm4jrchfXkCeZ4acKM
         yCu337UhKokUxi9pYHXlQBonbvcR2HTkgqkk+SEqerhVddc0gn0jLyTIG0LkHuGz6n
         mY0ODrgAY/oUvzORFQHovav1urRvX9PvEAruOD5SP0HXtyIb8oHwekbCYh0rkFDo4s
         jG4oaqkMYaJ0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AD28DD4EEF;
        Tue,  5 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-pf: consider both Rx and Tx packet stats for
 adaptive interrupt coalescing
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170174402523.31470.12401024322897178687.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Dec 2023 02:40:25 +0000
References: <20231201053330.3903694-1-sumang@marvell.com>
In-Reply-To: <20231201053330.3903694-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org, naveenm@marvell.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 11:03:30 +0530 you wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch also updates tx packet
> stats which will be useful when there is only tx traffic.
> Also moved configuring hardware adaptive interrupt setting to
> driver dim callback.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-pf: consider both Rx and Tx packet stats for adaptive interrupt coalescing
    https://git.kernel.org/netdev/net/c/adbf100fc470

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


