Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225C80A849
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573876AbjLHQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjLHQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:10:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE2199B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECE54C433C9;
        Fri,  8 Dec 2023 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702051825;
        bh=k70d+rmqL6gSsL1IMke2eW576j5AfLrvXYwaW5nHJuA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DY4bWioroVoTMN18u2Csl0cPvH8wi65U946SLuE4Al6smWJECVUbeykfm80OqAi3n
         CQl+Te9Qe5U3rDd+JptrcvhzL4Ne0H5jkbvx0VhDU6/I7ewVFnFt+TRdZRmA24RPVe
         pv6csMpO8NV9VA+Q5DoOCKe2vfDpJpnAettap1yu+RnW8uB0lkACRfSUiCJg6RYv6x
         5Wj7gtQbU3JnUfS+6DEDHWZ/NSv4ktbDdPkB+mhscjgF56yq1U+RzZdPcFdujlGiR9
         YrmDvlZpVBpxOjBAdlBBfuMSUQ/Us/RjeTvnvLSCCVSsPOElA2dQHVVh11wdLy/zDD
         6o963YhQuGHSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D38EFDD4F1E;
        Fri,  8 Dec 2023 16:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Check if the code to patch lies in the exit
 section
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <170205182486.7426.12012524229624787875.git-patchwork-notify@kernel.org>
Date:   Fri, 08 Dec 2023 16:10:24 +0000
References: <20231206165458.40610-1-alexghiti@rivosinc.com>
In-Reply-To: <20231206165458.40610-1-alexghiti@rivosinc.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, zong.li@sifive.com,
        linux-kernel@vger.kernel.org,
        syzbot+2c2a76232878c44e0eae@syzkaller.appspotmail.com
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
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  6 Dec 2023 17:54:58 +0100 you wrote:
> Otherwise we fall through to vmalloc_to_page() which panics since the
> address does not lie in the vmalloc region.
> 
> Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")
> Reported-by: syzbot+2c2a76232878c44e0eae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000ce4a27060b39ed34@google.com/T/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Check if the code to patch lies in the exit section
    https://git.kernel.org/riscv/c/eb46a0076501

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


