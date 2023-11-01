Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09D7DDAAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbjKABoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377143AbjKABoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:44:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB53E8;
        Tue, 31 Oct 2023 18:44:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72DA1C433C7;
        Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698803060;
        bh=xLqwMmOgZhXjxEfYmxFCdxKR3P7QuMdU4k8J9gjGGa0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oNh7CO1xhaeNLanEBhKByu9+ghRTsF3BLyvbmTewQ4zyyQSDzGpFntybiIkAAYET4
         iD15LsKoHRmwqhYo1ReTUNaIlZrrgFetGyCBo1WItkFRwiW9qDGu7rjxFdZ8Yb3IVc
         jsYdjOWXKYwzF9niQI79KB0GBTHutWVS9NG0CKO7F+9jpdSn/HqXRv0sfYb0C0ABg7
         uDgPkf0fyl6ZXCjx/rBBn10xFEQOGFlNc+tNWwz1j5gSiRtaM/eN/B9Dc9NeqPyivT
         EdHkEkvOsh0kY/uRUmNSgqYfCA9XGIfBkQcfpz0KQnr9CvtYOz/ufvavd9YaYoDOUA
         jrkAy8wnmFVPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57CDFEAB08A;
        Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
References: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.7-rc1
X-PR-Tracked-Commit-Id: 607218deac6e29c52f4ce521ed467a0d75090a0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ac4677fdb76f644e09a6331bab65919b85f617d
Message-Id: <169880306035.15034.1145407508156698137.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 01:44:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 15:48:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ac4677fdb76f644e09a6331bab65919b85f617d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
