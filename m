Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A8C791FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbjIDWvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjIDWvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:51:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1C61717
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 15:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538B0B80FE3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15C4CC433C8;
        Mon,  4 Sep 2023 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693867869;
        bh=+u6t1Q/EO7jAB+PtoBiO0lk7Jxf+tcJQrXYevXc1tSg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZuFWE/euw/Pfu0J61H748BFBrH3hWRcJ2gILkESWW+63a0soNuqQXnnkaTf1nayA2
         bPlbTOCknHPpKUFKLnhADo3V0bQkVqp4pZrII4j7KVs/OWqvRDod8iDi9ZK6UP3MtW
         KjvWdKELmhGksYlyTsriii2467kzSR42u5Cqvy3QTpzzvF0nZeE1zPPVl6N20abXLI
         ZbGUb3SSk/NpKUO8hPqoa8zt3vVDP06b4xe6BtUqg5sACjINcgSpwQ2LZVwkeCLNky
         U1AcRQIrx52Frn8O4PYWRqlrImi2yuJkdL7hQesf5r7U+cw3zGqV01L+XYKrPAqH+U
         6VuFoxpe192iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF41DC04DD9;
        Mon,  4 Sep 2023 22:51:08 +0000 (UTC)
Subject: Re: [GIT PULL] ARC updates for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e6a52dbf-231e-2f23-78a6-54a8e62c3f27@kernel.org>
References: <e6a52dbf-231e-2f23-78a6-54a8e62c3f27@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <e6a52dbf-231e-2f23-78a6-54a8e62c3f27@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.6-rc1
X-PR-Tracked-Commit-Id: c40cad3b0aa47d6d0995637178fb6607ac3d45c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f86ed6ec0b390c033eae7f9c487a3fea268e027
Message-Id: <169386786897.10061.7564144087926700587.pr-tracker-bot@kernel.org>
Date:   Mon, 04 Sep 2023 22:51:08 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 14:03:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f86ed6ec0b390c033eae7f9c487a3fea268e027

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
