Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B97EF8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjKQUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48853D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:55:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7FAC433C8;
        Fri, 17 Nov 2023 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700254545;
        bh=IXT0Yejj5ef3rwWVtwqpGoiB2+zNqowUbQ2K4S90L/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5iM1aXiTH9rTxkzyGWgeQCduyO8o9jsvrhz02EeTBKyQ8sm/QGd5ZX1H6STvOvDC
         99gBjLaGCfWCljmRRImF3FwdBK+bgiyNj9Rj3IpuiiEsGTfpNAaUB3mwK0CKq2tsXA
         SNkUiQGqo9jan7+rTJxW/0IsqSPDEGnddgnIS2CpJ7Gt1ZKPuNuAwbAE7mm0sn9fWj
         OEVagRNM38TLXyjYmpL4gDhWCr7Forudqgmqmk4xmvwzRdOF7IY3nEDCtCmFb28Hqb
         u4S2Di7q1xH7uLM/Qu+mtCnowuUQyuU0Ciic2A4gG2qvP7U5ropdLHnfQyj0JEBbPw
         /i43YeIsbCVzg==
Date:   Fri, 17 Nov 2023 13:55:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     ndesaulniers@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: refresh LLVM support
Message-ID: <20231117205543.GA3619211@dev-arch.thelio-3990X>
References: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-maintainers-v1-1-85f2a7422ed9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:24:02AM -0800, ndesaulniers@google.com wrote:
> As discussed at the ClangBuiltLinux '23 meetup (co-located with Linux Plumbers
> Conf '23), I'll be taking a step back from kernel work to focus on my growing
> family and helping Google figure out its libc story. So I think it's time to
> formally hand over the reigns to my co-maintainer Nathan.
> 
> As such, remove myself from reviewer for:
> - CLANG CONTROL FLOW INTEGRITY SUPPORT
> - COMPILER ATTRIBUTES
> - KERNEL BUILD
> 
> For CLANG/LLVM BUILD SUPPORT I'm bumping myself down from maintainer to
> reviewer, adding Bill and Justin, and removing Tom (Tom and I confirmed this
> via private email; thanks for the work done Tom, ++beers_owed).
> 
> It has been my pleasure to work with everyone to improve the toolchain
> portability of the Linux kernel, and to help bring LLVM to the table as a
> competitor. The work here is not done.  I have a few last LLVM patches in the
> works to improve stack usage of clang which has been our longest standing open
> issue (getting "rm" inline asm constraints to DTRT is part of that). But
> looking back I'm incredibly proud of where we are to today relative to where we
> were when we started the ClangBuiltLinux journey, and am confident that the
> team and processes we have put in place will continue to be successful. I
> continue to believe that a rising tide will lift all boats.
> 
> I identify first and foremost as a Linux kernel developer, and an LLVM dev
> second. May it be a cold day in hell when that changes.
> 
> Wake me when you need me.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Definitely bittersweet but I wish you nothing but the best on the other
side of the fence :)

Acked-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  MAINTAINERS | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 482d428472e7..1e6692697167 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5076,7 +5076,6 @@ CLANG CONTROL FLOW INTEGRITY SUPPORT
>  M:	Sami Tolvanen <samitolvanen@google.com>
>  M:	Kees Cook <keescook@chromium.org>
>  R:	Nathan Chancellor <nathan@kernel.org>
> -R:	Nick Desaulniers <ndesaulniers@google.com>
>  L:	llvm@lists.linux.dev
>  S:	Supported
>  B:	https://github.com/ClangBuiltLinux/linux/issues
> @@ -5091,8 +5090,9 @@ F:	.clang-format
>  
>  CLANG/LLVM BUILD SUPPORT
>  M:	Nathan Chancellor <nathan@kernel.org>
> -M:	Nick Desaulniers <ndesaulniers@google.com>
> -R:	Tom Rix <trix@redhat.com>
> +R:	Nick Desaulniers <ndesaulniers@google.com>
> +R:	Bill Wendling <morbo@google.com>
> +R:	Justin Stitt <justinstitt@google.com>
>  L:	llvm@lists.linux.dev
>  S:	Supported
>  W:	https://clangbuiltlinux.github.io/
> @@ -5242,7 +5242,6 @@ F:	drivers/platform/x86/compal-laptop.c
>  
>  COMPILER ATTRIBUTES
>  M:	Miguel Ojeda <ojeda@kernel.org>
> -R:	Nick Desaulniers <ndesaulniers@google.com>
>  S:	Maintained
>  F:	include/linux/compiler_attributes.h
>  
> @@ -11516,7 +11515,6 @@ F:	fs/autofs/
>  KERNEL BUILD + files below scripts/ (unless maintained elsewhere)
>  M:	Masahiro Yamada <masahiroy@kernel.org>
>  R:	Nathan Chancellor <nathan@kernel.org>
> -R:	Nick Desaulniers <ndesaulniers@google.com>
>  R:	Nicolas Schier <nicolas@fjasle.eu>
>  L:	linux-kbuild@vger.kernel.org
>  S:	Maintained
> 
> ---
> base-commit: 6bc40e44f1ddef16a787f3501b97f1fff909177c
> change-id: 20231117-maintainers-88eac4c024a1
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
> 
