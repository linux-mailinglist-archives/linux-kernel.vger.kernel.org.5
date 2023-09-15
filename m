Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA17A2A53
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbjIOWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbjIOWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD191;
        Fri, 15 Sep 2023 15:16:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48254C433C8;
        Fri, 15 Sep 2023 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816173;
        bh=qYRt/RVr9PQ9rECRycoq3cTVu1PqbT5i+7NbrRo0Id8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=so5plEGm7r3e/8oZH70zg/cRpAvoY3VF/PEQ7urTS1nQl0YZ73TVIKHPveJ/f1vTf
         PsJA2/rFtRuJ5IuEqgDkoCuzAmmAPCcb0n+GIfDqyPn+55alelC5q+lMsfZwqbGuIF
         qresMrEBOK3Lzo1uRcywpwCzYwEEqXql1HcxioiIuvrMeVUYCFfrN29zjDD2g1p/n5
         7+Kgix5OtORF7HgVQUQODOVd5L8Qhq8QGrziQSfYdToE6jvv5IcOnyU5W6duiL4v/Q
         VssdowtsCALiui4OUu3KsHaPvJBZBN1gYt4OZItMdjpq/fbgXeHOg8ueH0MOlWrwkj
         gFGNfVf8S5l+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3118EE26880;
        Fri, 15 Sep 2023 22:16:13 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i4qvW-4=erNtMn=awuzHZM9YhUmuEuCiD9OOqNrA3Y4w@mail.gmail.com>
References: <CAJZ5v0i4qvW-4=erNtMn=awuzHZM9YhUmuEuCiD9OOqNrA3Y4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i4qvW-4=erNtMn=awuzHZM9YhUmuEuCiD9OOqNrA3Y4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc2
X-PR-Tracked-Commit-Id: fb2c10245f201278804a6f28e196e95436059d6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2dd7a1683f985235e0b3acb741f530937ebd3c3
Message-Id: <169481617319.11838.1149923626077619079.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 22:16:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 20:31:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2dd7a1683f985235e0b3acb741f530937ebd3c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
