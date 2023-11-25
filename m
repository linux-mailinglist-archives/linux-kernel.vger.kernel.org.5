Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B57F8CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjKYRNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjKYRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:13:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2411F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:13:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B59C433C7;
        Sat, 25 Nov 2023 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700932394;
        bh=MvPiWv9DA98nRsLTZNHShzAbx8xbhrAcsSg9bZnJZto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zmtt4+eZdMbebPSaDgvZjuKJa/1ciIYyzV8RB0Af1Gi/zdJCxrQt2+tgjuszQ3/Gz
         8QFF7hhZcyxdzN5sJ8YVUynpXM6jGOpc+SDrPvCyM0aKYiHs2CuV1UlunjYIo5gTC5
         9sF5EJtueLr/2w0X+yKma/aZt5wcL50VsP6KPT0br0yZe0sXeYqa4Rs39H+IEY4uhX
         HZJ/zegdGbCY+CtmZXyS75kSvEYYsKzZNRFESPbsCDFsuknOKJDaGsf5mSomS7TPGI
         S/CJlGXh+LxPsSukVMz36BbYKIJ7aXAoGvTC5GTAiH/fOJ6SiTH3Agry6zllaOEnhQ
         bsQXtNY5OtCtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB295E00086;
        Sat, 25 Nov 2023 17:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWHQscDGVrKPEb6W@arm.com>
References: <ZWHQscDGVrKPEb6W@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWHQscDGVrKPEb6W@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: c0a8574204054effad6ac83cc75c02576e2985fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2821c393d4fdfc75a96a2fad3bec76cf3107b88a
Message-Id: <170093239389.710.7798478230598939920.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Nov 2023 17:13:13 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Nov 2023 10:47:13 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2821c393d4fdfc75a96a2fad3bec76cf3107b88a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
