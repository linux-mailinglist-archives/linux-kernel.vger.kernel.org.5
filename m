Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9975435A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjGNTmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbjGNTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:42:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A492D57;
        Fri, 14 Jul 2023 12:42:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5F4505BF;
        Fri, 14 Jul 2023 19:42:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5F4505BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689363760; bh=qTA+xiM0pkDKeWyhq+FQrKcNOUSzMCqp5p91kKbMUfQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=UGWlXRaxZUbXF9H6+XtSEFPouFI4NyyPR8Y88/wcsuUFNbqMNk6/yuQpZUubYJKF9
         HdNQj54eM3yRvEjMDyITBcyAkhQF/GsBZHZsZACWiJPggUGoJ6NVDxwR3wIgZSz5H8
         nFz7+nwTXsTLKMt2jA5jQkcudaz3z8YyKeeMpGWoUaB2hxKFk9Gtw5lWPemLS1YgGX
         GawuZjQ+djVORVsnamG9PjULh8gc+CxXCpN/G90LXSglnltZlFsXs/Gdrctq4OSWR0
         2Dl5bQ7R63KwRud8BatHLNYJa7LS5OGF3oEn++oqsP5Pl7rn/kLXBi0Um8aFTxbA8d
         u4/rU3tPM+o3Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Avadhut Naik <avadhut.naik@amd.com>
Cc:     linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
        linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH v2 1/1] docs/sp_SP: Add translation of
 process/researcher-guidelines
In-Reply-To: <20230621171457.443362-2-avadhut.naik@amd.com>
References: <20230621171457.443362-1-avadhut.naik@amd.com>
 <20230621171457.443362-2-avadhut.naik@amd.com>
Date:   Fri, 14 Jul 2023 13:42:39 -0600
Message-ID: <87v8emxosw.fsf@meer.lwn.net>
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

Avadhut Naik <avadhut.naik@amd.com> writes:

> From: Avadhut Naik <Avadhut.Naik@amd.com>
>
> Translate Documentation/process/researcher-guidelines.rst into Spanish
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../sp_SP/process/researcher-guidelines.rst   | 152 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst

I've  applied this, with one tweak:

> diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
> index 0bdeb1eb4403..ed6851892661 100644
> --- a/Documentation/translations/sp_SP/process/index.rst
> +++ b/Documentation/translations/sp_SP/process/index.rst
> @@ -20,3 +20,4 @@
>     programming-language
>     deprecated
>     adding-syscalls
> +   researcher-guidelines
> diff --git a/Documentation/translations/sp_SP/process/researcher-guidelines.rst b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
> new file mode 100644
> index 000000000000..9d374c70348c
> --- /dev/null
> +++ b/Documentation/translations/sp_SP/process/researcher-guidelines.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Original: :ref:`Documentation/process/researcher-guidelines.rst`
> +:Translator: Avadhut Naik <avadhut.naik@amd.com>
> +
> +.. _sp_researcher_guidelines:

I really don't know how this business of adding useless labels at the
top of documents got started, but I'd like it to stop...this label isn't
used anywhere and won't be, so I took it out.

(Yes, the original has such a label, it shouldn't be there either).

Thanks,

jon
