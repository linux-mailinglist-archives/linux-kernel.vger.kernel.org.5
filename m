Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3557DC0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjJ3UFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjJ3UFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E2F9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD538C433CB;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696340;
        bh=sUoWGUnX2EgeLCClb7nbzCH4wjN/XcLkZTB6pfNlp+I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qhK0qcjA3MQvWDabeLZ1NVVioU1L5mjJ/AMmrWFg08KvLC7r3RkTM6m5DqlOFVhDf
         EWVGmDYaJif2wzvZ9k9VNUh0IxC0K8+dJKgk/r9c0/GpFSIElZRCA5iZURiIAEWCjR
         sgwl2GKXGRHAzDmEAg7JzUTq//nItLe/Vu517KIpf5D/8K9bgKytaV5rV415qndjq3
         OHJAO9aIYLAnjrmBpJLsBdZQh8U5zDMfBPu/NISOi6Atm54KAIg/8F++A3XtpHtw1C
         3LQLHFkvInYxZCJMv591lr9iMZRLoL++EiLVYbZNbzyo9Sa+wi4BdafibxNkFKciW1
         M81q1IfddpTXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A435C4316B;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs io updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-io-82cd868e9b4f@brauner>
References: <20231027-vfs-io-82cd868e9b4f@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-io-82cd868e9b4f@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iov_iter
X-PR-Tracked-Commit-Id: b5f0e20f444cd150121e0ce912ebd3f2dabd12bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d
Message-Id: <169869634062.3440.16856320624280365187.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 20:05:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:42:35 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iov_iter

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df9c65b5fc7ef1caabdb7a01a2415cbb8a00908d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
