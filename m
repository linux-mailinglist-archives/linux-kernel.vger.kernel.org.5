Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16A8018AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442095AbjLBAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442032AbjLBAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:06:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E5C1FE8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 168ACC116D7;
        Sat,  2 Dec 2023 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475551;
        bh=Ae3UnqSajkyHxQqQ8zvp2J+FXGjBn8TlpNsrYJvgN1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u9+YSRmC5MpQN8rji1yR+EJHtQx8lZBXHxDzz8JxB34chSMHnOQfvcQy4XLsdKVdF
         ASMedvDXulxlR7HlLnw/o/eo12y2lQ6ZAzQuA0vSbPK38bgeGk1xPW1HLCxX2J3yf/
         1+DxETC9xM4CGFY2yl7jdrjLUjZPXDxZioDI+QDwIGIPDPy+QpR7zCOG6d4aQwhr0J
         AbWgfAhnhI0QJgri64qcBdJmSJ4RAv7iG0vxNnnaZKruvjMKt+EFlcr/QYYI6YFtrl
         CspqwMMmdMDN6Px2MpwZfH5tUMvdgBucXq3KKmkNXCtNlh6t1KLtioEPUEiHQhMjEQ
         7zq/PaR74vC8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE166C73FEA;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
References: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iHKMcpK+B9dzCbDJxqZK79PoGdbLUD5hRH6sueAMgKGw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc4
X-PR-Tracked-Commit-Id: a6b31256928d78204f8f282220d3b0d64387f79d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 815fb87b753055df2d9e50f6cd80eb10235fe3e9
Message-Id: <170147555097.9445.4196790284612702987.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 00:05:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Fri, 1 Dec 2023 22:21:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/815fb87b753055df2d9e50f6cd80eb10235fe3e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
