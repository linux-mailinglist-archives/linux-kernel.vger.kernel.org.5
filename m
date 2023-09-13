Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0316E79DD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbjIMAhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbjIMAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:37:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD421170B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:37:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E27FC433CC;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694565420;
        bh=DassFrV4GUoJbluFUJM9wvLSs00AbML7c24OEQapaI0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hDNbK8sfOrFS0E8sFJYCxmD8I2ydTGlkRcCLRde0Z6DOXGO+2h14PlMIMqAYR7lN5
         d8/kWd/2R0lV8jhCwgucoEpetLJQGJHW3QS5c/cFwO0Nd99mHYohkysklumpSQiZsd
         lpMw4F0eHSi1GxoNYmXosMA5EzDBzR3CarIxHm+TV5chUWmECyqVNlGbkzYohUkajw
         d2ueKcNdG+SiiyBZmejwjvZF0zB65nhfj2UFMGVVcODaP8pAs8+R0GDtEHebe6bFhF
         vJbIYgikCzMTMj5PEVfje+YPvMQCOiKERUWUvzjwx8bGHa1XPNgBKTW0g+p7gbQHxv
         pk+OUgs1AVjSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 424CFE1C290;
        Wed, 13 Sep 2023 00:37:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] riscv: errata: fix T-Head dcache.cva encoding
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169456542026.30716.1328389839537461006.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Sep 2023 00:37:00 +0000
References: <20230912072410.2481-1-jszhang@kernel.org>
In-Reply-To: <20230912072410.2481-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        sergey.matyukevich@syntacore.com, heiko@sntech.de,
        dfustini@baylibre.com, linux-kernel@vger.kernel.org,
        guoren@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 15:24:10 +0800 you wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
> 
> Fix this in the comment and in the hardcoded instruction.
> 
> [...]

Here is the summary with links:
  - [v3] riscv: errata: fix T-Head dcache.cva encoding
    https://git.kernel.org/riscv/c/8eb8fe67e2c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


