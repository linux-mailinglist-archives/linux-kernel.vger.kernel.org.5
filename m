Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F716779895
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbjHKUah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjHKUae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:30:34 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C19110DF;
        Fri, 11 Aug 2023 13:30:34 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D3253735;
        Fri, 11 Aug 2023 20:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3253735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691785834; bh=akFqlDnAZSEDeOkT/rGEax3CNW9VVCMY0SZLWMdAuRE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dl7ekD+Swty4fpvtIQVdXQmSfETlRA1HiBbX2ZHpBkK7Jo8FH8/RDscIaFYsRtl6J
         O2b6ij21gt1Mm0jip7+1ZtAH9LHmfqPNTPAt5YcTdDH330lYFBz1r12dYFWI1pbZtS
         8TPT1pJdOwXZgwCXT4D/njCz2ugMcSR8BNs44mlKD99wGak5HQ+qKoyKtb4s3EqWJh
         rI1fjg0UEffhXOwMR/d2ibBogEOXUkv5EKmejFC4Hof9lPygbjeZ0v12Pqos7QCqN0
         AEFB60INFnr4s5mOh11mHL+6/cEzWxoIXYTJZi5bPikDX7yMsb52Uc0JjYGqcpZR2m
         pr3DjMVI2Q7Sg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs: Add book to process/kernel-docs.rst
In-Reply-To: <20230803142417.965313-1-carlos.bilbao@amd.com>
References: <20230803142417.965313-1-carlos.bilbao@amd.com>
Date:   Fri, 11 Aug 2023 14:30:33 -0600
Message-ID: <87leehxqxi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Include to process/kernel-docs.rst a book on Linux system administration
> published in May, 2023 (with ISBN 978-1098109035).
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/process/kernel-docs.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 46f927aae6eb..26ead9d31c01 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -118,6 +118,15 @@ Published books
>        :ISBN: 978-0672329463
>        :Notes: Foundational book
>  
> +    * Title: **Practical Linux System Administration: A Guide to Installation, Configuration, and Management, 1st Edition**
> +
> +      :Author: Kenneth Hess
> +      :Publisher: O'Reilly Media
> +      :Date: May, 2023
> +      :Pages: 246
> +      :ISBN: 978-1098109035
> +      :Notes: System administration
> +
>  .. _ldd3_published:

Applied, thanks.

jon
