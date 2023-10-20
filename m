Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A667D0D24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376883AbjJTKbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:30:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9027310F4;
        Fri, 20 Oct 2023 03:30:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A28A2F4;
        Fri, 20 Oct 2023 03:31:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067A83F5A1;
        Fri, 20 Oct 2023 03:30:47 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:30:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include stackleak paths in hardening entry
Message-ID: <ZTJWxLq4lHElmR19@FVFF77S0Q05N>
References: <20231019004616.work.960-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019004616.work.960-kees@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 05:46:20PM -0700, Kees Cook wrote:
> While most of the gcc-plugins are self-contained in the
> scripts/gcc-plugins directory, stackleak actually has some additional
> files. Add those so changes are directed to the hardening list.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Makes sense to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f18ed0fbd42..a4de29c0036f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8615,6 +8615,8 @@ L:	linux-hardening@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	Documentation/kbuild/gcc-plugins.rst
> +F:	include/linux/stackleak.h
> +F:	kernel/stackleak.c
>  F:	scripts/Makefile.gcc-plugins
>  F:	scripts/gcc-plugins/
>  
> -- 
> 2.34.1
> 
