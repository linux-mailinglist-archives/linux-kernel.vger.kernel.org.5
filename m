Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A957878CD13
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbjH2Thc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbjH2ThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E62EA;
        Tue, 29 Aug 2023 12:36:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58DB6428B;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC61C433CA;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693337817;
        bh=2gZsaEJcRJ8YIvUqBQhewnllutIfPh0QFjgpikpTwtg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hh3BeIzkaGB9xQgXk8BeTwmggoXRvwwtzHpeJ1W9MRcj7HL65b04XlxHelDVZqzMK
         O5OIT53oHOI081AtQGu23UvSzhhJTL25t8M1+O9RDdQdHTFMMAwVEPDzg+EfDOAycH
         /IuT2DAM563AqpfUtyMpAG0MMNuQuAAAAtlzXwXl6TZuxjajVKCUTdvNUSv9g08wir
         8iWcFDf1p+GHNtO5t1G8F1bOETjdy3RMSFStMTSyN0ootGnij6Zhs31PjNZ3VBqmXs
         f/0wti8HB17N9sWhX5OT1hnHF9S1qrB+h8oqrzFVgNxge1IBpnFtYoRHIsLapRt6+1
         NdzjfWS7UUO0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 471CEC3959E;
        Tue, 29 Aug 2023 19:36:57 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO3tZ204Tro+83MC@p100>
References: <ZO3tZ204Tro+83MC@p100>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO3tZ204Tro+83MC@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc1
X-PR-Tracked-Commit-Id: 77e0ddf097d6d4ceaf898e088b133b99e0a97fa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48d25d382643a9d8867f8eb13af231268ab10db5
Message-Id: <169333781728.25364.18401234113669701134.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 19:36:57 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 15:06:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48d25d382643a9d8867f8eb13af231268ab10db5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
