Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3A7933DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjIFCue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjIFCud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136F1B7;
        Tue,  5 Sep 2023 19:50:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D3A5C433CB;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693968627;
        bh=30LuX3f0g4pEHuHxv4dasxqe3hauX0TBet9EsndxE/Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Kvq786pQ+RfbITbEEr+TEuFR50UJEWnEEjQet3KyUriFjSApwAYhWaA8VDGU41FIv
         Sx2xQB8qUnaiA3tOWMjMbLJA3JP2yrr23EcOBsGjSaWXS3fp4r13/Fd7MMoPBay+J1
         hxoW65gUj0BC2pi8r+/j+Gqjf0IClE4lRAbDPSZGycaAzXKFGm0hY8QMiDYmYLc1nk
         Ol2mmpaJzIpEB7O4bPX3zncH2HYcMj0TtK4TXQDGB08wtogQ0nuxKOMX88pIuk2j4k
         lbprYBucpd8kQXbAs8VL4bjtcJpLeGyEAit4VQmQlDAIx2mk2ND9lqPMNYF2f/BakY
         7NhZ5irHdEDwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83833C595D2;
        Wed,  6 Sep 2023 02:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] soc: renesas: Kconfig: For ARCH_R9A07G043 select the required
 configs if dependencies are met
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169396862753.1987.16610028486614506767.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Sep 2023 02:50:27 +0000
References: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, conor.dooley@microchip.com,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, lkp@intel.com
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

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri,  1 Sep 2023 12:09:36 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> To prevent randconfig build issues when enabling the RZ/Five SoC, consider
> selecting specific configurations only when their dependencies are
> satisfied.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> [...]

Here is the summary with links:
  - soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met
    https://git.kernel.org/riscv/c/9e2864968816

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


