Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0217E5CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKHRwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjKHRwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:52:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8701BFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:52:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27305C433C7;
        Wed,  8 Nov 2023 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465934;
        bh=BKkD7Q3EK77TDJ3/V4QDl5+V5ZpQzgcsuI9IvYmu3Fw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CJOnmYiakFqWWSWAK5vWOiwYADdlLIdsaA6C6SZ7Zyt0AJW0yZzVA50YqwmcrtFro
         pSDTWmyVfg1Jn34+NoPxaL8RpUiGzYy+9BigflHhn9gqyu611tEaMAviXaFpAqaiYd
         tUQRwaGNAE0XN+hiy85ss597fdA1s9b+DEflfThWXmomWGAMdCN9pKJf7XLw++UsKQ
         V2gKIiUTRBXX8THYvBBy6AnJSq7YHKFmmbo8835dR6Oyzp1cujNRdCrF+qzarPm4IV
         IXy/f4T8tHpb/+K5TmtFwJSmZ8cS4jb5hj5m+VcATsBAViTMmdq0+3Vq1KLZv4YFeU
         jqECfNZFXVF4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 146F5E00081;
        Wed,  8 Nov 2023 17:52:14 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.7 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ff3fd3dc-81e2-440e-9e77-b97a64e23520@palmer-ri-x1c9>
References: <mhng-ff3fd3dc-81e2-440e-9e77-b97a64e23520@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-ff3fd3dc-81e2-440e-9e77-b97a64e23520@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-rc1
X-PR-Tracked-Commit-Id: e1c05b3bf80f829ced464bdca90f1dfa96e8d251
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d46392bbf5c6ce594669f00b8177f0b34e983f90
Message-Id: <169946593407.29156.17001806080175480755.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 17:52:14 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 06 Nov 2023 07:13:47 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d46392bbf5c6ce594669f00b8177f0b34e983f90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
