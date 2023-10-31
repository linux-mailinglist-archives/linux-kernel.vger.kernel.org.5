Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769E67DC6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbjJaHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343525AbjJaHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:02:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69CF4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:02:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6680C433C8;
        Tue, 31 Oct 2023 07:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698735740;
        bh=BXGcEAglGwy9z8P3i6RzMqsNfIVS7BW6JTPm2va0dRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uHbyo8jzMPSB8hMXZpoW3fqzOpHHYgw+NFs4y1XokOtJooMLaP0jArjQcUJxni5zV
         IJiOA9NskUexQoBaNAqeNQpr0SJP4peGn6OLx2O+L1nbr4ldVK0OASeTmomrGiuoSe
         02zwMrlJ3oNYaY5u+1qgwImDyClsHEPkNWvl7cDQvWEf0aBA9sXbjoE4YxrFU2fikA
         oXYWa6umj1jpQAmvLtPyteZQ83g1a+W5DJlYbGyYYfAhBdV/sk20fVUBG0REF7dvo0
         6UysuyJsc0Xwc7SyIQjrGUVIYLPekV1YeODpaMe1yQ9b66AP3YkrufC7q6E5jziC4i
         fGE8Q7T2YhtCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1D5DC4316B;
        Tue, 31 Oct 2023 07:02:20 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027182558.199011-1-ojeda@kernel.org>
References: <20231027182558.199011-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027182558.199011-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.7
X-PR-Tracked-Commit-Id: 3857af38e57a80b15b994e19d1f4301cac796481
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 455cdcb45f8fa9e7c70273e7bec0537ff02d5247
Message-Id: <169873574078.30696.17579733283212756284.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 07:02:20 +0000
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 20:25:58 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/455cdcb45f8fa9e7c70273e7bec0537ff02d5247

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
