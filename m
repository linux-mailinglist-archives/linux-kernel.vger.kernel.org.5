Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4C7E27F1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjKFPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:00:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE9F3;
        Mon,  6 Nov 2023 07:00:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D32C433CA;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282829;
        bh=mpBdQjV65JRskvJp5MGoenmwHDRRCPUdFaTCUpk5jRU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FQebDZe4rr/4KDXpniGFPdHhbt6ngDrOfVEVDzKnxWfMRILRqRRfCsFjhiDiqna2p
         h9llcV0FCkX0PilEpB6XaRUiahZzFlk+lKQOVFw7W9QUpQSHgkg6a2Ho4rdrgtqMx8
         w6J04a2VWbnNvOtswzn7B8WodcsSoq459mXNX90q2ubsyaz5OnXywnR00sobOnwC6Q
         VyOwY6jCNi9gkSfoKhCWZ378TKzEy0yXlyzFOFXtSUFZ1wXgsLGWdMjNWfa9+dxov8
         B7fuLgTMrnSrilZkpxumw69EpT/j2+UI0TmcsYgR0B5zJOJzLh7f0fiSEXxqAf1c3m
         cedeTZqJW6/mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C23FE00097;
        Mon,  6 Nov 2023 15:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: kprobes: allow writing to x0
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169928282904.16503.14969147654698213248.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Nov 2023 15:00:29 +0000
References: <20230829182500.61875-1-namcaov@gmail.com>
In-Reply-To: <20230829182500.61875-1-namcaov@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        stable@vger.kernel.org
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

On Tue, 29 Aug 2023 20:25:00 +0200 you wrote:
> Instructions can write to x0, so we should simulate these instructions
> normally.
> 
> Currently, the kernel hangs if an instruction who writes to x0 is
> simulated.
> 
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> 
> [...]

Here is the summary with links:
  - riscv: kprobes: allow writing to x0
    https://git.kernel.org/riscv/c/8cb22bec1426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


