Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497B7EE10C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345184AbjKPNHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345003AbjKPNHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:07:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04521AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:06:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F81C433C8;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700140018;
        bh=p4MjUYmwNsoB0zXjL2QElamoa3NDWfUyYXsPy3eVInM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JBmwkGjIsSE1vcTsOpwTK1gUCAMeXbLozosp2IWfDBGlRfxi3kXwckKu3+iIZsT9N
         vLqxMktN/9pUTIyq0Q81/B+sN/NxpIzqIt2YuEAxX3dScmd+vDHIHSzUJhrIHRUY7l
         maZmdKKfKc9gpuIU6jQE9TgRk+iEYlcsyXwHtVg/RRw7+9x7pU8xTSlskLNbNC+N30
         YmkNuaUA31R6ogLVckBmFCfLeQXY1vURh2Pii4GiTPLMBBrgYEur9cposQpME9XE/2
         ivAR1q+kLEe6H98Gw4O3ox8dADglM+/H+TsizvaI/DZtgPbHcWk0tl1vAyCXvGcYY8
         5AcippUo6AmNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90506E1F660;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] vhost,virtio,vdpa,firmware: bugfixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231114152436-mutt-send-email-mst@kernel.org>
References: <20231114152436-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231114152436-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: e07754e0a1ea2d63fb29574253d1fd7405607343
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372bed5fbb87314abf410c3916e51578cd382cd1
Message-Id: <170014001858.19711.13760886707112955163.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Nov 2023 13:06:58 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair.francis@wdc.com, bjorn@rivosinc.com, cleger@rivosinc.com,
        dan.carpenter@linaro.org, eperezma@redhat.com,
        jakub@cloudflare.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Nov 2023 15:24:36 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372bed5fbb87314abf410c3916e51578cd382cd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
