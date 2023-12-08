Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E7380AA12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjLHRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjLHRIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D744199B;
        Fri,  8 Dec 2023 09:08:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36764C433C7;
        Fri,  8 Dec 2023 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055310;
        bh=60Vpjx7/NhWAxeON2bh84Ga6PFDLeO8+JRTVS2fg/ko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=juchQTLjMkmJ/9aNcFBz5fGJfORSxKxzX3pBvnmp7TN8tSijA1pYSssiJRMCpcnbM
         vVbmZmCSYqkW2TUsd848ULWpz5WhEq2JGuYxJKt/AR1KGRG0uNQR2xlka0M9ZJK3W4
         64W/nq3blaFQDDRAKzUDydt7xvvRcbJYRrOhqlYfpJKhxPt7SYGdn8Y/7qbNwE0Fj8
         kk3kV/zlW/uhdkvXUAepVOyeFEFmDunKedSxVTBkGfZU/QsX+17A75sseAEa6SoV3Y
         ZfsQVF3dxmXEoL4mjdKv6317ezwM5CUkKfiaDcttMkeeNu7ptmxrT3m3gXk3jni6+h
         ziGlIln0nd/zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25E82C04DD9;
        Fri,  8 Dec 2023 17:08:30 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231207185341.570f240a4f51d820c08c9e0b@linux-foundation.org>
References: <20231207185341.570f240a4f51d820c08c9e0b@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231207185341.570f240a4f51d820c08c9e0b@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-07-18-47
X-PR-Tracked-Commit-Id: b2f557a21bc8fffdcd65794eda8a854e024999f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e819a7623f19534bce6d53678b581c167b5b079
Message-Id: <170205531014.9242.8107782711761982831.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 17:08:30 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Dec 2023 18:53:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-07-18-47

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e819a7623f19534bce6d53678b581c167b5b079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
