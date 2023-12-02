Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC418018B0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442126AbjLBAH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442029AbjLBAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:06:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111D1FE7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D6AC433C9;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475551;
        bh=TgggRG1TMqZFiFbd5FDYfIrnrqqA9H1+qPcZXxXiPGk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mOuATeh2Kp+uOiJdekFKZ7l9n7EZ+b5ZzeVg+5GfKkr1l+sHdWDPILwLNdISdhSv3
         /YpAb+u8NVVEH0wgytt6NQ/ihsJIljm7Pda7ku2LjEpabb10enmmkBIedUm5uu3Q8C
         IU/K1bfXNkWh+FipHVv0pZ+ORAGY2KY788zFa4EUehT/aF0XoiODpUGu4O/9EsLHDQ
         r+h6iV+0+1sG1PomhwJsWRFlPwT6RjOhS5ZnUNU+oQ0yZNCT0C8iqRHjCotmjz4Q8X
         Ltxe92CWvwhLN8hiEfPLGboxalS9hkJvVLdhsQA4mfOttykh/ZkmdG0HBbetmj/DIi
         zwcGQVPtEG8QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D74B2C73FE4;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
References: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc4
X-PR-Tracked-Commit-Id: 7d4c44a53dade7103c3a9a928705db2326efba6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce474ae7d006e4d451d8b9e23ee8110499edb62a
Message-Id: <170147555085.9445.6777555479344897778.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 00:05:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 22:19:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce474ae7d006e4d451d8b9e23ee8110499edb62a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
