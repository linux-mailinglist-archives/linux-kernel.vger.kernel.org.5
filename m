Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0E7E8DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 01:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjKLA4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 19:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjKLAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 19:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894930F9;
        Sat, 11 Nov 2023 16:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B3C5C433A9;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699750546;
        bh=XrSajqyIX/GMIupsbLdryjwZSJcnce+GPP7KDkPQhtc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eWIdIwNOLNdqkngfPRmCRaOwzQqWEdVf4fyQfsJ9hX51PDQ3bhmSI9QZtsMgYrcIF
         8aHZMYs4gOL/4gSqcMm7IRvWe1PcqRpqOtwPinsNQE/yPNH1jAjAZc0qUF+cE2rkNp
         nglRwyteoICzPFjGnf2iZ6kKToydLI7h8VBgwrPRWc0yrSSWvf4CHXHy6ARxGcy9DF
         YIFq9xAbPweOOdZvVR9AfcNgB3Ga1hsegS0aAjb+9DN11BMP4pAVieNjxsE9qae8rb
         FS/26AIT3WSbus8G7Vwa6iQL37+L3sU0hhWl6PyV4EpenSbokJHdqOpR8gqAekhlG3
         5K+C9ET1I0p3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68EEAE0008E;
        Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] kbuild: unify vdso_install rules
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169975054642.11360.1289704479646976676.git-patchwork-notify@kernel.org>
Date:   Sun, 12 Nov 2023 00:55:46 +0000
References: <20231014105436.2119702-1-masahiroy@kernel.org>
In-Reply-To: <20231014105436.2119702-1-masahiroy@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
        x86@kernel.org, svens@linux.ibm.com, nicolas@fjasle.eu,
        guoren@kernel.org, deller@gmx.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Masahiro Yamada <masahiroy@kernel.org>:

On Sat, 14 Oct 2023 19:54:35 +0900 you wrote:
> Currently, there is no standard implementation for vdso_install,
> leading to various issues:
> 
>  1. Code duplication
> 
>     Many architectures duplicate similar code just for copying files
>     to the install destination.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] kbuild: unify vdso_install rules
    https://git.kernel.org/riscv/c/56769ba4b297
  - [v2,2/2] kbuild: unify no-compiler-targets and no-sync-config-targets
    https://git.kernel.org/riscv/c/9d361173edc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


