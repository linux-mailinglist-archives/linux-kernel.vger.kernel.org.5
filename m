Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74167E8334
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbjKJTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjKJTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:48:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED466007
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:48:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1A6C433C9;
        Fri, 10 Nov 2023 18:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699642085;
        bh=ClGSceAlbCVo9rETcsmbabnLkfY1X+M7qOq2aAOdopc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H3M/oJeeyHi19vXS2HOHuv5E7KoP78OrzMRgYWs9Iu+dKbK72wVTdtjmCbTO26Sx9
         AOz7poR59MJgHbArddB2XSO2iJtK5a0cGe067JiQMkXfaapoNVlIqvkU0GcSS9NQ/6
         vsS95oXZFqB1Z9R9u2ejewmc2weBu4udBDUOdpItfSRFcu55PpQ0NolpwqbiZtqQQg
         cluvI2RaxTTo3Q1vcjyhF9MSbgLt5pqjDqViwc5C6wxkxXvfoNlK8LU+d+mehitdgS
         1j9d0w3lGu4CLblNrIXX0wd8U56uzL1XURikF8dHMaUPsECo/iRtY+y3mi3hyJV+Oe
         /BspRX1wMvUFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E2FFC4166E;
        Fri, 10 Nov 2023 18:48:05 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.7 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
References: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-mw2
X-PR-Tracked-Commit-Id: 457926b253200bd9bdfae9a016a3b1d1dc661d55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56d428ae1c4e27fbe02cb554b2192cd66e4df05a
Message-Id: <169964208550.13214.16081066901424762439.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 18:48:05 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 07:48:39 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56d428ae1c4e27fbe02cb554b2192cd66e4df05a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
