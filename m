Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3E7F8578
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjKXVaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKXVaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5319A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33638C433CA;
        Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700861411;
        bh=xNFatYW7Klitan3TPTfOIFcpeJBq8AsTeuOZwKJDmu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YvFZYmdUNbHgCh+FMF7Zy4DCRj0kcoT/z6B4UyHWk52nf4buzZMS6GK2vDYzNCGfJ
         lgW+TlfRtZ9dWtAKIqXPktIGx6TQ/NaEJX287y9MRTwCbMJsqdYaLA/gNmwBcxQPQP
         5mdA6JtQhnlRVNwoM2HD/GSMjYtQALb/fi1DeaBOJfLE8PouHPE68dYDNi+cyRnxM5
         FGnzcHEy3ud8fa30sVpYXxOvkLNc+MjgJZE9p9NLq2SMlLtp90JuHWUYZCc4tSQQjL
         Drsq+54R0ux8DELrhWSxkDdpJsUOnVWcjxfXlv4kPqkAj/P30TN4a1pdKQf9BBpCIz
         iphsdBJrb/rfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DF41E29F40;
        Fri, 24 Nov 2023 21:30:11 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
References: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc3
X-PR-Tracked-Commit-Id: e37470624e008579fec020c6be062dd200877129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bcc689719473873e961ed91df7e929fae71cbbb
Message-Id: <170086141105.4355.10891182634922555920.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 21:30:11 +0000
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

The pull request you sent on Fri, 24 Nov 2023 19:24:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bcc689719473873e961ed91df7e929fae71cbbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
