Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4297E8DC8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjKLA4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjKLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2764C30F7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 16:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EC71C433B8;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=ECwHfXafrdIwVU+4vTjRoTfaOIHL/jM2cbtKPhWIDRw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XMQ/QzTsm/2p5sHNY8XVoVRUi/j61I8rkkz7DG0sgmog4v688RP7n7E268SHwB4Hi
         kM0oj63eLQex67boZza/xlq/NXQhQarerk1DiZ0A9cI+O4hKRcQL6zCxr+Be8MFqLq
         LmG1qw7E31WmN336Chx4XSLZrIrWEAsnnhfwbG4G297droNnZZ+MWBK8twkUXq2W6X
         g6fd+XEsK/RQshV/QOYDIvyOhyVZKmkHTIn1ZMho9R5YVmektddYquRBbZrjGIT60B
         DG5Z/HG204onRvLGN6PKGOdgeJeaVKp2kuuocKEYjxdKFgotC+WUwkDBTvfVxKWGly
         QxG7lgKBhxmYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D992E0008C;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054638.11360.7816717973824399061.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20230912072232.2455-1-jszhang@kernel.org>
In-Reply-To: <20230912072232.2455-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, guoren@kernel.org,
        wefu@redhat.com, conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dfustini@baylibre.com
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

This patch was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Tue, 12 Sep 2023 15:22:32 +0800 you wrote:
> riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> dma coherent, so set dma-noncoherent to reflect this fact.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Drew Fustini <dfustini@baylibre.com>
> ---
> 
> [...]

Here is the summary with links:
  - [v2] riscv: dts: thead: set dma-noncoherent to soc bus
    https://git.kernel.org/riscv/c/759426c758c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


