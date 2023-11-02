Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737617DFB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345275AbjKBUU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjKBUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:20:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B6D6A;
        Thu,  2 Nov 2023 13:20:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2432C433CA;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698956430;
        bh=6/aiuKDvOrf/kc54SvicUmukJxjwhrkThS2b09C6F3I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CLq/02a7+B7VxIfJ0B2pXUva2EYqrkG5RXD69vQTaXSd24nQtECzDn2cihGGuNHB0
         /lEh7Fno6P/5dGUtR9RZYAiPp4ZUIYvT1nSQoO9+6Lw4BlWgAiMjRr2MtB8RuBfp1g
         +9yjm/1REIVZBOELkN9M+4x4fEWaq4u0Kehd19TGg5AhV/u/ZwKtKfgavsSAmCb7Mh
         V3/+OIfmapsFXgyNlZiQqSkxCjkDKSegIJCePzQt3LMIWVRVJLkJivjciltOjngmuw
         TBaxrYWvtni3ksecZ609BpMovh7VDVM0+NSawza9naTzVlsSLBVHTk4e9N39lhvzZz
         yPZbtcyzvFZcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DBDEE00084;
        Thu,  2 Nov 2023 20:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/5] Enable peripherals on RZ/Five SMARC EVK
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169895643051.22248.10364642768194481579.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Nov 2023 20:20:30 +0000
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Lad@ci.codeaurora.org, Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, conor+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 29 Sep 2023 01:06:59 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> This patch series does the following:
> * Adds L2 cache node and marks the SoC as noncoherent
> * Enables IP blocks which were explicitly disabled and for
>   which support is present
> * Enables the configs required for RZ/Five SoC
> 
> [...]

Here is the summary with links:
  - [1/5] riscv: dts: renesas: r9a07g043f: Add L2 cache node
    (no matching commit)
  - [2/5] riscv: dts: renesas: r9a07g043f: Add dma-noncoherent property
    (no matching commit)
  - [3/5] riscv: dts: renesas: rzfive-smarc: Enable the blocks which were explicitly disabled
    (no matching commit)
  - [4/5] riscv: dts: renesas: rzfive-smarc: Drop dma properties from SSI1 node
    (no matching commit)
  - [5/5] riscv: configs: defconfig: Enable configs required for RZ/Five SoC
    https://git.kernel.org/riscv/c/db38228c03d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


