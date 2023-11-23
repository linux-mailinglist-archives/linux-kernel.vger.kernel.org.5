Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66887F64AA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjKWRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbjKWRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A093
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ACBAC433CB;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758826;
        bh=sq9a7agLBKvujsPVZbWmPWMEPPyZt0vkGZvkg2sAwDM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nu4zFTA6IbjtFqP8JW506Dqo6xPbJS2RLYSMpm2y48v/tKhtlSIMgk7YnL/FvN6Ph
         G1W9fQqbS9n0iOOJ97pJYjPQG8p3B+A1pzp1iYblUtgj1a38t6GJJsegcH65rJXblP
         NtrehgItcQFV5u4D5HtONWtPOs9yqogK1JvP0r19PXMXtMBy/S0O8JQ1G25Gdz4yaG
         iltnq0IS/ftOAsvuLmHH7MzWwaI/O4BBIAFmRWBWA7LL+wnewg9CVMu58gKCtcViix
         gDSe8NHkmF+wP7+pjOXI2OcJf/7Ac7i2Zxc4CjM37qYd1kbN9Ev6G9mhXcesfTNP7p
         m0J3ZqqKrJ3Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7448EC3959E;
        Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: axienet: Fix check for partial TX checksum
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170075882647.541.11957078215794048376.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:26 +0000
References: <20231122004219.3504219-1-samuel.holland@sifive.com>
In-Reply-To: <20231122004219.3504219-1-samuel.holland@sifive.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     radhey.shyam.pandey@amd.com, ariane.keller@tik.ee.ethz.ch,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, michal.simek@amd.com, pabeni@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Nov 2023 16:42:17 -0800 you wrote:
> Due to a typo, the code checked the RX checksum feature in the TX path.
> 
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: axienet: Fix check for partial TX checksum
    https://git.kernel.org/netdev/net/c/fd0413bbf8b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


