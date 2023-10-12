Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16657C6ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbjJLNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjJLNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:10:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD6BA;
        Thu, 12 Oct 2023 06:10:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D4BBC433CA;
        Thu, 12 Oct 2023 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697116223;
        bh=0eUQJMX3Btxg4PAzaNK7cYqlEh3Dva5wydJpj2BHORw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IhR2A6HX9bkymASYVEFZTC9TfCo3UDrXd892XbJVeH9S4OWKthMWIiK2x2luvDUpz
         dwsC3ydt72A1pzKwk8NeYL1gTlzPzZ6xgmABxxEQ9rW6GidcoJ+DkJb2M9ZdUNbFtk
         g/NM/zrKuJDQeRY3jiaxm4BB6e0VwGNfcrh6EL8HhIVGQPm6pjMtn/9ji3iyhrSoRk
         exeG/V0Q9RNPF+4t8gIuACOvTjlXQhG7EW1YJO93nF1esIkqQHo++Wlm3f8RlR2ONi
         ZLoE2pt5w3biRo4uStnIpP7NMxofI5/yFXiK+62gLpcy0gByyAlnb8hjQNQTNVK5Zg
         /luCA2Hs+SiKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70B20C595C5;
        Thu, 12 Oct 2023 13:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: errata: andes: Makefile: Fix randconfig build issue
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169711622345.27974.9517413306391357603.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 13:10:23 +0000
References: <20230925153844.26820-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230925153844.26820-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, lkp@intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Sep 2023 16:38:44 +0100 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Compile the andes errata with cflags set to " -mcmodel=medany"
> when CONFIG_RISCV_ALTERNATIVE_EARLY is enabled.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309111311.8tcq3KVc-lkp@intel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> [...]

Here is the summary with links:
  - riscv: errata: andes: Makefile: Fix randconfig build issue
    https://git.kernel.org/riscv/c/5abb5c3cd4b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


