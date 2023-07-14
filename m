Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3324A75431F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjGNTQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGNTQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:16:16 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D535AB;
        Fri, 14 Jul 2023 12:16:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D11B02DC;
        Fri, 14 Jul 2023 19:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D11B02DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689362176; bh=9+KAduSppuO0HKOQyBqeDDZ71UMKFOK16uTR3b+q4Oc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ca0mlRY4IZyNuy+qg8P2/TH5v2y8/gdue0t4DkL61MERD8blmiYf+4nTR7mCqJHQY
         LQA3gOp7/gkFUt56kbkOkDyxbu5Xxlxm81ky7JBPdPZAJu8WlqLN1tj9wr6rsInlfC
         Vkvyr9Pe28WRwEuGIMqCTGrMye6ktH3eqkf0RfaJgGJqVeewdsDSJWmPAXiBx1Gfix
         3KNl0CgaupABUf8V6whvs9g3XZunfUVYOxoaoYhOUDdyVtpUrijGQHRxFRty5iPAxt
         SoUSbfe1cjWM82J6TDqE5utCUn+kSmPQPv8O0dV8ZgRAE3fG5TE0TfszdTnGxcg+y6
         wSuSijBvyiC/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kconfig: docs: mention gconfig at top of kconfig.rst
In-Reply-To: <20230704000120.8098-1-rdunlap@infradead.org>
References: <20230704000120.8098-1-rdunlap@infradead.org>
Date:   Fri, 14 Jul 2023 13:16:15 -0600
Message-ID: <87mszyz4lc.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Jesse mentioned that gconfig is missing from the top of the
> kconfig.rst file, so add it for completeness.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Link: lore.kernel.org/r/CAJFTR8QgYykuEq_AkODEWPUYXncKgRBHOncxT=ypZTQODkyarw@mail.gmail.com
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/kbuild/kconfig.rst |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

jon
