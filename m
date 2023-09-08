Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75400799120
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbjIHUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjIHUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:40:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25D3B2;
        Fri,  8 Sep 2023 13:40:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63F94C433CC;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205643;
        bh=wBI/jVVPkO6MDdKncUsLqbcjLCfFjK8Y97zJH/z/WG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M3zX/ABwAJwZKbhPYr7gohtCQuyMzZMmHRgrCYw5hQb8B6ZAgTpK0EeqoBaTxLJoQ
         k0cQ1Yn6J+5E/JgYqyJ3mWLyIK7nv3BXB9josHCfVuhwGus2VFAWfiESyyXXRSX29m
         v5yxJdME6RPT+LhxyYvJV+92DJ7oSRcZN9XlmU3jKvVfUP363PQp4l1d8xz4C7+sD9
         I78x8dyhOS7TteRYF09PzlIRxe6iwqMg7Ajvqa/lPZRCHzkFlW1ZQp2cD08hKdRWLQ
         y8qG0JwMuLYfgV9jG5P+Gi4MsISaN+qQR9X1mScNoUS/dT32wXE/304vKxsLs/ZEvr
         KhJAXb6f0I+MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C1DDE5250B;
        Fri,  8 Sep 2023 20:40:43 +0000 (UTC)
Subject: Re: [GIT PULL] Additional thermal control updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gjTAXsgob=tYenV_ifSWNVwBPmo6CfoQFp9=bRXcj3QA@mail.gmail.com>
References: <CAJZ5v0gjTAXsgob=tYenV_ifSWNVwBPmo6CfoQFp9=bRXcj3QA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gjTAXsgob=tYenV_ifSWNVwBPmo6CfoQFp9=bRXcj3QA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1-3
X-PR-Tracked-Commit-Id: edd220b33f479cf9dcda0bfefb2cb8c5902e9885
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32bf43e4efdb87e0f7e90ba3883e07b8522322ad
Message-Id: <169420564330.32167.14881265749721609620.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:40:43 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 21:25:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.6-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32bf43e4efdb87e0f7e90ba3883e07b8522322ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
