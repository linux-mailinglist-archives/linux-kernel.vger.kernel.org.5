Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739778FFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbjIAPXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350234AbjIAPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:23:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC2E19B4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAEC2CE23F6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D014C433C8;
        Fri,  1 Sep 2023 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693581784;
        bh=zsK3hxQv9IBEn48Em2SCl8YjvJHL4gPCyfQQqAB8FTg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TD3TUbiKTnZ1N793pG6VvsEkPQQ4kw34bNpMVqr6bQ0JyPCZdtRDArJYd2LzzsrHS
         bXSqbA4P4suxtMItZw4kZjESSnBkAmqjcDPBzdMDuMlgIi6+M12SzJHxCMtNvMLVDX
         GwmVujd9ylkxtTaMhNsFll4kFx0rpKoYq+YKUqV8n2Zlopuqol1Kuopn0TRVzo4ajv
         4E4LyTH3VrWOU+PymgppYukU/NKWrfH94Y40cWkX2B88SNFEBUr5iElVqfqASogpqQ
         /zLFhfS4gnTHxQlxFMMlkKLeKh6KYANscg+yO7WZPfIcBsugThCE/C0KA36I9TWobt
         x0eGgQ5InjHbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B2D1C64457;
        Fri,  1 Sep 2023 15:23:04 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
References: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw1
X-PR-Tracked-Commit-Id: 89775a27ff6d0396b44de0d6f44dcbc25221fdda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9
Message-Id: <169358178410.20073.15929170829792331101.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 15:23:04 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Sep 2023 07:41:21 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
