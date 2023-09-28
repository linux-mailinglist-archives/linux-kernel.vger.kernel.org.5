Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727347B11B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjI1Et6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 00:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjI1Ety (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:49:54 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79FC13A;
        Wed, 27 Sep 2023 21:49:51 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 7D0898029B;
        Thu, 28 Sep 2023 04:49:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id AA8A13B;
        Thu, 28 Sep 2023 04:49:47 +0000 (UTC)
Message-ID: <296cf67699ab7aefe378b6719230a50e2851fe7b.camel@perches.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: migrate some K to D
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Date:   Wed, 27 Sep 2023 21:49:46 -0700
In-Reply-To: <20230928-get_maintainer_add_d-v2-2-8acb3f394571@google.com>
References: <20230928-get_maintainer_add_d-v2-0-8acb3f394571@google.com>
         <20230928-get_maintainer_add_d-v2-2-8acb3f394571@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: AA8A13B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 69ieiws3y53ioe8ryg6onpcgzq5oqn5z
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/5VJjhIijyPfi+oXi/uXwj1ido5cqt1jY=
X-HE-Tag: 1695876587-516273
X-HE-Meta: U2FsdGVkX19eo0uOjCcm4mPH7s7d0Lw6X1PiL8S2be4QsQ4rx0FQOElQVxN2szfChbPT6lt5yBjBXi8j3YYJkmr538LqEbJDe5pRqYui56Jz9jk380QAFmM9EwcqlurPUaFwklLcP8OfNRL6YzX1d+uLNq59GcROf8e/4nQ1uz69Iq6Qr7jMbitVhLesRK/AfXzLhYQaa/7k/brdBq0lPa5b98kyqGfFVyQErrnijpuZQt+OprNhl+xEz/zdgajVF5hPgBj2i4xCq3cWOVSpyYPnMIffBpLF/dqVgbzZRhGc2AmI+PPKE5dzPbX74C1BU5riky1NmWHU1/7AKaR+sdovPCrhVqwuGjMm094EjmoOdKgKrGb3CsywLuGJBpAvZFns0SFm4iUAxjcT9dsblYMl/ZCcKBEgVDLsvME2em84mOFRlROP8U8IjSuWvbunrLfRjsFi7TjsPrPewOh4y3lvpTA7uYYC69THH0r6+n2tK+F5AjvIhex28voOXMYHhw1tUr5Fv0Cs/aAomT9fOCVD0JJChqJfcAjZ07Hl4wkusfSAc7R/61cm9Gz4Ge5knH5WVQOs9mdc3RJjYz505HZPtuHNXCL3A1EAvTrbmmzeyBH50r/ewA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-28 at 04:23 +0000, Justin Stitt wrote:
> Let's get the ball rolling with some changes from K to D.
> 
> Ultimately, if it turns out that 100% of K users want to change to D
> then really the behavior of K could just be changed.

Given my suggestion to 1/2, this would be unnecessary.

> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Original-author: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94e431daa7c2..80ffdaa8f044 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5038,7 +5038,7 @@ F:	Documentation/kbuild/llvm.rst
>  F:	include/linux/compiler-clang.h
>  F:	scripts/Makefile.clang
>  F:	scripts/clang-tools/
> -K:	\b(?i:clang|llvm)\b
> +D:	\b(?i:clang|llvm)\b
>  
>  CLK API
>  M:	Russell King <linux@armlinux.org.uk>
> @@ -8149,7 +8149,7 @@ F:	lib/strcat_kunit.c
>  F:	lib/strscpy_kunit.c
>  F:	lib/test_fortify/*
>  F:	scripts/test_fortify.sh
> -K:	\b__NO_FORTIFY\b
> +D:	\b__NO_FORTIFY\b
>  
>  FPGA DFL DRIVERS
>  M:	Wu Hao <hao.wu@intel.com>
> @@ -11405,8 +11405,10 @@ F:	Documentation/ABI/testing/sysfs-kernel-warn_count
>  F:	include/linux/overflow.h
>  F:	include/linux/randomize_kstack.h
>  F:	mm/usercopy.c
> -K:	\b(add|choose)_random_kstack_offset\b
> -K:	\b__check_(object_size|heap_object)\b
> +D:	\b(add|choose)_random_kstack_offset\b
> +D:	\b__check_(object_size|heap_object)\b
> +D:	\b__counted_by\b
> +
>  
>  KERNEL JANITORS
>  L:	kernel-janitors@vger.kernel.org
> @@ -17290,7 +17292,7 @@ F:	drivers/acpi/apei/erst.c
>  F:	drivers/firmware/efi/efi-pstore.c
>  F:	fs/pstore/
>  F:	include/linux/pstore*
> -K:	\b(pstore|ramoops)
> +D:	\b(pstore|ramoops)
>  
>  PTP HARDWARE CLOCK SUPPORT
>  M:	Richard Cochran <richardcochran@gmail.com>
> @@ -19231,8 +19233,8 @@ F:	include/uapi/linux/seccomp.h
>  F:	kernel/seccomp.c
>  F:	tools/testing/selftests/kselftest_harness.h
>  F:	tools/testing/selftests/seccomp/*
> -K:	\bsecure_computing
> -K:	\bTIF_SECCOMP\b
> +D:	\bsecure_computing
> +D:	\bTIF_SECCOMP\b
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
>  M:	Kamal Dasu <kamal.dasu@broadcom.com>
> 

