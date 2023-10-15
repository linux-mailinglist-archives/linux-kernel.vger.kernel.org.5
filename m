Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674687C9A09
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJOQYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJOQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:24:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28104DC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:24:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3CE6C433C9;
        Sun, 15 Oct 2023 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697387064;
        bh=Jz3Gy1at75saVz483wXrnsmPcO67x/fw1sBwDc5Ni5o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l4AnMf4yERDMr8GfWc7AqMpIJG/v7qAFsYJFLAE7b9m/dFfMp6ZL3xODukRgrKJO7
         DfpKEs9o5WMne+nGftS4VLaM52Xm0EMau7oVIY/2WPK+Wvp113DR1mt3fRZa20djop
         6fC2uGyuUUvxGQGFzXMI7GkD+P1Azsab4kc5m2y0HVARt26Y+PAMsNSS5kIkSks0pL
         y4QB7IFCh3rtyrM/Upc9i5XZu0Z1ZEjc8voz4nFujx1jLyireI35ige7OZm4J7rQcF
         vewpzJlB5filZKiCa0wmgHfCYz6bCdgP1rPJQ+IXNFVyRH0bGkPU+a4M2pLsxh+tuq
         cdhTdGbWLFjVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2602C39563;
        Sun, 15 Oct 2023 16:24:24 +0000 (UTC)
Subject: Re: [GIT PULL] CPU hotplug fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSulmjIwmcZdkMGg@gmail.com>
References: <ZSulmjIwmcZdkMGg@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSulmjIwmcZdkMGg@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-10-15
X-PR-Tracked-Commit-Id: c4dd854f740c21ae8dd9903fc67969c5497cb14b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddf2085598021bc84c01b1e1ac3ed992045f23ec
Message-Id: <169738706472.6658.13235262828708851774.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 16:24:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Oct 2023 10:40:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2023-10-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddf2085598021bc84c01b1e1ac3ed992045f23ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
