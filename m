Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D3E792FAF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbjIEUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbjIEUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:14:03 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:13:40 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7819A4;
        Tue,  5 Sep 2023 13:13:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7741C4AF6F;
        Tue,  5 Sep 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942954;
        bh=rziMwMIsAP1Tb/iS24XtDeUNevgeMvkQqFaKzJyfpLo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tu+3B5WjO/mCftkMt7SrQJP/U9Y23iuVs7DWm5NySD8uqGLg3nnvPIi0YU0GNEf4t
         bGltfHLcAwXPQC6m+NgC2vwzTv8R/7pY1ONdkjeqIiZ++88bzspzBkd+dd9QHrxJnp
         gjtXv71qQM2me3sJ/VYQRhYzpIEJb9WAVlbjkm4QDyefIDe+EA8IZG75ZCD1dlFxNX
         iJ0yU4rWao+HJ766H5WBCadAgEoY9DyDYBrAbYbQH3v7cfh8h/iX1c9bqqv9wW2QJO
         IYtYrQj6I/rkpZhd3Z169WPIcJ4eb+mUjhNlLGewQzJTCfnmxEbxfP1b9H8OP49iHA
         VD9md51ges66A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C277AC04E24;
        Tue,  5 Sep 2023 19:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNASaAwVGhOFnpGWrUhYu2uXPi3Oc0zAfnoTswmjYb7k=1Q@mail.gmail.com>
References: <CAK7LNASaAwVGhOFnpGWrUhYu2uXPi3Oc0zAfnoTswmjYb7k=1Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNASaAwVGhOFnpGWrUhYu2uXPi3Oc0zAfnoTswmjYb7k=1Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.6
X-PR-Tracked-Commit-Id: a3b7039bb2b22fcd2ad20d59c00ed4e606ce3754
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61401a8724c2ce912b243ef95427a9b2e5a1ed50
Message-Id: <169394295477.11207.12603485901623917296.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:34 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Sep 2023 02:14:18 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61401a8724c2ce912b243ef95427a9b2e5a1ed50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
