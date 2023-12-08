Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9401180AD75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjLHUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLHUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:00:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6C1732
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:00:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DE6CC433C8;
        Fri,  8 Dec 2023 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702065615;
        bh=+mg2Ycx/25evKO4XjrlZ0RIrM2NqEraXGcSh2peU0Z8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cxJ35/V0N8+cuXfI4TuSp6fjXDF0ZY0EotqsdwJ0Dn4TPumlFhhDrlaGIcmzp0wQc
         yAknZ0yTD8yqFXzckSmd8eqExOJF/TULw9e5Zp9dj26+HMw+3Fq3Tqk1OaCNSfrrmP
         x9DPgWB4PZ1LCVHwCxMK0UyCWFbcFRa/Hja28xzauYZ0kRkF5JOuFGixEl7Kn5R5Ic
         RL+X4zZtGRDh99dK+KLHWvbDeVsTrLdm9FDs313wJucI0PMxdjUqY1L+WIncrF6I4S
         pK+k9Po+S3E/MR2fFrqwpxXaDxPG/Jeiyf8It/DuHeO6psKgsItyTqUAbL41ad4Acy
         mV+SDos8A/NWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C380C04DD9;
        Fri,  8 Dec 2023 20:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
References: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc5
X-PR-Tracked-Commit-Id: 8f0b960a42badda7a2781e8a33564624200debc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3e2f9bda2ffa2dd7dcaf2b45604db08c6ab0579
Message-Id: <170206561517.13365.4217672733381363438.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Dec 2023 20:00:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Dec 2023 18:55:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3e2f9bda2ffa2dd7dcaf2b45604db08c6ab0579

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
