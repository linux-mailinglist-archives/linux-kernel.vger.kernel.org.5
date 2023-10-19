Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D07D01BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbjJSSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346271AbjJSSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:36:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AB126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:36:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96B60C433C7;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697740576;
        bh=qe8WPKvIv1w7H0c3U2BcfeqDFbY8yaiEApkGvIT6LOs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nnl/863KLj8TUcLC+MkQOcLCml0CFMeElQiK0A0zNn/xJmrnQcPx8GwJFXqTOsQHO
         +jq88HKMDZX+3VZyuBq8gVC4rlbLFEdO7c1Js5IYGlW+SO30YLhmY8/OzOCvWXuGbT
         9CCTc9epQU+H4Sz70SgT4IizQl1eITX4Cr42QsNPXlRO/6OW66Fuo8nxkgOMgavqfM
         7XB4xMn4Lcl+o9m6Xsk61YY/PsqmOmUD3xe/N+gy3nVYmMRVE8gEK7JtAhRdgwLeBR
         2k890OwFNaq+PDEHs2NT2ZEy+V4OVvb4U35BE8olTHLninIQR+KalBYr1swt3hZFtV
         LsSg8o/sbx1HA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82D79C04E27;
        Thu, 19 Oct 2023 18:36:16 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp fix for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202310181752.D9A0B87E@keescook>
References: <202310181752.D9A0B87E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202310181752.D9A0B87E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc7
X-PR-Tracked-Commit-Id: 31c65705a8cfa5f80d3824c686ab74b0409ee76d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 189b756271e69bb6b9dfe4703b7f74855ab201b4
Message-Id: <169774057652.20290.11934725522607877025.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Oct 2023 18:36:16 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Oct 2023 17:53:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/189b756271e69bb6b9dfe4703b7f74855ab201b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
