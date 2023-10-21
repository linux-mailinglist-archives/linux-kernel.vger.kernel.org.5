Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AD7D1F4B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJUUER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjJUUEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E901A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:04:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE959C433C8;
        Sat, 21 Oct 2023 20:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697918650;
        bh=c2b+HPbEiqMXZSuJ6PQzwDd8rImXip+TYWYZhkgTQLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W8m8NHtVZ5Rz+jNrAFZmF7DOLNzHNHGy9L9Cr/sCtiJrh3CcrJ+cKhLrCgVxEIcdb
         HDfrVowBy+HqxVGziGVxaJzn7VcXSjfhebCBIbSbpkJU0sMCoDx1yR4NVDsOIzR3A2
         0G4pBRU0O6beqs3PmUfBa/1/V3i7ICqR6kqXwyAgNKKx9CrFq17NRPsz1urqE0SS9y
         G9E+W+mxsdrtMgIhY+NgJ15XzItirK3bjhRvcolgqTJdQK3O/d8xo8X53eRZBG3bQO
         VFjyGUVLLsttUaiT+iDruyKy7u7wwlagfhT5GU3M/jy25OWNc882i76MQ6a1s69a8Q
         n3tyknOZY4g5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B562E4E9B6;
        Sat, 21 Oct 2023 20:04:10 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231021181259.10931-1-ojeda@kernel.org>
References: <20231021181259.10931-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231021181259.10931-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.6
X-PR-Tracked-Commit-Id: cfd96726e61136e68a168813cedc4084f626208b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03027aa3a5c698b8fe1a0254284198cb1423481e
Message-Id: <169791865063.17709.6346007355733465158.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 20:04:10 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 20:12:59 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-fixes-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03027aa3a5c698b8fe1a0254284198cb1423481e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
