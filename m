Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9227CFF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjJSQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjJSQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3B112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC5BC433C8;
        Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731822;
        bh=cBykJKHjrNAgWJmxcWiJVzH9YSi11Z2q3/uU3/UjPow=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EzctAb/TkV4IHS5t4wBsWrt4eEnL//5F+R3/e4URIS6ajH9qIDAbNSTQ2niR53SCA
         7ovlN06BWaG1bwo+uMIvvO1S42qGIFR6obEit1Lh+2PQZ/zF8rF+OOCq4ydp+w0CNz
         lOwdkcJgMVS1gFeNUe20BVZyLBK6qLCbVTyWJvibVBrQbj8j/OHPqMsBdKxV3BrWHO
         r64ktG+jeaW+X+o9+ukJr2UGXuKzzsyD/MIui+DJxgdVGeHLKxcpy0CmA0Ou8BgUiG
         yEKZpcJ9KSkCWfrYztLENpp0DR4HD1CWMnQaOBSb5lZF5bzxiKV8kA4KJDtzEwgWLy
         1/9tYJKmGHAqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 238FDC04DD9;
        Thu, 19 Oct 2023 16:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773182214.32102.11595509429600832386.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 16:10:22 +0000
References: <20231018150715.3085380-1-danishanwar@ti.com>
In-Reply-To: <20231018150715.3085380-1-danishanwar@ti.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     andrew@lunn.ch, grygorii.strashko@ti.com, vigneshr@ti.com,
        jacob.e.keller@intel.com, rogerq@kernel.org, pabeni@redhat.com,
        kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com
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

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 20:37:15 +0530 you wrote:
> The bitmasks for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD r30 commands are
> wrong in the driver.
> 
> Update the bitmasks of these commands to the correct ones as used by the
> ICSSG firmware. These bitmasks are backwards compatible and work with
> any ICSSG firmware version.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
    https://git.kernel.org/netdev/net/c/389db4fd673e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


