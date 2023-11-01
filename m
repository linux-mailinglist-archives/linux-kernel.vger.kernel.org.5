Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9037DDAB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377319AbjKABoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377301AbjKABoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E390AF4;
        Tue, 31 Oct 2023 18:44:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C6A8C433C8;
        Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698803060;
        bh=ykrvRfuuuojPTwHZrO0/0npa0Uw8hmBeyHA5txm1BJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lljfK6EteIHJpDK3eH2LEz2PaJJtZ7oYQWez9z7rCTklyJ5wOgcsCuV2Q4keUnqwo
         +izY0WdjVtUfEODnz1wcrdwU2w2CvJvrO3iyToiDYd34DhKb2wjNmj3SFn2gDPbfzY
         BhNeNAw2ngZVaNg6tLso0EijH6IFwyvNC2JSXlq4MDRqbV1IomlVbjvLR6f+Rb/TuZ
         IpmWPL5xFqeOukTZ09t8cU3sYNm2N6uQAnS4oH54fZ/GQe5ZltO7oCNk2Vr0nxGP0v
         0W7ZeOVgPFy2kOP/fWP9m8nAZ2cr3mHSctmeZMiXfKMnXCZNKOoRNCj2ZiC0oBZvxo
         qxlzx3l0Yy0tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 726F7C3959F;
        Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
References: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1
X-PR-Tracked-Commit-Id: f4cb34a75e4a4aee09ff832ea2147cf8322a6a7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4b671d4c66cd57ccebeae659d9b18e28a4fc9e8
Message-Id: <169880306046.15034.15335431795917861803.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 01:44:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 15:50:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4b671d4c66cd57ccebeae659d9b18e28a4fc9e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
