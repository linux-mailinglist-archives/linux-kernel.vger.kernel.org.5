Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86ACE7E27F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjKFPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjKFPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FBA4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:00:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51D00C43391;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=+IkgCci2CVR2RK1E54OUNo+9XrRa7iGFAkIPDs7u4rA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Qz1rcVQCZXc7c2x6lRLP6XvMHa6Lfu3aib6mxgwSW6yMlZos4Jxv7Dp7w0uRRpFqF
         aFTEsfRt6mOTDmPboZ84lu6xHm0cbl/vm+9zCuXS367dO9hjV6/lCPpVuzTYBgSIow
         lZnnZl4Xxlup0K3OT8vqdWhW1aYvkuxyKauU+M3ncpf2Ek/5oCxG2N0CpsBRQCVwIO
         SDL0mBDRBnOcGqjv6Qift/SrFBTVrTRongmTf5D5bGY9Mmlw/AYm7wPcYB5jU/5Iog
         33b1p2ZViB4QwuJw8wOqYiatA36MngQoXYy8/w5HlgFTfDhOk1fYbAzxPO7EiThTjI
         7/0KWZitn3IUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33578E0009B;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: mm: update T-Head memory type definitions
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282920.16503.8733188249165369994.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230912072510.2510-1-jszhang@kernel.org>
In-Reply-To: <20230912072510.2510-1-jszhang@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        dfustini@baylibre.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Sep 2023 15:25:10 +0800 you wrote:
> Update T-Head memory type definitions according to C910 doc [1]
> For NC and IO, SH property isn't configurable, hardcoded as SH,
> so set SH for NOCACHE and IO.
> 
> And also set bit[61](Bufferable) for NOCACHE according to the
> table 6.1 in the doc [1].
> 
> [...]

Here is the summary with links:
  - [v2] riscv: mm: update T-Head memory type definitions
    https://git.kernel.org/riscv/c/dbfbda3bd6bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


