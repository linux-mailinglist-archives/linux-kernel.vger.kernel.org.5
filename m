Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E38018AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442055AbjLBAHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442027AbjLBAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:06:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96C1FD9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE1AC4160E;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475550;
        bh=3kAMnM+h9y2yvAFlVBSRQg2MGjN5V/t2eH8tWJk/3Mk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J6QV8SPTBwyTkEPpK7RCc3cofFJAbuDVSQlm7oiNQxyBqhQ07W9b4y0l22YMMBbzT
         SW3cO1QUu5i7BKJ5oYwEPnP+PuOhJ4gZjMShAotwOSJJwL1iglH6Agu6Qi4u10YQN9
         6VFdKjZXLjvxiXg4JndQNHBVzPgzLNBkVsWGJKwe2bT7Gefw9+Qs+7aEe2UTpZP6qG
         2TELcjg6FYiXK45/PYlivAA2OZ+kQPYp8IgWyOjiVUnYAjrVyTDafInZsyTV3YQqWS
         IEFqT90lu9Byda5Qmx/4b70M/B9Z0c1hLmyxPVjusZ944xQK7Ti91vfUee2pfTLNEC
         TybjbVm9BNtag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6EBCC395DC;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWodVqC4gvcASpba@arm.com>
References: <ZWodVqC4gvcASpba@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWodVqC4gvcASpba@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: f5259997f3e8d6edfcc2daf5b2c0b34f074d7bc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35f84584806e4e127a667221c592f8ae248132f6
Message-Id: <170147555074.9445.3114194944879210462.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 00:05:50 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 17:52:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35f84584806e4e127a667221c592f8ae248132f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
