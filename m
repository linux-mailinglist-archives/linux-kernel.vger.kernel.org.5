Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954E7CB82B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjJQB5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjJQB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:57:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A8B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:57:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EA6EC433C9;
        Tue, 17 Oct 2023 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697507846;
        bh=cB0B83J1zhfyQDLQOZDXJOXMnckvdXonfb/HSb+4UWY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vlek4TkekVwz4hQvvYGtoEkYXWmBgPSEaq6wQ2kDNNnWRTpWPTIuZgdUQCpSwD1MU
         U7nAq2EjMCwIoNs5Nz2XK3QN3UdiiElahRPJXXLDmU5861F/uYMhNvrUGjJX2bMl/m
         U1oF6iuM7oBe/aRIxcZ7nv+Vjn+BXX6WIuGUj1vhIbHm5SmKkU+r9yzZjixT0m452u
         sfoiYQ5lhmcmvanfX2woUDKWb0BvOax2vC0dxbSgGs88mBkTDpwykO5Cg8mBF+DVVw
         Ps6XOH3SucvaOl3RlkBJvo1OCgYtU2L0Bp1cis0y9C9t1K3fZAa2Ps1iENAL87HNEF
         9WSgx6bAZ9y/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13015C43170;
        Tue, 17 Oct 2023 01:57:26 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
References: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231017103949.3e81d95ecf737e55bdbdf7f3@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc6
X-PR-Tracked-Commit-Id: 700b2b439766e8aab8a7174991198497345bd411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
Message-Id: <169750784607.28912.4615648733948126370.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Oct 2023 01:57:26 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Oct 2023 10:39:49 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/213f891525c222e8ed145ce1ce7ae1f47921cb9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
