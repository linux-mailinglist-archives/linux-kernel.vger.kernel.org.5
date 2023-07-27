Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4206F765C68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjG0Ttc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjG0Tt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C58B35BE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:49:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ADC661F2D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E339C433C8;
        Thu, 27 Jul 2023 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690487357;
        bh=5x0dFad77lPEJmm+v10wMkS/UpxXr+02GDsjzmygp7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QfnX7f7nWhOvil58TSlvVOxoE/D6LzZiXL0NcSPK+yuN2kkbSYIQlAuJKS15Peega
         0Rgo8LEVO8emUwDmcTojRULSo5VKv9w0S21xCRJOFGkSvFLNjPx7JnwpAnO0WEOCew
         FAdrJt4BVUZ4Tk8Y6Nhdf+vXC34r0159ZayO0ouZxxSQlEQxkC+F/CP1rjhKadm2aG
         md6yznW4Tb7VbnAk2C/kCD8Gk5+vYs2WBLEdShxsJVMEJVEb6xRRVv5iTtmALcBhsM
         PWKWanqAuV/aVl/QjFbpfM+Q/+/6v2Qxxevuu9YQNRxxrnIh/3de0qfktExOJFwI4o
         huY8L0yd1l0Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8018C41672;
        Thu, 27 Jul 2023 19:49:16 +0000 (UTC)
Subject: Re: [GIT PULL] memblock fixes for v6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230727045831.GB1901145@kernel.org>
References: <20230727045831.GB1901145@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230727045831.GB1901145@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2023-07-27
X-PR-Tracked-Commit-Id: 9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 379e66711b33f9fdc0513daee6cf3dd8d2f6f435
Message-Id: <169048735694.11614.6923638404526191256.pr-tracker-bot@kernel.org>
Date:   Thu, 27 Jul 2023 19:49:16 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 07:58:31 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2023-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/379e66711b33f9fdc0513daee6cf3dd8d2f6f435

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
