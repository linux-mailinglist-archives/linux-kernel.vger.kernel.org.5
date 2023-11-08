Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEA7E5CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKHRwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjKHRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:52:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1F1BEF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:52:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB83C433C8;
        Wed,  8 Nov 2023 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465931;
        bh=P42P0iDGouK6Q27sLtECRb2Vri+EHlfqNGdPFa+Tplg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PqRjbgQPHdowN6f8MCREM7ULHxH7xkM1H4nKsWfVi6xjvFmltq0yjSZ+LzAf/Ht9A
         jXPVEUPgU+0FCXMlVRMNySvHEoA6sY54Cypw1FytNOoFuDRStrxv5Z1nRZxhSi3LrV
         I3Pm+Oh9VLsUuEPCgJ0Q1/gqHNKQz/EB04PB4qwczwrNVy6+ZlC8xW8d+5QEmHOPuT
         oCaM/ZaXcoTJPqCyskVxA9uAWYB5MKPWzPeyShBC0vi3zRuALbpk9KcMvsrr60Z/a4
         G9cIm37NOmLafVSoEGpDdJQrwmJ160/hWm5T9UnLeuYmidiWTwcGgboVs48Nki4Q1X
         id6cfyAlFPQ8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2086BE00081;
        Wed,  8 Nov 2023 17:52:11 +0000 (UTC)
Subject: Re: [GIT PULL] memblock update for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231106183258.GP2824@kernel.org>
References: <20231106183258.GP2824@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20231106183258.GP2824@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.7-rc1
X-PR-Tracked-Commit-Id: e96c6b8f212a510c9b22362de519f6e1d7920de5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 447cec034b7896f4b19dbfe3ce6c366ce7c7602a
Message-Id: <169946593112.29156.11429922784947978854.pr-tracker-bot@kernel.org>
Date:   Wed, 08 Nov 2023 17:52:11 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Shuai <songshuaishuai@tinylab.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Nov 2023 20:32:58 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/447cec034b7896f4b19dbfe3ce6c366ce7c7602a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
