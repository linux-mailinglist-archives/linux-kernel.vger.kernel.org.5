Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7D27A3721
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjIQSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbjIQSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A562298
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D3B4C433C8;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694975068;
        bh=Ojg/ZRx3HWWxSTH+56UQqeOnyX84IC1VGoe4xrHTenc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QBx4TelJCO2JlcjJ/2i8RrdCeIy3mB5h+BhWr5jfENUA3VIY5FfSXX59N+1rf443Q
         y81dKbvh2lIcBnXG/njCwQt+DFHFtvZq5C0am5mXvdO/coe4p5E5TttdMLQu3xCQ68
         +GJ57Tm5yeWaAChho5HR90OoAyAe5DYvwOVxbQpgE51bTVdHEn4Vt4zdrZV+W/yUTZ
         3gOFaJFqVuDqIX6hI4dT2/1F4KHM0HHhcJouEb54/0cBRN+aukbEeXd1GdfH9Eddwg
         ZnG2D3f+cGdOwoWQ0pAo5LaIAkG4b2/3oSoNn0BNUGTr3XnADcDnRtHjc++1kDvwd9
         rikP5VBG3cUYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D094E26884;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
Subject: Re: [GIT PULL] ext4 bug fixes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230917050235.GA1702062@mit.edu>
References: <20230917050235.GA1702062@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230917050235.GA1702062@mit.edu>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc2
X-PR-Tracked-Commit-Id: 7fda67e8c3ab6069f75888f67958a6d30454a9f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fde3003cab845c124253c0a42eb0cf70220c5da
Message-Id: <169497506824.30007.169321227861030506.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Sep 2023 18:24:28 +0000
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Sep 2023 01:02:35 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fde3003cab845c124253c0a42eb0cf70220c5da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
