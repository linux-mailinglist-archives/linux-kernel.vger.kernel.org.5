Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26D7D1D95
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjJUOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJUOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A731135
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEBABC433CA;
        Sat, 21 Oct 2023 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697899823;
        bh=63bWoIAADl1KfBX8RMDtq+J3PdFVRKm7FKjSpaJLOTc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jJhBkWhyU7I/UOtnCCoYXYYM0pYDJe1n3a56+5tBY4gtbb+OrzsPk/T87286EZ9O8
         2gVCDlTIYM/189yH59Fq0HR5wP1aOu1Hkrhk2+pum3gUqZnNKVkBYAj5g3ZxA4w+r9
         L9dWaWFTp71+8vRjeAOWpfH/5ymVO5Bqd9DOC2zAlKWL3ccgKtpTB5dF/cFYpQMDZv
         bKOixYAUXvREa2cwdmvdYAUP7uQl3D45GjLyD6602NjTUc8bxXF1eh8DCItWrRbhwo
         norgy13H+/7Ruld3t4zwKatZ9kD2/J1co5D2fastGDPwkcrYDXio2KFoUSkatMJ/ni
         J8EHoPmLdJGaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD9A4C04DD9;
        Sat, 21 Oct 2023 14:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] octeon_ep: assert hardware structure sizes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169789982370.32227.5493366972449498212.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 14:50:23 +0000
References: <20231020114302.2334660-1-srasheed@marvell.com>
In-Reply-To: <20231020114302.2334660-1-srasheed@marvell.com>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hgani@marvell.com, vimleshk@marvell.com, egallen@redhat.com,
        mschmidt@redhat.com, pabeni@redhat.com, horms@kernel.org,
        kuba@kernel.org, davem@davemloft.net, vburru@marvell.com,
        sedara@marvell.com, edumazet@google.com
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

On Fri, 20 Oct 2023 04:43:01 -0700 you wrote:
> Clean up structure defines related to hardware data to be
> asserted to fixed sizes, as padding is not allowed
> by hardware.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>   - Changed packed attributes to static assertions for fixed sizes
> V3: https://lore.kernel.org/all/20231016092051.2306831-1-srasheed@marvell.com/
>   - Updated changelog to indicate this is a cleanup
> V2: https://lore.kernel.org/all/20231010194026.2284786-1-srasheed@marvell.com/
>   - Updated changelog to provide more information
> V1: https://lore.kernel.org/all/20231006120225.2259533-1-srasheed@marvell.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v4] octeon_ep: assert hardware structure sizes
    https://git.kernel.org/netdev/net-next/c/e10f4019b18d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


