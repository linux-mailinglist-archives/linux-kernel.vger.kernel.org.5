Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C6782402
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjHUGuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjHUGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62632C7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE42C60F61
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F203CC433C9;
        Mon, 21 Aug 2023 06:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692600623;
        bh=Xarka6BOjfzdYYYwsYm0Lkc3K6ha42oDm55WVIZOBgs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bAT80IHdO69U1UXgi+d6vs/EeFc0LD5lj83z3kAxZbxZ1QsjKnlF9D9Kjkd0bnu8+
         d+j8e6eCHenwhgoaOkZXVyubiLgddWc1k59ERVCzv25bYuwFKjgH05CIP487JyOo6Z
         hK/tty9mDophqXe4fSqo449wTqVUA45uOjdZLWpbPV8rkH9ZIrU8tKFvJI6x+FVFn2
         VwOVhK+GuJKe9YdwMDuvcDY+eu+VpdfQroHk9YN0xEmeriFcVQGwcxw9Uzu81p+Zyu
         rabJWccIOxtVBgik0X7De8HNBPPCCdnN0Q+u4JXKgsLuhXKmzTl8sXoR6ONtF+/DeY
         ksv5eVKuRmkLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D78F5E4EAF9;
        Mon, 21 Aug 2023 06:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 06:50:22 +0000
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, shannon.nelson@amd.com, brett.creeley@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 09:55:37 +0800 you wrote:
> Fix some kernel-doc comments to silence the warnings:
> 
> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'
> 
> [...]

Here is the summary with links:
  - [net-next] pds_core: Fix some kernel-doc comments
    https://git.kernel.org/netdev/net-next/c/cb39c35783f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


