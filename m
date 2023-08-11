Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C699177895C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjHKJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHKJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C710F6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DAC5649F1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AF07C433CB;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691744424;
        bh=MTPtbImRSDiDQ9iz3Dhc9omtbXud8FvkvxRZfpFR/7s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Zw7mJV9TflqvWK8DekbF1mqhD98Oi0Tf9niwMnI+7nYjRh34rUzr6L+yWgnQIvUsG
         C/KmMCZksY9CzmrGWJw1cBWZxkOqiZ21e1jm6XBZd7jbtWxxhTS8AruEO76BBW4v6n
         svmaMDFq1+0qNoCmpXhfIPX4vi5oO8zTwfqw1lEHWyZvID3jFjUTVHA5dz+98e/rJH
         RV+6HwJVKixLkGA4NocZt3YP0YwfWXfDoAsrPWaP9yv6dyAEP82FAbIMA3KHqX8DjA
         vD2dXXL4NAmM1v3cXgWxXdV77LoSTt+r/3atiHTbVrWyGs1myR1wJMHT+TKm85/Q+R
         7/fRVLdH7FJyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64713E1CF31;
        Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] octeon_ep: Add control plane host and firmware
 versions.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169174442440.10902.15244631640819475211.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Aug 2023 09:00:24 +0000
References: <20230809112933.716736-1-sedara@marvell.com>
In-Reply-To: <20230809112933.716736-1-sedara@marvell.com>
To:     Sathesh Edara <sedara@marvell.com>
Cc:     linux-kernel@vger.kernel.org, sburla@marvell.com,
        vburru@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        hgani@marvell.com, andrew@lunn.ch
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

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 9 Aug 2023 04:29:33 -0700 you wrote:
> Implement control plane mailbox versions for host and firmware.
> Versions are published in info area of control mailbox bar4
> memory structure.Firmware will publish minimum and maximum
> supported versions.Control plane mailbox apis will check for
> firmware version before sending any control commands to firmware.
> Notifications from firmware will similarly be checked for host
> version compatibility.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] octeon_ep: Add control plane host and firmware versions.
    https://git.kernel.org/netdev/net-next/c/a20b4c5f3a0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


