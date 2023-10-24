Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F67D4A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjJXIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJXIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:40:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4599
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:40:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5210EC433C9;
        Tue, 24 Oct 2023 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698136822;
        bh=Swt1HdkYhDuCBYOR75sgO0ONU+7S/yD5FMYrGp04s4s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KMuYTelhahEUY4rgvgIRJA7rfbJzdmzMhMjMEuVbx8Tc07xk8V8RXmcAdEA12HN+4
         zSnCjVUcJyHX92/c8/tQZ+rJdzVSSPezf7WeQ3ZYDg9MGpOUHgIQOxOYM1Se9pHx4c
         k5ZRhcelMZCaTAU3cRDgDBf5cWi1ijcFOA8F+gwyXr9jDE9kTmp3KaamNk+RBNs/DK
         nnURaYmkHEGEsbGZMpdWIM5AB3V/iX5RczSK2V5cp5FFpwq7jlP2f6mOgVetRK99px
         aZ/Uh1ADy4Vbt0vaHBbLogGB8NVv4fwko96jEDo9m31j5DQjGvWgrP7/qOE4v6ltMW
         5A2GSFwe0Tlqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35326C00446;
        Tue, 24 Oct 2023 08:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: icssg-prueth: Add phys_port_name support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169813682221.10549.8413389074006826689.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 08:40:22 +0000
References: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
In-Reply-To: <895ae9c1-b6dd-4a97-be14-6f2b73c7b2b5@siemens.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
        baocheng.su@siemens.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Oct 2023 10:56:22 +0200 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Helps identifying the ports in udev rules e.g.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> [...]

Here is the summary with links:
  - net: ti: icssg-prueth: Add phys_port_name support
    https://git.kernel.org/netdev/net-next/c/f6e12277011d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


