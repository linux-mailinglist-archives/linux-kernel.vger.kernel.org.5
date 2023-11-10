Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929A7E83B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbjKJUZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKJUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:25:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631882D51
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:25:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF31AC433C7;
        Fri, 10 Nov 2023 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699647939;
        bh=LYqGxfR5EISiYPve3x/bwiYNyDJEL8/baI9JejdAzbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NfwlauXzjocpEm5IZ/u04Qg1YJkjcE+5D+oeXZGKGJPAsZiph8E9h3BapbP/abPA8
         S6ISLyW1/LlRhb0GQimPEzF7ApNS44622855P4h+39fMaK8VCSz88h+bt572WfQ1Vw
         smUiqvzv7inS2JU4uvJdFD7xsw/BAE6gnP3EZZoPOuQ8vgHy4V8q1vrW3sQ4EVDOJy
         QeYlUL7dSiN5zVS4MNnTZ9T2Knt0w7bpLJvlR4n9d56zvitfSGUl0hZGcza2WPXNrh
         k4AxG8lPglZ0oPGm9eGu+uFV5G61fjDkQZMGVEcH24l2i8KkTvDv4HF7XWJMWHceHP
         9qm8dxEz4jojQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD699C4166E;
        Fri, 10 Nov 2023 20:25:38 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZU5v0Q0ybo8BZ-UH@arm.com>
References: <ZU5v0Q0ybo8BZ-UH@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZU5v0Q0ybo8BZ-UH@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: f86128050d2d854035bfa461aadf36e6951b2bac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac347a0655dbc7d885e217c89dddd16e2800bd58
Message-Id: <169964793889.8570.2232198623414526961.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 20:25:38 +0000
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

The pull request you sent on Fri, 10 Nov 2023 18:00:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac347a0655dbc7d885e217c89dddd16e2800bd58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
