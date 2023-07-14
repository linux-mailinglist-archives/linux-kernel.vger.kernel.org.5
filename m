Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82D27542B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjGNSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjGNSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:43:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CE30FB;
        Fri, 14 Jul 2023 11:43:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF62A2DC;
        Fri, 14 Jul 2023 18:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF62A2DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689360200; bh=Bon09mDec0urmze6A54Y2o0448k0+MpKSg6TVjXG9To=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Lu/g8sRPv5SNvVNKReUrV1WPAeOeQ5DQQ/bg7mLy28xrFc+z7k91E2MOwDuNUXIqE
         jHTeOK4XWFlx4Rdnh/lqIyWHMo37F2ngTIyzMdEwgGwx53CZ62ROUIUJORcSmkp4WM
         de73dQN4F4XGWlLMlwz6OxaeEQpxvY4rIbcmrbkRK4WJDQ0H9cquA+Y2Uf9YcF+zSF
         QYfLPqjn1l+KfYTMf0Z4ypa+csKDiT7Qlb9QFhwx/VsZYFG4VyvV43dW42Nz8BKYKt
         ULv/uq7yOrgsqnLUe90UmrVVqxOkAGwr9Hg55u7fjsOCkT31lzZQNp8cfsWGEs/Cgg
         LT9cIE/KizO0g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-doc@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 0/2] Update Documentation/features
In-Reply-To: <1689060720-4628-1-git-send-email-yangtiezhu@loongson.cn>
References: <1689060720-4628-1-git-send-email-yangtiezhu@loongson.cn>
Date:   Fri, 14 Jul 2023 12:43:19 -0600
Message-ID: <87bkge1ghk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiezhu Yang <yangtiezhu@loongson.cn> writes:

> This patch series is based on 6.5-rc1, it also applies cleanly to
> DOCUMENTATION tree: git.lwn.net/linux.git docs-next
>
> Tiezhu Yang (2):
>   Documentation/features: Check ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>   Documentation/features: Refresh support files for 6.5
>
>  Documentation/features/debug/kprobes-on-ftrace/arch-support.txt | 2 +-
>  Documentation/features/debug/kprobes/arch-support.txt           | 2 +-
>  Documentation/features/debug/kretprobes/arch-support.txt        | 2 +-
>  Documentation/features/debug/stackprotector/arch-support.txt    | 2 +-
>  Documentation/features/debug/uprobes/arch-support.txt           | 2 +-
>  Documentation/features/locking/lockdep/arch-support.txt         | 2 +-
>  Documentation/features/vm/ELF-ASLR/arch-support.txt             | 5 +++--
>  7 files changed, 9 insertions(+), 8 deletions(-)
>

Series applied, thanks.

jon
